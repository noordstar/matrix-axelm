module Internal.Api.JoinedMembers.V1_2.Upcast exposing (..)

import Internal.Api.JoinedMembers.V1_1.Objects as PO
import Internal.Api.JoinedMembers.V1_2.Objects as O


upcast : PO.RoomMemberList -> O.RoomMemberList
upcast =
    identity
