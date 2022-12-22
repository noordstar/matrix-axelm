module Internal.Api.GetEvent.V1_3.Convert exposing (..)

import Internal.Api.GetEvent.V1_3.Objects as O
import Internal.Api.GetEvent.V1_3.SpecObjects as SO


convert : SO.ClientEvent -> O.OldBlindEvent
convert e =
    { content = e.content
    , eventId = Just e.eventId
    , originServerTs = Just e.originServerTs
    , roomId = Just e.roomId
    , sender = Just e.sender
    , stateKey = e.stateKey
    , contentType = e.contentType
    , unsigned = Maybe.map convertUnsigned e.unsigned
    }


convertUnsigned : SO.UnsignedData -> O.UnsignedData
convertUnsigned (SO.UnsignedData u) =
    O.UnsignedData
        { age = u.age
        , prevContent = u.prevContent
        , redactedBecause = Maybe.map convert u.redactedBecause
        , transactionId = u.transactionId
        }
