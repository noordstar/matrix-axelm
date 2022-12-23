module Internal.Api.All exposing (..)

{-| This module lists all available functions to reach the Matrix API.
-}

import Internal.Api.GetEvent.Main as GetEvent
import Internal.Api.JoinedMembers.Main as JoinedMembers
import Internal.Api.SendMessageEvent.Main as SendMessageEvent
import Internal.Api.SendStateKey.Main as SendStateKey


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

{-| Send a message event to a room.
-}
sendMessageEvent : Versions -> SendMessageEvent.SendMessageEventInput -> SendMessageEvent.SendMessageEventOutput
sendMessageEvent =
    SendMessageEvent.sendMessageEvent

{-| Send a state event to a room.
-}
sendStateEvent : Versions -> SendStateKey.SendStateKeyInput -> SendStateKey.SendStateKeyOutput
sendStateEvent =
    SendStateKey.sendStateKey
