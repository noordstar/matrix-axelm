module Internal.Api.GetEvent.V1_4.Upcast exposing (..)

import Internal.Api.GetEvent.V1_3.Objects as PO
import Internal.Api.GetEvent.V1_4.Objects as O


upcast : PO.OldBlindEvent -> O.OldBlindEvent
upcast e =
    { content = e.content
    , eventId = e.eventId
    , originServerTs = e.originServerTs
    , roomId = e.roomId
    , sender = e.sender
    , stateKey = e.stateKey
    , contentType = e.contentType
    , unsigned = Maybe.map upcastUnsigned e.unsigned
    }


upcastUnsigned : PO.UnsignedData -> O.UnsignedData
upcastUnsigned (PO.UnsignedData u) =
    O.UnsignedData
        { age = u.age
        , prevContent = u.prevContent
        , redactedBecause = Maybe.map upcast u.redactedBecause
        , transactionId = u.transactionId
        }
