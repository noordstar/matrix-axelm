module Internal.Api.SendStateKey.V1_1.Upcast exposing (..)

import Internal.Api.SendStateKey.V1_1.Objects as O


upcast : () -> O.EventResponse
upcast _ =
    { eventId = "!unknown-version:example.org" }
