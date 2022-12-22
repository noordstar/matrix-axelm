module Internal.Api.V1_1.Objects exposing
    ( BlindEvent
    , JoinedRoom
    , LeftRoom
    , RoomSummary
    , Rooms
    , StrippedState
    , Sync
    , SyncRoomEvent
    , SyncStateEvent
    , Timeline
    , UnreadNotificationCounts
    , UnsignedData
    , blindEventDecoder
    , encodeBlindEvent
    , encodeJoinedRoom
    , encodeLeftRoom
    , encodeRoomSummary
    , encodeRooms
    , encodeStrippedState
    , encodeSync
    , encodeSyncRoomEvent
    , encodeSyncStateEvent
    , encodeTimeline
    , encodeUnreadNotificationCounts
    , encodeUnsignedData
    , joinedRoomDecoder
    , leftRoomDecoder
    , roomSummaryDecoder
    , roomsDecoder
    , strippedStateDecoder
    , syncDecoder
    , syncRoomEventDecoder
    , syncStateEventDecoder
    , timelineDecoder
    , unreadNotificationCountsDecoder
    , unsignedDataDecoder
    )

{-| Automatically generated 'Objects'

Last generated at Unix time 1671705114

-}

import Dict exposing (Dict)
import Internal.Tools.DecodeExtra exposing (opField, opFieldWithDefault)
import Internal.Tools.EncodeExtra exposing (maybeObject)
import Internal.Tools.Timestamp exposing (Timestamp, encodeTimestamp, timestampDecoder)
import Internal.Values.SpecEnums as Enums
import Json.Decode as D
import Json.Encode as E


{-| A blind event that does not give context about itself.
-}
type alias BlindEvent =
    { content : E.Value
    , contentType : String
    }


encodeBlindEvent : BlindEvent -> E.Value
encodeBlindEvent data =
    maybeObject
        [ ( "content", Just <| data.content )
        , ( "type", Just <| E.string data.contentType )
        ]


blindEventDecoder : D.Decoder BlindEvent
blindEventDecoder =
    D.map2
        (\a b ->
            { content = a, contentType = b }
        )
        (D.field "content" D.value)
        (D.field "type" D.string)


{-| Room that the user has joined.
-}
type alias JoinedRoom =
    { accountData : List BlindEvent
    , ephemeral : List BlindEvent
    , state : List SyncStateEvent
    , summary : Maybe RoomSummary
    , timeline : Maybe Timeline
    , unreadNotifiations : Maybe UnreadNotificationCounts
    }


encodeJoinedRoom : JoinedRoom -> E.Value
encodeJoinedRoom data =
    maybeObject
        [ ( "account_data", Just <| E.list encodeBlindEvent data.accountData )
        , ( "ephemeral", Just <| E.list encodeBlindEvent data.ephemeral )
        , ( "state", Just <| E.list encodeSyncStateEvent data.state )
        , ( "summary", Maybe.map encodeRoomSummary data.summary )
        , ( "timeline", Maybe.map encodeTimeline data.timeline )
        , ( "unread_notifiations", Maybe.map encodeUnreadNotificationCounts data.unreadNotifiations )
        ]


joinedRoomDecoder : D.Decoder JoinedRoom
joinedRoomDecoder =
    D.map6
        (\a b c d e f ->
            { accountData = a, ephemeral = b, state = c, summary = d, timeline = e, unreadNotifiations = f }
        )
        (D.field "account_data" (D.list blindEventDecoder))
        (D.field "ephemeral" (D.list blindEventDecoder))
        (D.field "state" (D.list syncStateEventDecoder))
        (opField "summary" roomSummaryDecoder)
        (opField "timeline" timelineDecoder)
        (opField "unread_notifiations" unreadNotificationCountsDecoder)


{-| Room that the user has left.
-}
type alias LeftRoom =
    { accountData : List BlindEvent
    , state : List SyncStateEvent
    , timeline : Maybe Timeline
    }


encodeLeftRoom : LeftRoom -> E.Value
encodeLeftRoom data =
    maybeObject
        [ ( "account_data", Just <| E.list encodeBlindEvent data.accountData )
        , ( "state", Just <| E.list encodeSyncStateEvent data.state )
        , ( "timeline", Maybe.map encodeTimeline data.timeline )
        ]


leftRoomDecoder : D.Decoder LeftRoom
leftRoomDecoder =
    D.map3
        (\a b c ->
            { accountData = a, state = b, timeline = c }
        )
        (D.field "account_data" (D.list blindEventDecoder))
        (D.field "state" (D.list syncStateEventDecoder))
        (opField "timeline" timelineDecoder)


{-| Updates to rooms.
-}
type alias Rooms =
    { invite : Dict String (List StrippedState)
    , join : Dict String JoinedRoom
    , knock : Dict String (List StrippedState)
    , leave : Dict String LeftRoom
    }


encodeRooms : Rooms -> E.Value
encodeRooms data =
    maybeObject
        [ ( "invite", Just <| E.dict identity (E.list encodeStrippedState) data.invite )
        , ( "join", Just <| E.dict identity encodeJoinedRoom data.join )
        , ( "knock", Just <| E.dict identity (E.list encodeStrippedState) data.knock )
        , ( "leave", Just <| E.dict identity encodeLeftRoom data.leave )
        ]


roomsDecoder : D.Decoder Rooms
roomsDecoder =
    D.map4
        (\a b c d ->
            { invite = a, join = b, knock = c, leave = d }
        )
        (opFieldWithDefault "invite" Dict.empty (D.dict (D.list strippedStateDecoder)))
        (opFieldWithDefault "join" Dict.empty (D.dict joinedRoomDecoder))
        (opFieldWithDefault "knock" Dict.empty (D.dict (D.list strippedStateDecoder)))
        (opFieldWithDefault "leave" Dict.empty (D.dict leftRoomDecoder))


{-| Information about a room which clients may need to correctly render it to users.
-}
type alias RoomSummary =
    { mHeroes : Maybe (List String)
    , mInvitedMemberCount : Maybe Int
    , mJoinedMemberCount : Maybe Int
    }


encodeRoomSummary : RoomSummary -> E.Value
encodeRoomSummary data =
    maybeObject
        [ ( "m.heroes", Maybe.map (E.list E.string) data.mHeroes )
        , ( "m.invited_member_count", Maybe.map E.int data.mInvitedMemberCount )
        , ( "m.joined_member_count", Maybe.map E.int data.mJoinedMemberCount )
        ]


roomSummaryDecoder : D.Decoder RoomSummary
roomSummaryDecoder =
    D.map3
        (\a b c ->
            { mHeroes = a, mInvitedMemberCount = b, mJoinedMemberCount = c }
        )
        (opField "m.heroes" (D.list D.string))
        (opField "m.invited_member_count" D.int)
        (opField "m.joined_member_count" D.int)


{-| Stripped state events of a room that the user has limited access to.
-}
type alias StrippedState =
    { content : E.Value
    , sender : String
    , stateKey : String
    , contentType : String
    }


encodeStrippedState : StrippedState -> E.Value
encodeStrippedState data =
    maybeObject
        [ ( "content", Just <| data.content )
        , ( "sender", Just <| E.string data.sender )
        , ( "state_key", Just <| E.string data.stateKey )
        , ( "type", Just <| E.string data.contentType )
        ]


strippedStateDecoder : D.Decoder StrippedState
strippedStateDecoder =
    D.map4
        (\a b c d ->
            { content = a, sender = b, stateKey = c, contentType = d }
        )
        (D.field "content" D.value)
        (D.field "sender" D.string)
        (D.field "state_key" D.string)
        (D.field "type" D.string)


{-| The sync response the homeserver sends to the user.
-}
type alias Sync =
    { accountData : List BlindEvent
    , nextBatch : String
    , presence : List BlindEvent
    , rooms : Maybe Rooms
    }


encodeSync : Sync -> E.Value
encodeSync data =
    maybeObject
        [ ( "account_data", Just <| E.list encodeBlindEvent data.accountData )
        , ( "next_batch", Just <| E.string data.nextBatch )
        , ( "presence", Just <| E.list encodeBlindEvent data.presence )
        , ( "rooms", Maybe.map encodeRooms data.rooms )
        ]


syncDecoder : D.Decoder Sync
syncDecoder =
    D.map4
        (\a b c d ->
            { accountData = a, nextBatch = b, presence = c, rooms = d }
        )
        (D.field "account_data" (D.list blindEventDecoder))
        (D.field "next_batch" D.string)
        (D.field "presence" (D.list blindEventDecoder))
        (opField "rooms" roomsDecoder)


{-| Message events that were sent in a certain part of the timeline.
-}
type alias SyncRoomEvent =
    { content : E.Value
    , eventId : String
    , originServerTs : Timestamp
    , sender : String
    , contentType : String
    , unsigned : Maybe UnsignedData
    }


encodeSyncRoomEvent : SyncRoomEvent -> E.Value
encodeSyncRoomEvent data =
    maybeObject
        [ ( "content", Just <| data.content )
        , ( "event_id", Just <| E.string data.eventId )
        , ( "origin_server_ts", Just <| encodeTimestamp data.originServerTs )
        , ( "sender", Just <| E.string data.sender )
        , ( "type", Just <| E.string data.contentType )
        , ( "unsigned", Maybe.map encodeUnsignedData data.unsigned )
        ]


syncRoomEventDecoder : D.Decoder SyncRoomEvent
syncRoomEventDecoder =
    D.map6
        (\a b c d e f ->
            { content = a, eventId = b, originServerTs = c, sender = d, contentType = e, unsigned = f }
        )
        (D.field "content" D.value)
        (D.field "event_id" D.string)
        (D.field "origin_server_ts" timestampDecoder)
        (D.field "sender" D.string)
        (D.field "type" D.string)
        (opField "unsigned" unsignedDataDecoder)


{-| State events showing recent state event changes in a room.
-}
type alias SyncStateEvent =
    { content : E.Value
    , eventId : String
    , originServerTs : Timestamp
    , prevContent : Maybe E.Value
    , sender : String
    , stateKey : String
    , contentType : String
    , unsigned : Maybe UnsignedData
    }


encodeSyncStateEvent : SyncStateEvent -> E.Value
encodeSyncStateEvent data =
    maybeObject
        [ ( "content", Just <| data.content )
        , ( "event_id", Just <| E.string data.eventId )
        , ( "origin_server_ts", Just <| encodeTimestamp data.originServerTs )
        , ( "prev_content", data.prevContent )
        , ( "sender", Just <| E.string data.sender )
        , ( "state_key", Just <| E.string data.stateKey )
        , ( "type", Just <| E.string data.contentType )
        , ( "unsigned", Maybe.map encodeUnsignedData data.unsigned )
        ]


syncStateEventDecoder : D.Decoder SyncStateEvent
syncStateEventDecoder =
    D.map8
        (\a b c d e f g h ->
            { content = a, eventId = b, originServerTs = c, prevContent = d, sender = e, stateKey = f, contentType = g, unsigned = h }
        )
        (D.field "content" D.value)
        (D.field "event_id" D.string)
        (D.field "origin_server_ts" timestampDecoder)
        (opField "prev_content" D.value)
        (D.field "sender" D.string)
        (D.field "state_key" D.string)
        (D.field "type" D.string)
        (opField "unsigned" unsignedDataDecoder)


{-| The timeline of messages and state changes in a room.
-}
type alias Timeline =
    { events : List SyncRoomEvent
    , limited : Bool
    , prevBatch : Maybe String
    }


encodeTimeline : Timeline -> E.Value
encodeTimeline data =
    maybeObject
        [ ( "events", Just <| E.list encodeSyncRoomEvent data.events )
        , ( "limited", Just <| E.bool data.limited )
        , ( "prev_batch", Maybe.map E.string data.prevBatch )
        ]


timelineDecoder : D.Decoder Timeline
timelineDecoder =
    D.map3
        (\a b c ->
            { events = a, limited = b, prevBatch = c }
        )
        (opFieldWithDefault "events" [] (D.list syncRoomEventDecoder))
        (opFieldWithDefault "limited" False D.bool)
        (opField "prev_batch" D.string)


{-| Counts of unread notifications for this room.
-}
type alias UnreadNotificationCounts =
    { highlightCount : Maybe Int
    , notificationCount : Maybe Int
    }


encodeUnreadNotificationCounts : UnreadNotificationCounts -> E.Value
encodeUnreadNotificationCounts data =
    maybeObject
        [ ( "highlight_count", Maybe.map E.int data.highlightCount )
        , ( "notification_count", Maybe.map E.int data.notificationCount )
        ]


unreadNotificationCountsDecoder : D.Decoder UnreadNotificationCounts
unreadNotificationCountsDecoder =
    D.map2
        (\a b ->
            { highlightCount = a, notificationCount = b }
        )
        (opField "highlight_count" D.int)
        (opField "notification_count" D.int)


{-| Data that isn't getting signed for Canonical JSON.
-}
type alias UnsignedData =
    { age : Maybe Int
    , redactedBecause : Maybe BlindEvent
    , transactionId : Maybe String
    }


encodeUnsignedData : UnsignedData -> E.Value
encodeUnsignedData data =
    maybeObject
        [ ( "age", Maybe.map E.int data.age )
        , ( "redacted_because", Maybe.map encodeBlindEvent data.redactedBecause )
        , ( "transaction_id", Maybe.map E.string data.transactionId )
        ]


unsignedDataDecoder : D.Decoder UnsignedData
unsignedDataDecoder =
    D.map3
        (\a b c ->
            { age = a, redactedBecause = b, transactionId = c }
        )
        (opField "age" D.int)
        (opField "redacted_because" blindEventDecoder)
        (opField "transaction_id" D.string)
