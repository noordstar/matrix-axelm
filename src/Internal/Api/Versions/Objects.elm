module Internal.Api.Versions.V_all.Objects exposing (..)

import Dict exposing (Dict)
import Set exposing (Set)


type alias Versions =
    { supportedVersions : List String
    , unstableFeatures : Set String
    }
