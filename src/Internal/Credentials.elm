module Internal.Credentials exposing (..)

import Internal.Api.All as Api
import Internal.Api.Sync.V1_5.Objects as O
import Internal.Values.Credentials exposing (AccessToken(..), Credentials(..))
import Internal.Values.Exceptions as X
import Internal.Values.Names exposing (Response)
import Task exposing (Task)


sync : (Response -> msg) -> Credentials -> Cmd msg
sync onResponse ((Credentials c) as credentials) =
    syncTask credentials
        |> Task.attempt
            (\result ->
                case result of
                    Err e ->
                        onResponse (Err e)

                    Ok sy ->
                        (\(Credentials cred) ->
                            Credentials
                                { cred
                                    | accountData = sy.accountData
                                    , nextBatch = Just sy.nextBatch
                                    , presence = sy.presence
                                }
                        )
                            |> Ok
                            |> onResponse
            )


syncTask : Credentials -> Task X.Error O.Sync
syncTask (Credentials cred) =
    case cred.accessToken of
        NoValidDetails ->
            "Cannot sync while no login/access token have been given."
                |> X.InsufficientCredentials
                |> X.SDKException
                |> Task.fail

        Token token ->
            Api.sync
                cred.supportedVersions
                { accessToken = token
                , baseUrl = cred.baseUrl
                , filter = Nothing
                , fullState = Nothing
                , setPresence = Nothing
                , since = cred.nextBatch
                , timeout = Just 10000
                }

        UsernameAndPassword { username, password, accessToken } ->
            case accessToken of
                Just token ->
                    syncTask (Credentials { cred | accessToken = Token token })

                Nothing ->
                    -- TODO: Login before syncing
                    "Credentials need to log in first"
                        |> X.NotSupportedYet
                        |> X.SDKException
                        |> Task.fail
