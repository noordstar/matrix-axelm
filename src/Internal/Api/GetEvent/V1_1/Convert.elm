module Internal.Api.GetEvent.V1_1.Convert exposing (convert)

import Internal.Api.GetEvent.V1_1.Objects as O
import Internal.Api.GetEvent.V1_1.SpecObjects as SO


convert : SO.Event -> O.BlindEvent
convert =
    identity
