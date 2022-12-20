module Internal.Credentials exposing (..)

{-| Credentials type that manages all user data.
-}


type Credentials
    = Credentials CredentialsRecord


{-| Updater type that can update credentials.
-}
type alias Updater msg =
    (Credentials -> Credentials) -> msg


{-| Updater type that either has an error string or can update credentials.
-}
type alias Response =
    Result String (Credentials -> Credentials)


{-| Structure of the data stored in Credentials.
-}
type alias CredentialsRecord =
    { accessToken : AccessToken
    , baseUrl : String
    , nextBatch : Maybe String
    }


{-| Helper function to create "default" settings
-}
defaultCredentials : CredentialsRecord
defaultCredentials =
    { accessToken = NoValidDetails
    , baseUrl = ""
    , nextBatch = Nothing
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


{-| Get the latest /sync endpoint
-}
sync : (Response -> msg) -> Credentials -> Cmd msg
sync _ (Credentials _) =
    Cmd.none



-- TODO: Not implemented yet
-- {-| Get a list of rooms the user has joined.
-- -}
-- joinedRooms : Credentials -> List O.Room
-- joinedRooms (Credentials c) =
--     []
