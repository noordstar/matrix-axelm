module Internal.Api.VersionControl exposing (..)

import Internal.Values.Exceptions exposing (Error)
import Internal.Values.SpecEnums as Enums
import Task exposing (Task)


type alias VersionPacket prevSync currSync =
    { version : String
    , sync : SyncInput -> Task Error currSync
    , upcastSync : prevSync -> currSync
    }


type alias SyncInput =
    { baseUrl : String
    , accessToken : String
    , filter : Maybe String
    , fullState : Maybe Bool
    , setPresence : Maybe Enums.UserPresence
    , since : Maybe String
    , timeout : Maybe Int
    }
