module Internal.Values.Credentials exposing (..)

import Dict
import Internal.Api.Sync.V1_5.Objects as O
import Internal.Values.Room as Room exposing (Room)


type Credentials
    = Credentials CredentialsRecord


type alias CredentialsRecord =
    { accessToken : AccessToken
    , accountData : List O.BlindEvent
    , baseUrl : String
    , nextBatch : Maybe String
    , presence : List O.BlindEvent
    , rooms : Dict.Dict String Room
    , supportedVersions : List String
    , invitations : Dict.Dict String ()
    , knockedRooms : Dict.Dict String ()
    , leftRooms : Dict.Dict String ()
    }


defaultCredentials : CredentialsRecord
defaultCredentials =
    { accessToken = NoValidDetails
    , accountData = []
    , baseUrl = ""
    , invitations = Dict.empty
    , knockedRooms = Dict.empty
    , leftRooms = Dict.empty
    , nextBatch = Nothing
    , presence = []
    , rooms = Dict.empty
    , supportedVersions = []
    }


type AccessToken
    = Token String
    | NoValidDetails
    | UsernameAndPassword { username : String, password : String, accessToken : Maybe String }


{-| Create new credentials from an access token.
-}
fromAccessToken : String -> String -> Credentials
fromAccessToken baseUrl accessToken =
    Credentials
        { defaultCredentials
            | accessToken = Token accessToken
            , baseUrl = baseUrl
        }


{-| Create new credentials using a username and a password.
-}
withUsernameAndPassword : String -> String -> String -> Credentials
withUsernameAndPassword baseUrl username password =
    Credentials
        { defaultCredentials
            | accessToken =
                UsernameAndPassword
                    { username = username
                    , password = password
                    , accessToken = Nothing
                    }
            , baseUrl = baseUrl
        }
