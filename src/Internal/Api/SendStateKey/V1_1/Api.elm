module Internal.Api.SendStateKey.V1_1.Api exposing (..)

import Internal.Api.SendStateKey.Api as Api
import Internal.Api.SendStateKey.V1_1.Convert as C
import Internal.Api.SendStateKey.V1_1.Objects as O
import Internal.Api.SendStateKey.V1_1.Upcast as U
import Internal.Api.VersionControl as V


packet : V.SingleVersion () () Api.SendStateKeyInputV1 O.EventResponse
packet =
    { version = "v1.1"
    , downcast = \_ -> ()
    , current = Api.sendStateKeyV1 O.eventResponseDecoder C.convert
    , upcast = U.upcast
    }
