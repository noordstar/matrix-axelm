module Internal.Credentials exposing (..)

import Dict
import Internal.Api.All as Api
import Internal.Api.Sync.V1_5.Objects as O
import Internal.Event as Event
import Internal.Room as Room
import Internal.Values.Credentials as Credentials exposing (AccessToken(..), Credentials(..))
import Internal.Values.Event exposing (Event(..))
import Internal.Values.Exceptions as X
import Internal.Values.Names exposing (Response)
import Task exposing (Task)
import Time


fromAccessToken : String -> String -> Credentials
fromAccessToken =
    Credentials.fromAccessToken


withUsernameAndPassword : String -> String -> String -> Credentials
withUsernameAndPassword =
    Credentials.withUsernameAndPassword


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
                                    , mostRecentSync =
                                        sy.rooms
                                            |> Maybe.map .join
                                            |> Maybe.withDefault Dict.empty
                                            |> Dict.toList
                                            |> List.filterMap
                                                (\( roomId, event ) ->
                                                    event.timeline
                                                        |> Maybe.map (\t -> ( roomId, t.events ))
                                                )
                                            |> List.map
                                                (\( roomId, events ) ->
                                                    events
                                                        |> List.map (Event.fromClientEventWithoutRoomId roomId)
                                                )
                                            |> List.concat
                                            |> List.sortBy
                                                (\(Event event) ->
                                                    ( event.originServerTs
                                                        |> Maybe.map Time.posixToMillis
                                                        |> Maybe.withDefault 0
                                                    , event.unsigned.age
                                                        |> Maybe.withDefault 0
                                                        |> (*) -1
                                                    )
                                                )
                                    , nextBatch = Just sy.nextBatch
                                    , presence = sy.presence
                                    , rooms =
                                        sy.rooms
                                            |> Maybe.map .join
                                            |> Maybe.withDefault Dict.empty
                                            |> Dict.map
                                                (\roomId joinedRoom ->
                                                    Room.updateRoomWithSync
                                                        sy.nextBatch
                                                        ( roomId, joinedRoom )
                                                        (Dict.get roomId cred.rooms)
                                                )
                                            |> (\x -> Dict.union x cred.rooms)
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
