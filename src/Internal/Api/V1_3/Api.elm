module Internal.Api.V1_3.Api exposing (..)

import Internal.Api.V1_2.Api as PApi
import Internal.Api.V1_2.Objects as PO
import Internal.Api.VersionControl exposing (..)

packet : VersionPacket PO.Sync PO.Sync
packet =
    { version = "v1.3"
    , sync = PApi.sync
    , upcastSync = identity
    }

