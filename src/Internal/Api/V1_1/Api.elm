module Internal.Api.V1_1.Api exposing (..)

import Dict
import Internal.Api.Request as R
import Internal.Api.V1_1.Objects as O
import Internal.Api.V1_1.SpecObjects as SO
import Internal.Api.VersionControl exposing (..)
import Internal.Values.Exceptions as X
import Internal.Values.SpecEnums as Enums
import Json.Decode as D
import Task exposing (Task)


packet : VersionPacket () O.Sync
packet =
    { version = "v1.1"
    , sync = sync
    , upcastSync =
        \_ ->
            { accountData = []
            , nextBatch = ""
            , presence = []
            , rooms =
                Just
                    { invite = Dict.empty
                    , join = Dict.empty
                    , knock = Dict.empty
                    , leave = Dict.empty
                    }
            }
    }


sync : SyncInput -> Task X.Error O.Sync
sync data =
    R.rawApiCall
        { headers = R.WithAccessToken data.accessToken
        , method = "GET"
        , baseUrl = data.baseUrl
        , path = "/_matrix/client/v3/sync"
        , pathParams = []
        , queryParams =
            [ R.OpQueryParamString "filter" data.filter
            , R.QueryParamBool "full_state" (Maybe.withDefault False data.fullState)
            , R.OpQueryParamString "set_presence" (Maybe.map Enums.fromUserPresence data.setPresence)
            , R.OpQueryParamString "since" data.since
            , R.OpQueryParamInt "timeout" data.timeout
            ]
        , bodyParams = []
        , timeout =
            data.timeout
                |> Maybe.map (\t -> t + 10000)
                |> Maybe.map toFloat
        , decoder = \_ -> D.map convertSync SO.syncDecoder
        }


convertSync : SO.Sync -> O.Sync
convertSync oldSync =
    { accountData =
        oldSync.accountData
            |> Maybe.map .events
            |> Maybe.withDefault []
    , nextBatch = oldSync.nextBatch
    , presence =
        oldSync.presence
            |> Maybe.map .events
            |> Maybe.withDefault []
    , rooms = Maybe.map convertRooms oldSync.rooms
    }


convertRooms : SO.Rooms -> O.Rooms
convertRooms oldRooms =
    { invite =
        oldRooms.invite
            |> Dict.map
                (\_ state ->
                    state.inviteState
                        |> Maybe.map .events
                        |> Maybe.withDefault []
                )
    , join = Dict.map (\_ -> convertJoinedRoom) oldRooms.join
    , knock =
        oldRooms.knock
            |> Dict.map
                (\_ state ->
                    state.knockState
                        |> Maybe.map .events
                        |> Maybe.withDefault []
                )
    , leave = Dict.map (\_ -> convertLeftRoom) oldRooms.leave
    }


convertJoinedRoom : SO.JoinedRoom -> O.JoinedRoom
convertJoinedRoom oldRoom =
    { accountData =
        oldRoom.accountData
            |> Maybe.map .events
            |> Maybe.withDefault []
    , ephemeral =
        oldRoom.ephemeral
            |> Maybe.map .events
            |> Maybe.withDefault []
    , state =
        oldRoom.state
            |> Maybe.map .events
            |> Maybe.withDefault []
    , summary = oldRoom.summary
    , timeline = oldRoom.timeline
    , unreadNotifiations = oldRoom.unreadNotifiations
    }


convertLeftRoom : SO.LeftRoom -> O.LeftRoom
convertLeftRoom oldRoom =
    { accountData =
        oldRoom.accountData
            |> Maybe.map .events
            |> Maybe.withDefault []
    , state =
        oldRoom.state
            |> Maybe.map .events
            |> Maybe.withDefault []
    , timeline = oldRoom.timeline
    }
