module Internal.Credentials exposing (..)

{-| Credentials type that manages all user data.
-}


type Credentials
    = Credentials
        { accessToken : String
        , baseUrl : String
        , nextBatch : Maybe String
        }


{-| Create new credentials from an access token.
-}
fromAccessToken : String -> String -> Credentials
fromAccessToken baseUrl accessToken =
    Credentials
        { accessToken = accessToken
        , baseUrl = baseUrl
        , nextBatch = Nothing
        }


{-| Get the latest /sync endpoint
-}
sync : ((Credentials -> Credentials) -> msg) -> Credentials -> Cmd msg
sync _ _ =
    Cmd.none    -- TODO
