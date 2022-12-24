module Internal.Api.Sync.V1_1.Upcast exposing (..)

import Internal.Api.Sync.V1_1.Objects as O


upcast : () -> O.Sync
upcast _ =
    { accountData = []
    , nextBatch = "invalid-version"
    , presence = []
    , rooms = Nothing
    }
