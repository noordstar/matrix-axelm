module Internal.Api.JoinedMembers.V1_1.Upcast exposing (..)

import Dict
import Internal.Api.JoinedMembers.V1_1.Objects as O
import Internal.Api.JoinedMembers.V1_1.SpecObjects as SO


upcast : () -> O.RoomMemberList
upcast _ =
    { joined = Dict.empty }
