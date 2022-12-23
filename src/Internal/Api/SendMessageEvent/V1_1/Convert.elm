module Internal.Api.SendMessageEvent.V1_1.Convert exposing (..)

import Internal.Api.SendMessageEvent.V1_1.Objects as O
import Internal.Api.SendMessageEvent.V1_1.SpecObjects as SO


convert : SO.EventResponse -> O.EventResponse
convert =
    identity
