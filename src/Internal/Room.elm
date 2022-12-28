module Internal.Room exposing (..)

import Internal.Api.Sync.V1_5.Objects as O
import Internal.Event as Event
import Internal.Values.Event as Event exposing (Event(..))
import Internal.Values.Room as Room exposing (Room(..))
import Dict

createNewRoom : String -> O.JoinedRoom -> Room
createNewRoom roomId joinedRoom =
    updateRoom
        joinedRoom
        ( Room
            { accountData = joinedRoom.accountData
            , ephemeral = joinedRoom.ephemeral
            , events = Dict.empty
            , startOfTime = 
                List.map
                    (Event.fromClientEventWithoutRoomId roomId) 
                    joinedRoom.state
            , timeline = []
            }
        )

updateRoom : O.JoinedRoom -> Room -> Room
updateRoom joinedRoom (Room room) =
    let
        stateAtStart : List Event
        stateAtStart =
            List.map (Event.fromClientEventWithoutRoomId roomId) joinedRoom.state
        
        timelineEvents : List Event
        timelineEvents =
            joinedRoom.timeline
            |> Maybe.map .events
            |> Maybe.withDefault []
            |> List.map (Event.fromClientEventWithoutRoomId roomId)
    in
        Room
            { accountData = joinedRoom.accountData
            , ephemeral = joinedRoom.ephemeral
            , events =
                room.events
                |> updateEventsWith stateAtStart
                |> updateEventsWith timelineEvents
            , startOfTime = room.startOfTime
            , timeline =
                room.timeline
                |> extendTimeline timelineEvents
            }

updateEventsWith : List Event -> Dict String Events -> Dict String Events
updateEventsWith events knownEvents =
    events
    |> List.filterMap
        (\(Event event) -> Maybe.map (\eId -> (eId, Event event) event.eventId))
    |> Dict.fromList
    |> (\d -> Dict.union d knownEvents)

extendTimeline : String -> O.Timeline -> List Event -> List Room.TimelinePiece -> List Room.TimelinePiece
extendTimeline nextBatch timelineDelta stateDeltaAtStart timeline =
    timelineDelta
    |> .events
    |> List.map
        (\(Event event) ->
            case event.eventId of
                Just eId ->
                    Room.TimelineEvent eId
                
                Nothing ->
                    Room.BlindEvent
                        { content = event.content
                        , contentType = event.contentType
                        }
        )
    |> (\events -> 
        (++)
            events
            [ Room.BatchBorder { sinceParam = nextBatch, deltaState = [] }]
    )
    |> (\newEvents ->
        case List.reverse timeline of
            [] ->
                case timelineDelta.prevBatch of
                    Just p ->
                        ( Room.BatchBorder
                            { sinceParam = p, deltaState = stateDeltaAtStart }
                        ) :: newEvents
                    Nothing ->
                        newEvents
            
            (Room.BatchBorder data) :: tail ->
                case data.prevBatch of
                    Nothing ->
                        newEvents
                    
                    Just p ->
                        case timelineDelta.prevBatch of
                            Just cp ->
                                if p == cp then
                                    -- Just add
                                else
                                    (++)
                                        (timeline ++ [ Room.Gap { from = p, to = cp }])
                                        ((Room.BatchBorder {}) :: newEvents)
                            
                            Nothing ->
                                -- Just add

    )


extendTimeline : String -> O.Timeline -> List Room.TimelinePiece -> List Room.TimelinePiece
extendTimeline nextBatch events timeline =
    events
    |> List.map
        (\(Event event) ->
            case event.eventId of
                Just eId ->
                    Room.TimelineEvent eId

                Nothing ->
                    Room.BlindEvent
                        { content = event.content
                        , contentType = event.contentType
                        }
        )
    |> (\timelinePart ->
        case List.reverse timeline of
            [] ->
                (++)
                    timelinePart
                    [ Room.BatchBorder 
                        { sinceParam = nextBatch, deltaState = [] } 
                    ]
            
            (Room.BatchBorder data) :: tail ->
                (++)
                    timeline
                    (extendTimeline nextBatch events [])
    )

