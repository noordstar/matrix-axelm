module Internal.Api.Versions.Objects exposing (..)

import Dict exposing (Dict)
import Set exposing (Set)


type alias Versions =
    { supportedVersions : List String
    , unstableFeatures : Set String
    }
