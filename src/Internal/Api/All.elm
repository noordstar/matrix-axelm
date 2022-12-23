module Internal.Api.All exposing (..)

{-| This module lists all available functions to reach the Matrix API.
-}

import Internal.Api.GetEvent.Main as GetEvent
import Internal.Api.JoinedMembers.Main as JoinedMembers


type alias Versions =
    List String


{-| Get a particular event by its event id and room id.
-}
getEvent : Versions -> GetEvent.EventInput -> GetEvent.EventOutput
getEvent =
    GetEvent.getEvent


{-| Get information on all users who joined a room.
-}
joinedMembers : Versions -> JoinedMembers.JoinedMembersInput -> JoinedMembers.JoinedMembersOutput
joinedMembers =
    JoinedMembers.joinedMembers