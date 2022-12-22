module Internal.Api.JoinedMembers.V1_2.Api exposing (..)

import Internal.Api.JoinedMembers.Api as Api
import Internal.Api.JoinedMembers.V1_1.Objects as PO
import Internal.Api.JoinedMembers.V1_2.Convert as C
import Internal.Api.JoinedMembers.V1_2.Objects as O
import Internal.Api.JoinedMembers.V1_2.SpecObjects as SO
import Internal.Api.JoinedMembers.V1_2.Upcast as U
import Internal.Api.VersionControl as V


packet : V.GetEventVersion Api.JoinedMembersInputV1 PO.RoomMemberList Api.JoinedMembersInputV1 O.RoomMemberList
packet =
    { version = "v1.2"
    , downcast = identity
    , current = Api.joinedMembersInputV1 SO.roomMemberListDecoder C.convert
    , upcast = U.upcast
    }
