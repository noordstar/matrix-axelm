module Internal.Api.V1_4.Api exposing (..)

import Dict
import Internal.Api.Request as R
import Internal.Api.V1_2.Objects as SyncPO
-- import Internal.Api.V1_3.Objects as PO
import Internal.Api.V1_3.Api as PApi
import Internal.Api.V1_4.Objects as O
import Internal.Api.V1_4.SpecObjects as SO
import Internal.Api.VersionControl exposing (..)
import Internal.Values.Exceptions as X
import Internal.Values.SpecEnums as Enums
import Json.Decode as D
import Json.Encode as E
import Task exposing (Task)

packet : VersionPacket SyncPO.Sync O.Sync
packet =
    { version = "v1.4"
    , sync = sync
    , upcastSync = upcastSync
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

upcastSync : SyncPO.Sync -> O.Sync
upcastSync oldSync =
    { accountData = oldSync.accountData
    , nextBatch = oldSync.nextBatch
    , presence = oldSync.presence
    , rooms = Maybe.map upcastRooms oldSync.rooms
    }

upcastRooms : SyncPO.Rooms -> O.Rooms
upcastRooms oldRooms =
    { invite = oldRooms.invite
    , join = Dict.map (\_ -> upcastJoinedRoom) oldRooms.join
    , knock = oldRooms.knock
    , leave = Dict.map (\_ -> upcastLeftRoom) oldRooms.leave
    }

upcastJoinedRoom : SyncPO.JoinedRoom -> O.JoinedRoom
upcastJoinedRoom oldJoinedRoom =
    { accountData = oldJoinedRoom.accountData
    , ephemeral = oldJoinedRoom.ephemeral
    , state = List.map upcastClientEventWithoutRoomId oldJoinedRoom.state
    , summary = oldJoinedRoom.summary
    , timeline = Maybe.map upcastTimeline oldJoinedRoom.timeline
    , unreadNotifiations = oldJoinedRoom.unreadNotifiations
    , unreadThreadNotifications = Dict.empty
    }

upcastLeftRoom : SyncPO.LeftRoom -> O.LeftRoom
upcastLeftRoom oldLeftRoom =
    { accountData = oldLeftRoom.accountData
    , state = List.map upcastClientEventWithoutRoomId oldLeftRoom.state
    , timeline = Maybe.map upcastTimeline oldLeftRoom.timeline
    }

upcastTimeline : SyncPO.Timeline -> O.Timeline
upcastTimeline oldLine =
    { events = List.map upcastClientEventWithoutRoomId oldLine.events
    , limited = oldLine.limited
    , prevBatch = oldLine.prevBatch
    }

upcastClientEventWithoutRoomId : SyncPO.ClientEventWithoutRoomId -> O.ClientEventWithoutRoomId
upcastClientEventWithoutRoomId oldEvent =
    { content = oldEvent.content
    , eventId = oldEvent.eventId
    , originServerTs = oldEvent.originServerTs
    , sender = oldEvent.sender
    , stateKey = oldEvent.stateKey
    , contentType = oldEvent.contentType
    , unsigned = Maybe.map upcastUnsigned oldEvent.unsigned
    }

upcastUnsigned : SyncPO.UnsignedData -> O.UnsignedData
upcastUnsigned (SyncPO.UnsignedData data) =
    O.UnsignedData
        { age = data.age
        , prevContent = data.prevContent
        , redactedBecause = Maybe.map upcastOldBlindEvent data.redactedBecause
        , transactionId = data.transactionId
        }

upcastOldBlindEvent : SyncPO.OldBlindEvent -> O.OldBlindEvent
upcastOldBlindEvent oldEvent =
    { content = oldEvent.content
    , eventId = oldEvent.eventId
    , originServerTs = oldEvent.originServerTs
    , sender = oldEvent.sender
    , stateKey = oldEvent.stateKey
    , contentType = oldEvent.contentType
    , unsigned = Maybe.map upcastUnsigned oldEvent.unsigned
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
                (\_ ->
                    .inviteState
                    >> Maybe.map .events
                    >> Maybe.withDefault []
                )
    , join = Dict.map (\_ -> convertJoinedRoom) oldRooms.join
    , knock =
        oldRooms.knock
            |> Dict.map
                (\_ ->
                    .knockState
                    >> Maybe.map .events
                    >> Maybe.withDefault []
                )
    , leave = Dict.map (\_ -> convertLeftRoom) oldRooms.leave
    }

convertJoinedRoom : SO.JoinedRoom -> O.JoinedRoom
convertJoinedRoom oldJoinedRoom =
    { accountData =
        oldJoinedRoom.accountData
            |> Maybe.map .events
            |> Maybe.withDefault []
    , ephemeral =
        oldJoinedRoom.ephemeral
            |> Maybe.map .events
            |> Maybe.withDefault []
    , state =
        oldJoinedRoom.state
            |> Maybe.map .events
            |> Maybe.withDefault []
            |> List.map convertClientEventWithoutRoomId
    , summary = oldJoinedRoom.summary
    , timeline = Maybe.map convertTimeline oldJoinedRoom.timeline
    , unreadNotifiations = oldJoinedRoom.unreadNotifiations
    , unreadThreadNotifications = oldJoinedRoom.unreadThreadNotifications
    }

convertLeftRoom : SO.LeftRoom -> O.LeftRoom
convertLeftRoom oldLeftRoom =
    { accountData =
        oldLeftRoom.accountData
            |> Maybe.map .events
            |> Maybe.withDefault []
    , state =
        oldLeftRoom.state
            |> Maybe.map .events
            |> Maybe.withDefault []
            |> List.map convertClientEventWithoutRoomId
    , timeline = Maybe.map convertTimeline oldLeftRoom.timeline
    }

convertTimeline : SO.Timeline -> O.Timeline
convertTimeline oldLine =
    { events = List.map convertClientEventWithoutRoomId oldLine.events
    , limited = oldLine.limited
    , prevBatch = oldLine.prevBatch
    }


convertClientEventWithoutRoomId : SO.ClientEventWithoutRoomID -> O.ClientEventWithoutRoomId
convertClientEventWithoutRoomId oldEvent =
    { content = oldEvent.content
    , eventId = oldEvent.eventId
    , originServerTs = oldEvent.originServerTs
    , sender = oldEvent.sender
    , stateKey = oldEvent.stateKey
    , contentType = oldEvent.contentType
    , unsigned = Maybe.map convertUnsigned oldEvent.unsigned
    }


convertUnsigned : SO.UnsignedData -> O.UnsignedData
convertUnsigned (SO.UnsignedData oldData) =
    O.UnsignedData
        { age = oldData.age
        , prevContent = oldData.prevContent
        , redactedBecause = Maybe.map convertOldBlindEvent oldData.redactedBecause
        , transactionId = oldData.transactionId
        }


convertOldBlindEvent : SO.ClientEventWithoutRoomID -> O.OldBlindEvent
convertOldBlindEvent oldEvent =
    { content = oldEvent.content
    , eventId = Just oldEvent.eventId
    , originServerTs = Just oldEvent.originServerTs
    , sender = Just oldEvent.sender
    , stateKey = oldEvent.stateKey
    , contentType = oldEvent.contentType
    , unsigned = Maybe.map convertUnsigned oldEvent.unsigned
    }
