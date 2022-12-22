module Internal.Api.GetEvent.V1_4.Api exposing (..)

import Internal.Api.GetEvent.Api as Api
import Internal.Api.GetEvent.V1_3.Objects as PO
import Internal.Api.GetEvent.V1_4.Convert as C
import Internal.Api.GetEvent.V1_4.Objects as O
import Internal.Api.GetEvent.V1_4.SpecObjects as SO
import Internal.Api.GetEvent.V1_4.Upcast as U
import Internal.Api.VersionControl as V


packet : V.GetEventVersion Api.GetEventInputV1 PO.OldBlindEvent Api.GetEventInputV1 O.OldBlindEvent
packet =
    { version = "v1.4"
    , downcast = identity
    , current = Api.getEventInputV1 SO.clientEventDecoder C.convert
    , upcast = U.upcast
    }
