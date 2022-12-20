module Internal.Api.V1_1.SpecObjects exposing (AccountData, Ephemeral, Event, EventContent, InviteState, InvitedRoom, JoinedRoom, KnockState, KnockedRoom, LeftRoom, Presence, RoomSummary, Rooms, State, StrippedState, Sync, SyncRoomEvent, SyncStateEvent, Timeline, UnreadNotificationCounts, UnsignedData, accountDataDecoder, encodeAccountData, encodeEphemeral, encodeEvent, encodeEventContent, encodeInviteState, encodeInvitedRoom, encodeJoinedRoom, encodeKnockState, encodeKnockedRoom, encodeLeftRoom, encodePresence, encodeRoomSummary, encodeRooms, encodeState, encodeStrippedState, encodeSync, encodeSyncRoomEvent, encodeSyncStateEvent, encodeTimeline, encodeUnreadNotificationCounts, encodeUnsignedData, ephemeralDecoder, eventContentDecoder, eventDecoder, inviteStateDecoder, invitedRoomDecoder, joinedRoomDecoder, knockStateDecoder, knockedRoomDecoder, leftRoomDecoder, presenceDecoder, roomSummaryDecoder, roomsDecoder, stateDecoder, strippedStateDecoder, syncDecoder, syncRoomEventDecoder, syncStateEventDecoder, timelineDecoder, unreadNotificationCountsDecoder, unsignedDataDecoder)

import Dict exposing (Dict)
import Internal.Values.SpecEnums as Enums
import Json.Decode as D
import Json.Encode as E
import Time


{-| The global private data created by this user.
-}
type alias AccountData =
    { events : List Event
    }


encodeAccountData : AccountData -> E.Value
encodeAccountData data =
    maybeObject
        [ ( "events", Just <| E.list encodeEvent data.events )
        ]


accountDataDecoder : D.Decoder AccountData
accountDataDecoder =
    D.map
        (\a ->
            { events = a }
        )
        (opFieldWithDefault "events" [] (D.list eventDecoder))


{-| Ephemeral events in a room that aren't recorded in the timeline or the state of the room.
-}
type alias Ephemeral =
    { events : List Event
    }


encodeEphemeral : Ephemeral -> E.Value
encodeEphemeral data =
    maybeObject
        [ ( "events", Just <| E.list encodeEvent data.events )
        ]


ephemeralDecoder : D.Decoder Ephemeral
ephemeralDecoder =
    D.map
        (\a ->
            { events = a }
        )
        (opFieldWithDefault "events" [] (D.list eventDecoder))


{-| A general event.
-}
type alias Event =
    { content : EventContent
    , contentType : String
    }


encodeEvent : Event -> E.Value
encodeEvent data =
    maybeObject
        [ ( "content", Just <| encodeEventContent data.content )
        , ( "type", Just <| E.string data.contentType )
        ]


eventDecoder : D.Decoder Event
eventDecoder =
    D.map2
        (\a b ->
            { content = a, contentType = b }
        )
        (D.field "content" eventContentDecoder)
        (D.field "type" D.string)


{-| Content of a given event.
-}
type alias EventContent =
    E.Value


encodeEventContent : EventContent -> E.Value
encodeEventContent = identity


eventContentDecoder : D.Decoder EventContent
eventContentDecoder =
    D.value


{-| The state of a room that the user has been invited to.
-}
type alias InviteState =
    { events : List StrippedState
    }


encodeInviteState : InviteState -> E.Value
encodeInviteState data =
    maybeObject
        [ ( "events", Just <| E.list encodeStrippedState data.events )
        ]


inviteStateDecoder : D.Decoder InviteState
inviteStateDecoder =
    D.map
        (\a ->
            { events = a }
        )
        (opFieldWithDefault "events" [] (D.list strippedStateDecoder))


{-| Room that the user has been invited to.
-}
type alias InvitedRoom =
    { inviteState : Maybe InviteState
    }


encodeInvitedRoom : InvitedRoom -> E.Value
encodeInvitedRoom data =
    maybeObject
        [ ( "invite_state", Maybe.map encodeInviteState data.inviteState )
        ]


invitedRoomDecoder : D.Decoder InvitedRoom
invitedRoomDecoder =
    D.map
        (\a ->
            { inviteState = a }
        )
        (opField "invite_state" inviteStateDecoder)


{-| Room that the user has joined.
-}
type alias JoinedRoom =
    { accountData : Maybe AccountData
    , ephemeral : Maybe Ephemeral
    , state : Maybe State
    , summary : Maybe RoomSummary
    , timeline : Maybe Timeline
    , unreadNotifications : Maybe UnreadNotificationCounts
    }


encodeJoinedRoom : JoinedRoom -> E.Value
encodeJoinedRoom data =
    maybeObject
        [ ( "account_data", Maybe.map encodeAccountData data.accountData )
        , ( "ephemeral", Maybe.map encodeEphemeral data.ephemeral )
        , ( "state", Maybe.map encodeState data.state )
        , ( "summary", Maybe.map encodeRoomSummary data.summary )
        , ( "timeline", Maybe.map encodeTimeline data.timeline )
        , ( "unread_notifications", Maybe.map encodeUnreadNotificationCounts data.unreadNotifications )
        ]


joinedRoomDecoder : D.Decoder JoinedRoom
joinedRoomDecoder =
    D.map6
        (\a b c d e f ->
            { accountData = a, ephemeral = b, state = c, summary = d, timeline = e, unreadNotifications = f }
        )
        (opField "account_data" accountDataDecoder)
        (opField "ephemeral" ephemeralDecoder)
        (opField "state" stateDecoder)
        (opField "summary" roomSummaryDecoder)
        (opField "timeline" timelineDecoder)
        (opField "unread_notifications" unreadNotificationCountsDecoder)


{-| The state of a room that the user has knocked upon.
-}
type alias KnockState =
    { events : List StrippedState
    }


encodeKnockState : KnockState -> E.Value
encodeKnockState data =
    maybeObject
        [ ( "events", Just <| E.list encodeStrippedState data.events )
        ]


knockStateDecoder : D.Decoder KnockState
knockStateDecoder =
    D.map
        (\a ->
            { events = a }
        )
        (opFieldWithDefault "events" [] (D.list strippedStateDecoder))


{-| Room that the user has knocked upon.
-}
type alias KnockedRoom =
    { knockState : Maybe KnockState
    }


encodeKnockedRoom : KnockedRoom -> E.Value
encodeKnockedRoom data =
    maybeObject
        [ ( "knock_state", Maybe.map encodeKnockState data.knockState )
        ]


knockedRoomDecoder : D.Decoder KnockedRoom
knockedRoomDecoder =
    D.map
        (\a ->
            { knockState = a }
        )
        (opField "knock_state" knockStateDecoder)


{-| Room that the user has left.
-}
type alias LeftRoom =
    { accountData : Maybe AccountData
    , state : Maybe State
    , timeline : Maybe Timeline
    }


encodeLeftRoom : LeftRoom -> E.Value
encodeLeftRoom data =
    maybeObject
        [ ( "account_data", Maybe.map encodeAccountData data.accountData )
        , ( "state", Maybe.map encodeState data.state )
        , ( "timeline", Maybe.map encodeTimeline data.timeline )
        ]


leftRoomDecoder : D.Decoder LeftRoom
leftRoomDecoder =
    D.map3
        (\a b c ->
            { accountData = a, state = b, timeline = c }
        )
        (opField "account_data" accountDataDecoder)
        (opField "state" stateDecoder)
        (opField "timeline" timelineDecoder)


{-| The updates to the presence status of other users.
-}
type alias Presence =
    { events : List Event
    }


encodePresence : Presence -> E.Value
encodePresence data =
    maybeObject
        [ ( "events", Just <| E.list encodeEvent data.events )
        ]


presenceDecoder : D.Decoder Presence
presenceDecoder =
    D.map
        (\a ->
            { events = a }
        )
        (opFieldWithDefault "events" [] (D.list eventDecoder))


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


{-| Updates to rooms.
-}
type alias Rooms =
    { invite : Dict String InvitedRoom
    , join : Dict String JoinedRoom
    , knock : Dict String KnockedRoom
    , leave : Dict String LeftRoom
    }


encodeRooms : Rooms -> E.Value
encodeRooms data =
    maybeObject
        [ ( "invite", Just <| E.dict identity encodeInvitedRoom data.invite )
        , ( "join", Just <| E.dict identity encodeJoinedRoom data.join )
        , ( "knock", Just <| E.dict identity encodeKnockedRoom data.knock )
        , ( "leave", Just <| E.dict identity encodeLeftRoom data.leave )
        ]


roomsDecoder : D.Decoder Rooms
roomsDecoder =
    D.map4
        (\a b c d ->
            { invite = a, join = b, knock = c, leave = d }
        )
        (opFieldWithDefault "invite" Dict.empty (D.dict invitedRoomDecoder))
        (opFieldWithDefault "join" Dict.empty (D.dict joinedRoomDecoder))
        (opFieldWithDefault "knock" Dict.empty (D.dict knockedRoomDecoder))
        (opFieldWithDefault "leave" Dict.empty (D.dict leftRoomDecoder))


{-| Updates to the state of a room.
-}
type alias State =
    { events : List SyncStateEvent
    }


encodeState : State -> E.Value
encodeState data =
    maybeObject
        [ ( "events", Just <| E.list encodeSyncStateEvent data.events )
        ]


stateDecoder : D.Decoder State
stateDecoder =
    D.map
        (\a ->
            { events = a }
        )
        (opFieldWithDefault "events" [] (D.list syncStateEventDecoder))


{-| The StrippedState events that form the state of a room that the user has limited access to.
-}
type alias StrippedState =
    { content : EventContent
    , sender : String
    , stateKey : String
    , contentType : String
    }


encodeStrippedState : StrippedState -> E.Value
encodeStrippedState data =
    maybeObject
        [ ( "content", Just <| encodeEventContent data.content )
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
        (D.field "content" eventContentDecoder)
        (D.field "sender" D.string)
        (D.field "state_key" D.string)
        (D.field "type" D.string)


{-| The sync response the homeserver sends to the user.
-}
type alias Sync =
    { accountData : AccountData
    , nextBatch : String
    , presence : Maybe Presence
    , rooms : Maybe Rooms
    }


encodeSync : Sync -> E.Value
encodeSync data =
    maybeObject
        [ ( "account_data", Just <| encodeAccountData data.accountData )
        , ( "next_batch", Just <| E.string data.nextBatch )
        , ( "presence", Maybe.map encodePresence data.presence )
        , ( "rooms", Maybe.map encodeRooms data.rooms )
        ]


syncDecoder : D.Decoder Sync
syncDecoder =
    D.map4
        (\a b c d ->
            { accountData = a, nextBatch = b, presence = c, rooms = d }
        )
        (opFieldWithDefault "account_data" accountDataDecoder)
        (D.field "next_batch" D.string)
        (opField "presence" presenceDecoder)
        (opField "rooms" roomsDecoder)


{-| Message events that were sent in a certain part of the timeline.
-}
type alias SyncRoomEvent =
    { content : EventContent
    , eventId : String
    , originServerTs : Time.Posix
    , sender : String
    , contentType : String
    , unsigned : Maybe UnsignedData
    }


encodeSyncRoomEvent : SyncRoomEvent -> E.Value
encodeSyncRoomEvent data =
    maybeObject
        [ ( "content", Just <| encodeEventContent data.content )
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
        (D.field "content" eventContentDecoder)
        (D.field "event_id" D.string)
        (D.field "origin_server_ts" timestampDecoder)
        (D.field "sender" D.string)
        (D.field "type" D.string)
        (opField "unsigned" unsignedDataDecoder)


{-| State events showing recent state events in a room.
-}
type alias SyncStateEvent =
    { content : EventContent
    , eventId : String
    , originServerTs : Time.Posix
    , prevContent : Maybe EventContent
    , sender : String
    , stateKey : String
    , contentType : String
    , unsigned : Maybe UnsignedData
    }


encodeSyncStateEvent : SyncStateEvent -> E.Value
encodeSyncStateEvent data =
    maybeObject
        [ ( "content", Just <| encodeEventContent data.content )
        , ( "event_id", Just <| E.string data.eventId )
        , ( "origin_server_ts", Just <| encodeTimestamp data.originServerTs )
        , ( "prev_content", Maybe.map encodeEventContent data.prevContent )
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
        (D.field "content" eventContentDecoder)
        (D.field "event_id" D.string)
        (D.field "origin_server_ts" timestampDecoder)
        (opField "prev_content" eventContentDecoder)
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
    , redactedBecause : Maybe Event
    , transactionId : Maybe String
    }


encodeUnsignedData : UnsignedData -> E.Value
encodeUnsignedData data =
    maybeObject
        [ ( "age", Maybe.map E.int data.age )
        , ( "redacted_because", Maybe.map encodeEvent data.redactedBecause )
        , ( "transaction_id", Maybe.map E.string data.transactionId )
        ]


unsignedDataDecoder : D.Decoder UnsignedData
unsignedDataDecoder =
    D.map3
        (\a b c ->
            { age = a, redactedBecause = b, transactionId = c }
        )
        (opField "age" D.int)
        (opField "redacted_because" eventDecoder)
        (opField "transaction_id" D.string)


{-| Create a body object based on optionally provided values.
-}
maybeObject : List ( String, Maybe E.Value ) -> E.Value
maybeObject =
    List.filterMap
        (\( name, value ) ->
            case value of
                Just v ->
                    Just ( name, v )

                _ ->
                    Nothing
        )
        >> E.object


{-| Add an optional field decoder. If the field exists, the decoder will fail
if the field doesn't decode properly.

This decoder standard out from `D.maybe <| D.field fieldName decoder` because
that will decode into a `Nothing` if the `decoder` fails. This function
will only decode into a `Nothing` if the field doesn't exist, and will fail if
`decoder` fails.

The function also returns Nothing if the field exists but it is null.

-}
opField : String -> D.Decoder a -> D.Decoder (Maybe a)
opField fieldName decoder =
    D.field fieldName D.value
        |> D.maybe
        |> D.andThen
            (\result ->
                case result of
                    Just _ ->
                        D.oneOf
                            [ D.field fieldName (D.null Nothing)
                            , D.field fieldName decoder
                                |> D.map Just
                            ]

                    Nothing ->
                        D.succeed Nothing
            )


{-| Add an optional field decoder. If the field is not given, the decoder will
return a default value.
-}
opFieldWithDefault : String -> a -> D.Decoder a -> D.Decoder a
opFieldWithDefault fieldName default decoder =
    opField fieldName decoder |> D.map (Maybe.withDefault default)


{-| Encode a timestamp
-}
encodeTimestamp : Time.Posix -> E.Value
encodeTimestamp =
    Time.posixToMillis >> E.int


{-| Decode a timestmap
-}
timestampDecoder : D.Decoder Time.Posix
timestampDecoder =
    D.map Time.millisToPosix D.int
