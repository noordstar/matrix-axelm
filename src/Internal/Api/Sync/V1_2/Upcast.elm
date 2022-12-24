module Internal.Api.Sync.V1_2.Upcast exposing (..)

import Dict
import Internal.Api.Sync.V1_1.Objects as PO
import Internal.Api.Sync.V1_2.Objects as O
import Json.Encode as E


upcast : PO.Sync -> O.Sync
upcast sync =
    { accountData = sync.accountData
    , nextBatch = sync.nextBatch
    , presence = sync.presence
    , rooms = Maybe.map upcastRooms sync.rooms
    }


upcastRooms : PO.Rooms -> O.Rooms
upcastRooms rooms =
    { invite = rooms.invite
    , join = Dict.map (\_ -> upcastJoinedRoom) rooms.join
    , knock = rooms.knock
    , leave = Dict.map (\_ -> upcastLeftRoom) rooms.leave
    }


upcastJoinedRoom : PO.JoinedRoom -> O.JoinedRoom
upcastJoinedRoom room =
    { accountData = room.accountData
    , ephemeral = room.ephemeral
    , state = List.map upcastSyncStateEvent room.state
    , summary = room.summary
    , timeline = Maybe.map upcastTimeline room.timeline
    , unreadNotifications = room.unreadNotifications
    }


upcastSyncStateEvent : PO.SyncStateEvent -> O.ClientEventWithoutRoomId
upcastSyncStateEvent event =
    { content = event.content
    , eventId = event.eventId
    , originServerTs = event.originServerTs
    , sender = event.sender
    , stateKey = Just event.stateKey
    , contentType = event.contentType
    , unsigned = upcastUnsigned event.prevContent event.unsigned
    }


upcastUnsigned : Maybe E.Value -> Maybe PO.UnsignedData -> Maybe O.UnsignedData
upcastUnsigned prevContent unsigned =
    case ( prevContent, unsigned ) of
        ( _, Just u ) ->
            O.UnsignedData
                { age = u.age
                , prevContent = prevContent
                , redactedBecause = Maybe.map upcastBlindEvent u.redactedBecause
                , transactionId = u.transactionId
                }
                |> Just

        ( Just _, Nothing ) ->
            O.UnsignedData
                { age = Nothing
                , prevContent = prevContent
                , redactedBecause = Nothing
                , transactionId = Nothing
                }
                |> Just

        ( Nothing, Nothing ) ->
            Nothing


upcastBlindEvent : PO.BlindEvent -> O.OldBlindEvent
upcastBlindEvent event =
    { content = event.content
    , eventId = Nothing
    , originServerTs = Nothing
    , sender = Nothing
    , stateKey = Nothing
    , contentType = event.contentType
    , unsigned = Nothing
    }


upcastTimeline : PO.Timeline -> O.Timeline
upcastTimeline timeline =
    { events = List.map upcastSyncRoomEvent timeline.events
    , limited = timeline.limited
    , prevBatch = timeline.prevBatch
    }


upcastSyncRoomEvent : PO.SyncRoomEvent -> O.ClientEventWithoutRoomId
upcastSyncRoomEvent event =
    { content = event.content
    , eventId = event.eventId
    , originServerTs = event.originServerTs
    , sender = event.sender
    , stateKey = Nothing
    , contentType = event.contentType
    , unsigned = upcastUnsigned Nothing event.unsigned
    }


upcastLeftRoom : PO.LeftRoom -> O.LeftRoom
upcastLeftRoom room =
    { accountData = room.accountData
    , state = List.map upcastSyncStateEvent room.state
    , timeline = Maybe.map upcastTimeline room.timeline
    }
