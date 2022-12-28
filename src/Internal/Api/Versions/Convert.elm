module Internal.Api.Versions.V_all.Convert exposing (..)

import Internal.Api.Versions.V_all.Objects as O
import Internal.Api.Versions.V_all.SpecObjects as SO
import Dict
import Set

implementedVersions : List String
implementedVersions =
    [ "v1.5", "v1.4", "v1.3", "v1.2", "v1.1" ]

convert : SO.Versions -> O.Versions
convert versions =
    { supportedVersions =
        implementedVersions
        |> List.filter (\v -> List.member v versions.versions)
    , unstableFeatures =
        versions.unstableFeatures
        |> Maybe.withDefault Dict.empty
        |> Dict.toList
        |> List.filterMap
            (\(name, enabled) ->
                if enabled then
                    Just name
                else
                    Nothing
            )
        |> Set.fromList
    }

