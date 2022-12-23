module Internal.Api.VersionControl exposing (..)

import Internal.Values.Exceptions as X
import Task exposing (Task)


type alias FinalPackage in out =
    { supportedVersions : List String
    , getEvent : String -> in -> Task X.Error out
    }

type alias SingleVersion pIn pOut cIn cOut =
    { version : String
    , downcast : cIn -> pIn
    , current : cIn -> Task X.Error cOut
    , upcast : pOut -> cOut
    }

firstVersion : SingleVersion () () in out -> FinalPackage in out
firstVersion packet =
    { supportedVersions = [packet.version]
    , getEvent =
        (\version ->
            if packet.version == version then
                packet.current
            else
                \_ -> Task.fail X.UnsupportedVersion
        )
    }

updateWith : SingleVersion pIn pOut in out -> FinalPackage pIn pOut -> FinalPackage in out
updateWith packet oldFinal =
    { supportedVersions = packet.version :: oldFinal.supportedVersions
    , getEvent =
        (\version ->
            if packet.version == version then
                packet.current
            else
                packet.downcast >> oldFinal.getEvent version >> Task.map packet.upcast
        )
    }

toFunction : FinalPackage in out -> List String -> in -> Task X.Error out
toFunction final versions x =
    let
        bestVersion : Maybe String
        bestVersion =
            versions
            |> List.filter (\c -> List.member c final.supportedVersions)
            |> List.head
    in
        case bestVersion of
            Nothing ->
                Task.fail X.UnsupportedVersion
            
            Just version ->
                final.getEvent version x
