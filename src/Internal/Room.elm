module Internal.Room exposing (..)

import Dict
import Internal.Api.Sync.V1_5.Objects as O
import Internal.Event as Event
import Internal.Values.Event as Event exposing (Event(..))
import Internal.Values.Room as Room exposing (Room(..))
import Internal.Values.StateManager as S


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
