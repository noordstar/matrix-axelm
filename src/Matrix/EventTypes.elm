module Matrix.EventTypes exposing (MRoomName)

{-| There are lots of kinds of event types that can be shared on Matrix.

This module will help you get started by decoding the most common types.


# Room information

The following event types are defined by the Matrix spec.


## m.room.name

A room has an opaque room ID which is not human-friendly to read. A room alias is human-friendly, but not all rooms have room aliases. The room name is a human-friendly string designed to be displayed to the end-user. The room name is not unique, as multiple rooms can have the same room name set.

A room with an `m.room.name` event with an absent, null, or empty name field should be treated the same as a room with no `m.room.name` event.

An event of this type is automatically created when creating a room using `/createRoom` with the name key.

@docs MRoomName

-}

import Internal.Values.EventTypes
import Json.Decode as D
import Json.Encode as E


{-| Get the room name event.
-}
type alias MRoomName =
    { name : String
    }


{-| Encode the `m.room.name` event into a JSON value.
-}
encodeMRoomName : MRoomName -> E.Value
encodeMRoomName =
    Internal.Values.EventTypes.encodeMRoomName


{-| Decoder for the `m.room.name` event.
-}
mRoomNameDecoder : D.Decoder MRoomName
mRoomNameDecoder =
    Internal.Values.EventTypes.mRoomNameDecoder
