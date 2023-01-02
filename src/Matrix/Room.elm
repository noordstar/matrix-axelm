module Matrix.Room exposing
    ( Room
    , getRoomId, getRoomName
    )

{-| In the Room module, you can view, edit and manipulate rooms.


# Room

@docs Room


# Getting info

@docs getRoomId, getRoomName


# Getting room state

The state of the room tells us all about the state that the room is in.

-}

import Internal.Room
import Internal.Values.Event exposing (Event)
import Internal.Values.Room
import Json.Encode as E


{-| The Room type represents a Matrix room that a user is/was a part of.

This Room is usually up to date with the latest sync.

-}
type alias Room =
    Internal.Values.Room.Room


{-| Get the room ID of a Matrix room.
-}
getRoomId : Room -> String
getRoomId =
    Internal.Room.getRoomId


{-| Get the room name of a Matrix room. Returns `Nothing` if the room name doesn't exist.
-}
getRoomName : Room -> Maybe String
getRoomName =
    Internal.Room.getRoomName


{-| Get a state event value.
-}
getStateEvent : Room -> String -> String -> Maybe Event
getStateEvent =
    Internal.Room.getStateKey
