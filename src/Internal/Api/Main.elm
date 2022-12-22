module Internal.Api.Main exposing (..)

import Internal.Api.V1_1.Api as V1_1
import Internal.Api.V1_2.Api as V1_2
import Internal.Api.V1_3.Api as V1_3
import Internal.Api.V1_2.Objects as O
import Internal.Api.VersionControl exposing (..)
import Internal.Values.Exceptions as X
import Task exposing (Task)


type alias FinalPackage a =
    { supportedVersions : List String
    , sync : String -> SyncInput -> Task X.Error a
    }


package : FinalPackage O.Sync
package =
    getVersion V1_1.packet
        |> updateWith V1_2.packet
        |> updateWith V1_3.packet


getVersion : VersionPacket x a -> FinalPackage a
getVersion vp =
    { supportedVersions = [ vp.version ]
    , sync =
        \version ->
            if vp.version == version then
                vp.sync

            else
                \_ -> Task.fail X.UnknownVersion
    }


updateWith : VersionPacket a b -> FinalPackage a -> FinalPackage b
updateWith vp oldPackage =
    { supportedVersions = vp.version :: oldPackage.supportedVersions
    , sync =
        \version ->
            if vp.version == version then
                vp.sync

            else
                oldPackage.sync version >> Task.map vp.upcastSync
    }
