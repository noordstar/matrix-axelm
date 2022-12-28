module Internal.Values.StateManager exposing (..)

import Dict exposing (Dict)
import Internal.Api.Sync.V1_5.Objects as O
import Internal.Values.Event exposing (Event(..))

type alias StateEventManager = Dict (String, String) Event

getStateEvent : String -> String -> StateEventManager -> Maybe Event
getStateEvent eventType stateKey =
    Dict.get (eventType, stateKey)

updateRoomStateWith : StateEventManager -> StateEventManager -> StateEventManager
updateRoomStateWith = Dict.union

toRoomState : List Event -> StateEventManager
toRoomState =
    List.filterMap
        (\(Event event) ->
            event.stateKey
            |> Maybe.map
                (\key ->
                    ((event.contentType, key), Event event)
                )
        )
    >> Dict.fromList

type alias EventManager = Dict String O.BlindEvent

getEvent : String -> EventManager -> Maybe O.BlindEvent
getEvent = Dict.get
        
updateEventManagerWith : EventManager -> EventManager -> EventManager
updateEventManagerWith = Dict.union

toEventManager : List O.BlindEvent -> EventManager
toEventManager =
    List.map (\event -> (event.contentType, event)) >> Dict.fromList
