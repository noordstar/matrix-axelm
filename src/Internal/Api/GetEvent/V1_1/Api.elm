module Internal.Api.GetEvent.V1_1.Api exposing (..)

import Internal.Api.GetEvent.Api as Api
import Internal.Api.GetEvent.V1_1.Convert as C
import Internal.Api.GetEvent.V1_1.Objects as O
import Internal.Api.GetEvent.V1_1.SpecObjects as SO
import Internal.Api.GetEvent.V1_1.Upcast as U
import Internal.Api.VersionControl as V


packet : V.SingleVersion () () Api.GetEventInputV1 O.BlindEvent
packet =
    { version = "v1.1"
    , downcast = \_ -> ()
    , current = Api.getEventInputV1 SO.eventDecoder C.convert
    , upcast = U.upcast
    }
