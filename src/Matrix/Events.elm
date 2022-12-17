module Matrix.Events exposing (..)

{-|


# Matrix Events

Matrix contains a large number of events, each with different rules on how to decode them.
Additionally, these events are sent by unknown Matrix users, which means their
content is not always to be trusted. This is tricky!

This file addresses a large list of event types. If you extract an event's content,
you can use the functions here to interpret them. All events will be `Value` types from
the `elm/json` library though, so you can always try and decode them yourself!


# m.room.name

@docs RoomName, decodeRoomName, getRoomName


# m.room.topic

@docs RoomTopic, decodeRoomTopic, getRoomTopic

-}

import Internal.Events as Internal
import Json.Encode exposing (Value)


{-| The `m.room.name` event holds the room name.
The room name is a human-friendly string designed to be displayed to the end-user.
-}
type alias RoomName =
    Internal.RoomName


{-| Using this function, you can decode `m.room.name` event types, if properly formatted.
-}
decodeRoomName : Value -> Result String RoomName
decodeRoomName =
    Internal.decodeWith Internal.roomNameDecoder


{-| Get the room name as a string. Results in `Nothing` if the room explicitly
does not have a name.
-}
getRoomName : RoomName -> Maybe String
getRoomName =
    Internal.getRoomName


{-| The `m.room.topic` event holds the room topic.
The room topic is a short message detailing what is currently being discussed in the room.
-}
type alias RoomTopic =
    Internal.RoomTopic


{-| Using this function, you can decode `m.room.name` event types, if properly formatted.
-}
decodeRoomTopic : Value -> Result String RoomTopic
decodeRoomTopic =
    Internal.decodeWith Internal.roomTopicDecoder


{-| Get the room topic as a string.
-}
getRoomTopic : RoomTopic -> String
getRoomTopic =
    Internal.getRoomTopic
