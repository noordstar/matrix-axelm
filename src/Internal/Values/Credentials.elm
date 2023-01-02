module Internal.Values.Credentials exposing (..)

import Dict
import Internal.Api.Sync.V1_5.Objects as O
import Internal.Values.Event as Event exposing (Event)
import Internal.Values.Room as Room exposing (Room)


type Credentials
    = Credentials CredentialsRecord


type alias CredentialsRecord =
    { accessToken : AccessToken
    , accountData : List O.BlindEvent
    , baseUrl : String
    , invitations : Dict.Dict String ()
    , mostRecentSync : List Event
    , nextBatch : Maybe String
    , knockedRooms : Dict.Dict String ()
    , leftRooms : Dict.Dict String ()
    , presence : List O.BlindEvent
    , rooms : Dict.Dict String Room
    , settings : CredentialsSettings
    , supportedVersions : List String
    }


defaultCredentials : CredentialsRecord
defaultCredentials =
    { accessToken = NoValidDetails
    , accountData = []
    , baseUrl = ""
    , invitations = Dict.empty
    , knockedRooms = Dict.empty
    , leftRooms = Dict.empty
    , mostRecentSync = []
    , nextBatch = Nothing
    , presence = []
    , rooms = Dict.empty
    , settings =
        { deviceName = "Elm SDK"
        , syncTimeout = 30000
        }
    , supportedVersions =
        [ "v1.1", "v1.2", "v1.3", "v1.4", "v1.5" ]
            |> List.reverse
    }

type alias CredentialsSettings =
    { deviceName : String
    , syncTimeout : Int
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


{-| Get the new events that were received at the most recent sync.
-}
mostRecentSync : Credentials -> List Event
mostRecentSync (Credentials cred) =
    cred.mostRecentSync


{-| Get a room by its room id
-}
getRoomById : String -> Credentials -> Maybe Room
getRoomById roomId (Credentials cred) =
    Dict.get roomId cred.rooms

{-| Update device name
-}
loginAsDeviceName : String -> Credentials -> Credentials
loginAsDeviceName deviceName (Credentials cred) =
    cred.settings
        |> (\x -> { x | deviceName = deviceName })
        |> (\x -> { cred | settings = x })
        |> Credentials

