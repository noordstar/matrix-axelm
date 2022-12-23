module Internal.Api.SendMessageEvent.V1_2.Upcast exposing (..)

import Internal.Api.SendMessageEvent.V1_1.Objects as PO
import Internal.Api.SendMessageEvent.V1_2.Objects as O


upcast : PO.EventResponse -> O.EventResponse
upcast =
    identity
