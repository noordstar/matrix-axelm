module Internal.Api.GetEvent.V1_1.Upcast exposing (upcast)

import Internal.Api.GetEvent.V1_1.Objects as O
import Json.Encode as E


upcast : () -> O.BlindEvent
upcast _ =
    { content = E.object []
    , contentType = "com.realbram.unknown.upcast"
    }
