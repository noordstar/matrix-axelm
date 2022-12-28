module Internal.Values.ErrorStrings exposing (..)


cannotSyncWithoutAccessToken : String
cannotSyncWithoutAccessToken =
    "UNABLE TO SYNC: you haven't provided login information yet."


couldNotGetTimestamp : String
couldNotGetTimestamp =
    "TIMESTAMP FAILED: Could not get the current Unix timestamp."


serverReturnsBadJSON : String -> String
serverReturnsBadJSON =
    (++) "BAD JSON:\n\n"


serverSaysForbidden : Maybe String -> String
serverSaysForbidden error =
    case error of
        Nothing ->
            "Server returns M_FORBIDDEN"

        Just err ->
            "M_FORBIDDEN : " ++ err



-- serverSaysUnknownToken : Maybe String -> String
-- serverSaysUnknownToken error =
--     case error


unsupportedVersion : String
unsupportedVersion =
    "UNSUPPORTED HOMESERVER: the homeserver only supports Spec versions that this library doesn't support."
