module Internal.Api.JoinedMembers.V1_1.Convert exposing (..)

import Internal.Api.JoinedMembers.V1_1.Objects as O
import Internal.Api.JoinedMembers.V1_1.SpecObjects as SO


convert : SO.RoomMemberList -> O.RoomMemberList
convert =
    identity
