module Matrix.Event exposing (..)

{-| The event is a central piece in the infrastructure of the Matrix ecosystem.
This module helps you view, edit, create and manipulate events.


# Event

@docs Event


## Getting information

@docs eventId, roomId

-}

import Internal.Values.Event


{-| The central event type.
-}
type alias Event =
    Internal.Values.Event.Event


{-| Get the event's id.

Surprisingly, even though every event MUST have an id, the API does not always
provide the id with events, especially for older API versions.

-}
eventId : Event -> Maybe String
eventId =
    Internal.Values.Event.eventId


{-| Get the ID of the room that the event was sent in.
-}
roomId : Event -> String
roomId =
    Internal.Values.Event.roomId
