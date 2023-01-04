module Internal.Api.All exposing (..)

{-| This module lists all available functions to reach the Matrix API.
-}

import Dict
import Internal.Api.GetEvent.Main as GetEvent
import Internal.Api.JoinedMembers.Main as JoinedMembers
import Internal.Api.SendMessageEvent.Main as SendMessageEvent
import Internal.Api.SendStateKey.Main as SendStateKey
import Internal.Api.Sync.Main as Sync
import Internal.Api.Versions.Main as Versions
import Internal.Values.Credentials as Credentials exposing (Credentials(..))
import Internal.Values.Exceptions as X
import Internal.Values.Room as Room
import Internal.Values.Event as Event
import Internal.Event as Event
import Task exposing (Task)
import Html exposing (a)


type alias Versions =
    List String

type alias UpdaterTask =
    Task X.Error (Credentials -> Credentials)


{-| Get a particular event by its event id and room id.
-}
getEvent : Credentials -> { roomId : String, eventId : String } -> UpdaterTask
getEvent c data =
    openWithCredentials
        { toTask = GetEvent.getEvent
        , toUpdater =
            (\event (Credentials cred) ->
                cred.rooms
                |> Dict.get data.roomId
                |> Maybe.map (Room.addEvent data.eventId (Event.fromOldBlindEvent data.roomId event))
                |> Maybe.map (\room -> Dict.insert data.roomId room cred.rooms)
                |> Maybe.withDefault cred.rooms
                |> (\rooms -> { cred | rooms = rooms })
                |> Credentials
            )
        }


{-| Get all versions that both the homeserver and this SDK support.
-}
getVersions : Versions.VersionsInput -> Versions.VersionsOutput
getVersions =
    Versions.getVersions


{-| Get information on all users who joined a room.
-}
joinedMembers : Versions -> JoinedMembers.JoinedMembersInput -> JoinedMembers.JoinedMembersOutput
joinedMembers =
    JoinedMembers.joinedMembers


{-| Send a message event to a room.
-}
sendMessageEvent : Versions -> SendMessageEvent.SendMessageEventInput -> SendMessageEvent.SendMessageEventOutput
sendMessageEvent =
    SendMessageEvent.sendMessageEvent


{-| Send a state event to a room.
-}
sendStateEvent : Versions -> SendStateKey.SendStateKeyInput -> SendStateKey.SendStateKeyOutput
sendStateEvent =
    SendStateKey.sendStateKey


{-| Sync the client
-}
sync : Versions -> Sync.SyncInput -> Sync.SyncOutput
sync =
    Sync.sync

{- Use your credentials to insert information into API calls -}
openWithCredentials : { toTask : (Versions -> a -> Task X.Error b), toUpdater : (b -> Credentials -> Credentials) } -> Credentials -> a -> UpdaterTask
openWithCredentials { toTask, toUpdater } (Credentials cred as c) x =
    case cred.supportedVersions of
        Just versions ->
            toTask versions x
            |> Task.map toUpdater
        
        Nothing ->
            let
                updateWithVersions : List String -> Credentials -> Credentials
                updateWithVersions vs (Credentials cr) =
                    Credentials { cr | supportedVersions = Just vs }
                
                newUpdater : List String -> b -> Credentials -> Credentials
                newUpdater vs v cr =
                    toUpdater v (updateWithVersions vs cr)
            in
                getVersions cred.baseUrl
                |> Task.andThen
                    (\v ->
                        toTask v.supportedVersions x
                        |> Task.map (newUpdater v.supportedVersions)
                    )
