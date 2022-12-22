module Internal.Api.GetEvent.V1_2.Upcast exposing (..)

import Internal.Api.GetEvent.V1_1.Objects as PO
import Internal.Api.GetEvent.V1_2.Objects as O


upcast : PO.BlindEvent -> O.OldBlindEvent
upcast e =
    { content = e.content
    , eventId = Nothing
    , originServerTs = Nothing
    , roomId = Nothing
    , sender = Nothing
    , stateKey = Nothing
    , contentType = e.contentType
    , unsigned = Nothing
    }
