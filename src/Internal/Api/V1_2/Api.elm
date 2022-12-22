module Internal.Api.V1_2.Api exposing (..)

import Dict
import Internal.Api.Request as R
import Internal.Api.V1_1.Objects as PO
import Internal.Api.V1_2.Objects as O
import Internal.Api.V1_2.SpecObjects as SO
import Internal.Api.VersionControl exposing (..)
import Internal.Values.Exceptions as X
import Internal.Values.SpecEnums as Enums
import Json.Decode as D
import Json.Encode as E
import Task exposing (Task)


packet : VersionPacket PO.Sync O.Sync
packet =
    { version = "v1.2"
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


upcastSync : PO.Sync -> O.Sync
upcastSync oldSync =
    { accountData = oldSync.accountData
    , nextBatch = oldSync.nextBatch
    , presence = oldSync.presence
    , rooms = Maybe.map upcastRooms oldSync.rooms
    }


upcastRooms : PO.Rooms -> O.Rooms
upcastRooms oldRooms =
    { invite = oldRooms.invite
    , join = Dict.map (\_ -> upcastJoinedRoom) oldRooms.join
    , knock = oldRooms.knock
    , leave = Dict.map (\_ -> upcastLeftRoom) oldRooms.leave
    }


upcastLeftRoom : PO.LeftRoom -> O.LeftRoom
upcastLeftRoom oldLeftRoom =
    { accountData = oldLeftRoom.accountData
    , state = List.map upcastSyncStateEvent oldLeftRoom.state
    , timeline = Maybe.map upcastTimeline oldLeftRoom.timeline
    }


upcastJoinedRoom : PO.JoinedRoom -> O.JoinedRoom
upcastJoinedRoom oldJoinedRoom =
    { accountData = oldJoinedRoom.accountData
    , ephemeral = oldJoinedRoom.ephemeral
    , state = List.map upcastSyncStateEvent oldJoinedRoom.state
    , summary = oldJoinedRoom.summary
    , timeline = Maybe.map upcastTimeline oldJoinedRoom.timeline
    , unreadNotifiations = oldJoinedRoom.unreadNotifiations
    }


upcastTimeline : PO.Timeline -> O.Timeline
upcastTimeline oldTimeline =
    { events = List.map upcastSyncRoomEvent oldTimeline.events
    , limited = oldTimeline.limited
    , prevBatch = oldTimeline.prevBatch
    }


upcastSyncRoomEvent : PO.SyncRoomEvent -> O.ClientEventWithoutRoomId
upcastSyncRoomEvent oldSyncRoomEvent =
    { content = oldSyncRoomEvent.content
    , eventId = oldSyncRoomEvent.eventId
    , originServerTs = oldSyncRoomEvent.originServerTs
    , sender = oldSyncRoomEvent.sender
    , stateKey = Nothing
    , contentType = oldSyncRoomEvent.contentType
    , unsigned = upcastUnsignedData Nothing oldSyncRoomEvent.unsigned
    }


upcastSyncStateEvent : PO.SyncStateEvent -> O.ClientEventWithoutRoomId
upcastSyncStateEvent oldSyncStateEvent =
    { content = oldSyncStateEvent.content
    , eventId = oldSyncStateEvent.eventId
    , originServerTs = oldSyncStateEvent.originServerTs
    , sender = oldSyncStateEvent.sender
    , stateKey = Just oldSyncStateEvent.stateKey
    , contentType = oldSyncStateEvent.contentType
    , unsigned = upcastUnsignedData oldSyncStateEvent.prevContent oldSyncStateEvent.unsigned
    }


upcastUnsignedData : Maybe E.Value -> Maybe PO.UnsignedData -> Maybe O.UnsignedData
upcastUnsignedData prevContent oldUnsigned =
    case oldUnsigned of
        Just u ->
            { age = u.age
            , prevContent = prevContent
            , redactedBecause = Maybe.map upcastBlindEvent u.redactedBecause
            , transactionId = u.transactionId
            }
                |> O.UnsignedData
                |> Just

        Nothing ->
            prevContent
                |> Maybe.map
                    (\_ ->
                        O.UnsignedData
                            { age = Nothing
                            , prevContent = prevContent
                            , redactedBecause = Nothing
                            , transactionId = Nothing
                            }
                    )


upcastBlindEvent : PO.BlindEvent -> O.OldBlindEvent
upcastBlindEvent oldBlindEvent =
    { content = oldBlindEvent.content
    , eventId = Nothing
    , originServerTs = Nothing
    , sender = Nothing
    , stateKey = Nothing
    , contentType = oldBlindEvent.contentType
    , unsigned = Nothing
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
convertRooms rooms =
    { invite =
        rooms.invite
            |> Dict.map
                (\_ room ->
                    room.inviteState
                        |> Maybe.map .events
                        |> Maybe.withDefault []
                )
    , join = Dict.map (\_ -> convertJoinedRoom) rooms.join
    , knock =
        rooms.knock
            |> Dict.map
                (\_ room ->
                    room.knockState
                        |> Maybe.map .events
                        |> Maybe.withDefault []
                )
    , leave = Dict.map (\_ -> convertLeftRoom) rooms.leave
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
