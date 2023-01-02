module Internal.Room exposing (..)

import Dict
import Internal.Api.Sync.V1_5.Objects as O
import Internal.Event as Event
import Internal.Values.Event as Event exposing (Event(..))
import Internal.Values.EventTypes as Types
import Internal.Values.Room as Room exposing (Room(..))
import Internal.Values.StateManager as S


getRoomId : Room -> String
getRoomId (Room room) =
    room.roomId


getRoomName : Room -> Maybe String
getRoomName =
    getRoomState
        >> S.getStateEvent "m.room.name" ""
        >> Maybe.andThen (Event.decodeContentWith Types.mRoomNameDecoder)
        >> Maybe.map .name



{- VALUES FOR GETTING THE ROOM STATE -}


getRoomState : Room -> S.StateEventManager
getRoomState (Room room) =
    room.timeline
        |> List.filterMap
            (\piece ->
                case piece of
                    Room.TimelineEvent eventId ->
                        Dict.get eventId room.events

                    _ ->
                        Nothing
            )
        |> S.toRoomState


getRoomStateBeforeEvent : Room -> Event -> S.StateEventManager
getRoomStateBeforeEvent (Room room) (Event event) =
    let
        stopAt : Maybe String -> List Event -> List Event
        stopAt v events =
            case events of
                [] ->
                    []

                (Event ev) :: tail ->
                    if ev.eventId == v then
                        []

                    else
                        Event event :: stopAt v tail
    in
    room.timeline
        |> List.filterMap
            (\piece ->
                case piece of
                    Room.TimelineEvent eventId ->
                        Dict.get eventId room.events

                    _ ->
                        Nothing
            )
        |> stopAt event.eventId
        |> S.toRoomState


getStateKey : Room -> String -> String -> Maybe Event
getStateKey room eventType stateKey =
    getRoomState room
        |> Dict.get ( eventType, stateKey )



{- VALUES FOR SYNCING AND MAINTAINING ROOMS -}


updateRoomWithSync : String -> ( String, O.JoinedRoom ) -> Maybe Room -> Room
updateRoomWithSync nextBatch ( roomId, joinedRoom ) maybeRoom =
    case maybeRoom of
        Just r ->
            updateRoom nextBatch joinedRoom r

        Nothing ->
            createNewRoom nextBatch ( roomId, joinedRoom )


createNewRoom : String -> ( String, O.JoinedRoom ) -> Room
createNewRoom nextBatch ( roomId, joinedRoom ) =
    Room
        { accountData = S.toEventManager joinedRoom.accountData
        , ephemeral = joinedRoom.ephemeral
        , events =
            joinedRoom.timeline
                |> Maybe.map .events
                |> Maybe.withDefault []
                |> (++) joinedRoom.state
                |> List.map (Event.fromClientEventWithoutRoomId roomId)
                |> List.filterMap
                    (\(Event event) ->
                        Maybe.map (\eId -> ( eId, Event event )) event.eventId
                    )
                |> Dict.fromList
        , roomId = roomId
        , startOfTime =
            joinedRoom.state
                |> List.map (Event.fromClientEventWithoutRoomId roomId)
                |> S.toRoomState
        , timeline =
            (joinedRoom.timeline
                |> Maybe.map
                    (\timeline ->
                        (case timeline.prevBatch of
                            Just p ->
                                if timeline.limited then
                                    [ Room.BatchBorder
                                        { sinceParam = p
                                        , deltaState =
                                            joinedRoom.state
                                                |> List.map (Event.fromClientEventWithoutRoomId roomId)
                                        }
                                    ]

                                else
                                    []

                            Nothing ->
                                []
                        )
                            ++ (timeline.events
                                    |> List.map (Event.fromClientEventWithoutRoomId roomId)
                                    |> List.map
                                        (\(Event event) ->
                                            case event.eventId of
                                                Just eId ->
                                                    Room.TimelineEvent eId

                                                Nothing ->
                                                    Room.BlindEvent { content = event.content, contentType = event.contentType }
                                        )
                               )
                    )
                |> Maybe.withDefault []
            )
                ++ [ Room.BatchBorder { sinceParam = nextBatch, deltaState = [] } ]
        }


updateRoom : String -> O.JoinedRoom -> Room -> Room
updateRoom nextBatch joinedRoom (Room room) =
    let
        newRoom =
            ( room.roomId, joinedRoom )
                |> createNewRoom nextBatch
                |> (\(Room r) -> r)
    in
    Room
        { accountData =
            room.accountData
                |> S.updateEventManagerWith newRoom.accountData
        , ephemeral = newRoom.ephemeral
        , events = Dict.union newRoom.events room.events
        , roomId = room.roomId
        , startOfTime = room.startOfTime
        , timeline =
            case ( List.reverse room.timeline, newRoom.timeline ) of
                ( (Room.BatchBorder data1) :: _, (Room.BatchBorder data2) :: tail ) ->
                    if data1.sinceParam == data2.sinceParam then
                        room.timeline ++ tail

                    else
                        (room.timeline ++ [ Room.Gap { from = data1.sinceParam, to = data2.sinceParam } ]) ++ newRoom.timeline

                ( _, _ ) ->
                    room.timeline ++ newRoom.timeline
        }
