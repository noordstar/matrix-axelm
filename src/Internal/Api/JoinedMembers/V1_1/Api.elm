module Internal.Api.JoinedMembers.V1_1.Api exposing (..)

import Internal.Api.JoinedMembers.Api as Api
import Internal.Api.JoinedMembers.V1_1.Convert as C
import Internal.Api.JoinedMembers.V1_1.Objects as O
import Internal.Api.JoinedMembers.V1_1.SpecObjects as SO
import Internal.Api.JoinedMembers.V1_1.Upcast as U
import Internal.Api.VersionControl as V


packet : V.GetEventVersion () () Api.JoinedMembersInputV1 O.RoomMemberList
packet =
    { version = "v1.1"
    , downcast = \_ -> ()
    , current = Api.joinedMembersInputV1 SO.roomMemberListDecoder C.convert
    , upcast = U.upcast
    }
