module Internal.Api.GetEvent.V1_5.Api exposing (..)

import Internal.Api.GetEvent.Api as Api
import Internal.Api.GetEvent.V1_4.Objects as PO
import Internal.Api.GetEvent.V1_5.Convert as C
import Internal.Api.GetEvent.V1_5.Objects as O
import Internal.Api.GetEvent.V1_5.SpecObjects as SO
import Internal.Api.GetEvent.V1_5.Upcast as U
import Internal.Api.VersionControl as V


packet : V.SingleVersion Api.GetEventInputV1 PO.OldBlindEvent Api.GetEventInputV1 O.OldBlindEvent
packet =
    { version = "v1.5"
    , downcast = identity
    , current = Api.getEventInputV1 SO.clientEventDecoder C.convert
    , upcast = U.upcast
    }
