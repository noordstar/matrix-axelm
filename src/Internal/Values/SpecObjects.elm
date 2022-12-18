module Internal.Values.SpecObjects exposing
    ( AccountData
    , AllowCondition
    , Answer
    , AudioInfo
    , AuthData
    , AuthenticationData
    , AuthenticationResponse
    , Candidate
    , Capabilities
    , Categories
    , ChangePasswordCapability
    , ChildRoomsChunk
    , ClientEvent
    , ClientEventWithoutRoomId
    , ConnectionInfo
    , CrossSigningKey
    , Device
    , DeviceInfo
    , DeviceKeys
    , DiscoveryInformation
    , EncryptedFile
    , Ephemeral
    , Error
    , Event
    , EventContent
    , EventContext
    , EventFilter
    , FieldType
    , FileInfo
    , Filter
    , FlowInformation
    , Group
    , Groupings
    , HomeserverInformation
    , IdP
    , IdentityServerInformation
    , ImageInfo
    , IncludeEventContext
    , Invite
    , Invite3pid
    , InviteEvent
    , InviteState
    , InvitedRoom
    , JoinedRoom
    , Jwk
    , KeyBackupData
    , KnockState
    , KnockedRoom
    , LeftRoom
    , Location
    , LocationInfo
    , LoginFlow
    , Notification
    , Notifications
    , Offer
    , OpenIdCredentials
    , PaginationChunk
    , Presence
    , PreviousRoom
    , Protocol
    , ProtocolInstance
    , PublicKeys
    , PublicRoomsChunk
    , PushCondition
    , PushRule
    , Pusher
    , PusherData
    , RateLimitError
    , RelatesTo
    , RequestTokenResponse
    , RequestedKeyInfo
    , Result
    , ResultCategories
    , ResultRoomEvents
    , Results
    , RoomEventFilter
    , RoomEventsCriteria
    , RoomFilter
    , RoomInfo
    , RoomKeyBackup
    , RoomKeysUpdateResponse
    , RoomMember
    , RoomSummary
    , RoomVersionsCapability
    , Rooms
    , Ruleset
    , SessionData
    , SessionInfo
    , State
    , StateEvent
    , StateFilter
    , StrippedChildStateEvent
    , StrippedStateEvent
    , Tag
    , ThirdPartyIdentifier
    , ThirdPartySigned
    , ThreadNotificationCounts
    , ThreePidCredentials
    , ThumbnailInfo
    , Timeline
    , UnreadNotificationCounts
    , UnsignedData(..)
    , User
    , UserIdentifier
    , UserProfile
    , VerificationRelatesTo
    , VideoInfo
    , accountDataDecoder
    , allowConditionDecoder
    , answerDecoder
    , audioInfoDecoder
    , authDataDecoder
    , authenticationDataDecoder
    , authenticationResponseDecoder
    , candidateDecoder
    , capabilitiesDecoder
    , categoriesDecoder
    , changePasswordCapabilityDecoder
    , childRoomsChunkDecoder
    , clientEventDecoder
    , clientEventWithoutRoomIdDecoder
    , connectionInfoDecoder
    , crossSigningKeyDecoder
    , deviceDecoder
    , deviceInfoDecoder
    , deviceKeysDecoder
    , discoveryInformationDecoder
    , encodeAccountData
    , encodeAllowCondition
    , encodeAnswer
    , encodeAudioInfo
    , encodeAuthData
    , encodeAuthenticationData
    , encodeAuthenticationResponse
    , encodeCandidate
    , encodeCapabilities
    , encodeCategories
    , encodeChangePasswordCapability
    , encodeChildRoomsChunk
    , encodeClientEvent
    , encodeClientEventWithoutRoomId
    , encodeConnectionInfo
    , encodeCrossSigningKey
    , encodeDevice
    , encodeDeviceInfo
    , encodeDeviceKeys
    , encodeDiscoveryInformation
    , encodeEncryptedFile
    , encodeEphemeral
    , encodeError
    , encodeEvent
    , encodeEventContent
    , encodeEventContext
    , encodeEventFilter
    , encodeFieldType
    , encodeFileInfo
    , encodeFilter
    , encodeFlowInformation
    , encodeGroup
    , encodeGroupings
    , encodeHomeserverInformation
    , encodeIdP
    , encodeIdentityServerInformation
    , encodeImageInfo
    , encodeIncludeEventContext
    , encodeInvite
    , encodeInvite3pid
    , encodeInviteEvent
    , encodeInviteState
    , encodeInvitedRoom
    , encodeJoinedRoom
    , encodeJwk
    , encodeKeyBackupData
    , encodeKnockState
    , encodeKnockedRoom
    , encodeLeftRoom
    , encodeLocation
    , encodeLocationInfo
    , encodeLoginFlow
    , encodeNotification
    , encodeNotifications
    , encodeOffer
    , encodeOpenIdCredentials
    , encodePaginationChunk
    , encodePresence
    , encodePreviousRoom
    , encodeProtocol
    , encodeProtocolInstance
    , encodePublicKeys
    , encodePublicRoomsChunk
    , encodePushCondition
    , encodePushRule
    , encodePusher
    , encodePusherData
    , encodeRateLimitError
    , encodeRelatesTo
    , encodeRequestTokenResponse
    , encodeRequestedKeyInfo
    , encodeResult
    , encodeResultCategories
    , encodeResultRoomEvents
    , encodeResults
    , encodeRoomEventFilter
    , encodeRoomEventsCriteria
    , encodeRoomFilter
    , encodeRoomInfo
    , encodeRoomKeyBackup
    , encodeRoomKeysUpdateResponse
    , encodeRoomMember
    , encodeRoomSummary
    , encodeRoomVersionsCapability
    , encodeRooms
    , encodeRuleset
    , encodeSessionData
    , encodeSessionInfo
    , encodeState
    , encodeStateEvent
    , encodeStateFilter
    , encodeStrippedChildStateEvent
    , encodeStrippedStateEvent
    , encodeTag
    , encodeThirdPartyIdentifier
    , encodeThirdPartySigned
    , encodeThreadNotificationCounts
    , encodeThreePidCredentials
    , encodeThumbnailInfo
    , encodeTimeline
    , encodeUnreadNotificationCounts
    , encodeUnsignedData
    , encodeUser
    , encodeUserIdentifier
    , encodeUserProfile
    , encodeVerificationRelatesTo
    , encodeVideoInfo
    , encryptedFileDecoder
    , ephemeralDecoder
    , errorDecoder
    , eventContentDecoder
    , eventContextDecoder
    , eventDecoder
    , eventFilterDecoder
    , fieldTypeDecoder
    , fileInfoDecoder
    , filterDecoder
    , flowInformationDecoder
    , groupDecoder
    , groupingsDecoder
    , homeserverInformationDecoder
    , idPDecoder
    , identityServerInformationDecoder
    , imageInfoDecoder
    , includeEventContextDecoder
    , invite3pidDecoder
    , inviteDecoder
    , inviteEventDecoder
    , inviteStateDecoder
    , invitedRoomDecoder
    , joinedRoomDecoder
    , jwkDecoder
    , keyBackupDataDecoder
    , knockStateDecoder
    , knockedRoomDecoder
    , leftRoomDecoder
    , locationDecoder
    , locationInfoDecoder
    , loginFlowDecoder
    , maybeObject
    , notificationDecoder
    , notificationsDecoder
    , offerDecoder
    , openIdCredentialsDecoder
    , paginationChunkDecoder
    , presenceDecoder
    , previousRoomDecoder
    , protocolDecoder
    , protocolInstanceDecoder
    , publicKeysDecoder
    , publicRoomsChunkDecoder
    , pushConditionDecoder
    , pushRuleDecoder
    , pusherDataDecoder
    , pusherDecoder
    , rateLimitErrorDecoder
    , relatesToDecoder
    , requestTokenResponseDecoder
    , requestedKeyInfoDecoder
    , resultCategoriesDecoder
    , resultDecoder
    , resultRoomEventsDecoder
    , resultsDecoder
    , roomEventFilterDecoder
    , roomEventsCriteriaDecoder
    , roomFilterDecoder
    , roomInfoDecoder
    , roomKeyBackupDecoder
    , roomKeysUpdateResponseDecoder
    , roomMemberDecoder
    , roomSummaryDecoder
    , roomVersionsCapabilityDecoder
    , roomsDecoder
    , rulesetDecoder
    , sessionDataDecoder
    , sessionInfoDecoder
    , stateDecoder
    , stateEventDecoder
    , stateFilterDecoder
    , strippedChildStateEventDecoder
    , strippedStateEventDecoder
    , tagDecoder
    , thirdPartyIdentifierDecoder
    , thirdPartySignedDecoder
    , threadNotificationCountsDecoder
    , threePidCredentialsDecoder
    , thumbnailInfoDecoder
    , timelineDecoder
    , unreadNotificationCountsDecoder
    , unsignedDataDecoder
    , userDecoder
    , userIdentifierDecoder
    , userProfileDecoder
    , verificationRelatesToDecoder
    , videoInfoDecoder
    )

import Dict exposing (Dict)
import Internal.Tools.DecodeExtra exposing (opField, opFieldWithDefault)
import Internal.Tools.Validation as V
import Internal.Values.Enums as Enums
import Json.Decode as D
import Json.Encode as E
import Time


{-| List of events about a user's account.
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


{-| A condition that tells a user when a given user is allowed to do something.
-}
type alias AllowCondition =
    { roomId : Maybe String
    , contentType : Enums.ConditionType
    }


encodeAllowCondition : AllowCondition -> E.Value
encodeAllowCondition data =
    maybeObject
        [ ( "room_id", Maybe.map E.string data.roomId )
        , ( "type", Just <| Enums.encodeConditionType data.contentType )
        ]


allowConditionDecoder : D.Decoder AllowCondition
allowConditionDecoder =
    D.map2
        (\a b ->
            { roomId = a, contentType = b }
        )
        (opField "room_id" smallKeyDecoder)
        (D.field "type" Enums.conditionTypeDecoder)


{-| Session description type that indicates answering a call.
-}
type alias Answer =
    { sdp : String
    , contentType : Enums.SessionDescriptionType
    }


encodeAnswer : Answer -> E.Value
encodeAnswer data =
    maybeObject
        [ ( "sdp", Just <| E.string data.sdp )
        , ( "type", Just <| Enums.encodeSessionDescriptionType data.contentType )
        ]


answerDecoder : D.Decoder Answer
answerDecoder =
    D.map2
        (\a b ->
            { sdp = a, contentType = b }
        )
        (D.field "sdp" D.string)
        (D.field "type" Enums.sessionDescriptionTypeDecoder)


{-| Metadata for an audio clip.
-}
type alias AudioInfo =
    { duration : Maybe Int
    , mimetype : Maybe String
    , size : Maybe Int
    }


encodeAudioInfo : AudioInfo -> E.Value
encodeAudioInfo data =
    maybeObject
        [ ( "duration", Maybe.map E.int data.duration )
        , ( "mimetype", Maybe.map E.string data.mimetype )
        , ( "size", Maybe.map E.int data.size )
        ]


audioInfoDecoder : D.Decoder AudioInfo
audioInfoDecoder =
    D.map3
        (\a b c ->
            { duration = a, mimetype = b, size = c }
        )
        (opField "duration" D.int)
        (opField "mimetype" D.string)
        (opField "size" D.int)


{-| Auth data.
-}
type alias AuthData =
    { publicKey : String
    , signatures : Dict String String
    }


encodeAuthData : AuthData -> E.Value
encodeAuthData data =
    maybeObject
        [ ( "public_key", Just <| E.string data.publicKey )
        , ( "signatures", Just <| E.dict identity E.string data.signatures )
        ]


authDataDecoder : D.Decoder AuthData
authDataDecoder =
    D.map2
        (\a b ->
            { publicKey = a, signatures = b }
        )
        (D.field "public_key" D.string)
        (opFieldWithDefault "signatures" Dict.empty (D.dict D.string))


{-| Authentication Data.
-}
type alias AuthenticationData =
    { session : Maybe String
    , contentType : Maybe String
    }


encodeAuthenticationData : AuthenticationData -> E.Value
encodeAuthenticationData data =
    maybeObject
        [ ( "session", Maybe.map E.string data.session )
        , ( "type", Maybe.map E.string data.contentType )
        ]


authenticationDataDecoder : D.Decoder AuthenticationData
authenticationDataDecoder =
    D.map2
        (\a b ->
            { session = a, contentType = b }
        )
        (opField "session" D.string)
        (opField "type" D.string)


{-| Response that indicates the homeserver requires additional authentication information.
-}
type alias AuthenticationResponse =
    { completed : List String
    , flows : List FlowInformation
    , params : Dict String (Dict String E.Value)
    , session : Maybe String
    }


encodeAuthenticationResponse : AuthenticationResponse -> E.Value
encodeAuthenticationResponse data =
    maybeObject
        [ ( "completed", Just <| E.list E.string data.completed )
        , ( "flows", Just <| E.list encodeFlowInformation data.flows )
        , ( "params", Just <| E.dict identity (E.dict identity identity) data.params )
        , ( "session", Maybe.map E.string data.session )
        ]


authenticationResponseDecoder : D.Decoder AuthenticationResponse
authenticationResponseDecoder =
    D.map4
        (\a b c d ->
            { completed = a, flows = b, params = c, session = d }
        )
        (opFieldWithDefault "completed" [] (D.list D.string))
        (D.field "flows" (D.list flowInformationDecoder))
        (opFieldWithDefault "params" Dict.empty (D.dict (D.dict D.value)))
        (opField "session" D.string)


{-| ICE Candidates to communicate with
-}
type alias Candidate =
    { candidate : String
    , sdpmlineindex : Int
    , sdpmid : String
    }


encodeCandidate : Candidate -> E.Value
encodeCandidate data =
    maybeObject
        [ ( "candidate", Just <| E.string data.candidate )
        , ( "sdpMLineIndex", Just <| E.int data.sdpmlineindex )
        , ( "sdpMid", Just <| E.string data.sdpmid )
        ]


candidateDecoder : D.Decoder Candidate
candidateDecoder =
    D.map3
        (\a b c ->
            { candidate = a, sdpmlineindex = b, sdpmid = c }
        )
        (D.field "candidate" D.string)
        (D.field "sdpMLineIndex" D.int)
        (D.field "sdpMid" D.string)


{-| Server capabilities.
-}
type alias Capabilities =
    { mChangePassword : Maybe ChangePasswordCapability
    , mRoomVersions : Maybe RoomVersionsCapability
    , all : Dict String E.Value
    }


encodeCapabilities : Capabilities -> E.Value
encodeCapabilities data =
    maybeObject
        [ ( "m.change_password", Maybe.map encodeChangePasswordCapability data.mChangePassword )
        , ( "m.room_versions", Maybe.map encodeRoomVersionsCapability data.mRoomVersions )
        , ( "all", Just <| E.dict identity identity data.all )
        ]


capabilitiesDecoder : D.Decoder Capabilities
capabilitiesDecoder =
    D.map3
        (\a b c ->
            { mChangePassword = a, mRoomVersions = b, all = c }
        )
        (opField "m.change_password" changePasswordCapabilityDecoder)
        (opField "m.room_versions" roomVersionsCapabilityDecoder)
        (D.field "all" (D.dict D.value))


{-| Categories and criteria to search in.
-}
type alias Categories =
    { roomEvents : Maybe RoomEventsCriteria
    }


encodeCategories : Categories -> E.Value
encodeCategories data =
    maybeObject
        [ ( "room_events", Maybe.map encodeRoomEventsCriteria data.roomEvents )
        ]


categoriesDecoder : D.Decoder Categories
categoriesDecoder =
    D.map
        (\a ->
            { roomEvents = a }
        )
        (opField "room_events" roomEventsCriteriaDecoder)


{-| Capability whether the homeserver supports changing passwords.
-}
type alias ChangePasswordCapability =
    { enabled : Bool
    }


encodeChangePasswordCapability : ChangePasswordCapability -> E.Value
encodeChangePasswordCapability data =
    maybeObject
        [ ( "enabled", Just <| E.bool data.enabled )
        ]


changePasswordCapabilityDecoder : D.Decoder ChangePasswordCapability
changePasswordCapabilityDecoder =
    D.map
        (\a ->
            { enabled = a }
        )
        (D.field "enabled" D.bool)


{-| A portion of a space tree.
-}
type alias ChildRoomsChunk =
    { avatarUrl : Maybe String
    , canonicalAlias : Maybe String
    , childrenState : List StrippedChildStateEvent
    , guestCanJoin : Bool
    , joinRule : Enums.JoinRules
    , name : Maybe String
    , numJoinedMembers : Int
    , roomId : String
    , roomType : Maybe String
    , topic : Maybe String
    , worldReadable : Bool
    }


encodeChildRoomsChunk : ChildRoomsChunk -> E.Value
encodeChildRoomsChunk data =
    maybeObject
        [ ( "avatar_url", Maybe.map E.string data.avatarUrl )
        , ( "canonical_alias", Maybe.map E.string data.canonicalAlias )
        , ( "children_state", Just <| E.list encodeStrippedChildStateEvent data.childrenState )
        , ( "guest_can_join", Just <| E.bool data.guestCanJoin )
        , ( "join_rule", Just <| Enums.encodeJoinRules data.joinRule )
        , ( "name", Maybe.map E.string data.name )
        , ( "num_joined_members", Just <| E.int data.numJoinedMembers )
        , ( "room_id", Just <| E.string data.roomId )
        , ( "room_type", Maybe.map E.string data.roomType )
        , ( "topic", Maybe.map E.string data.topic )
        , ( "world_readable", Just <| E.bool data.worldReadable )
        ]


childRoomsChunkDecoder : D.Decoder ChildRoomsChunk
childRoomsChunkDecoder =
    D.map8
        (\a b c d e ( f, g ) ( h, i ) ( j, k ) ->
            { avatarUrl = a, canonicalAlias = b, childrenState = c, guestCanJoin = d, joinRule = e, name = f, numJoinedMembers = g, roomId = h, roomType = i, topic = j, worldReadable = k }
        )
        (opField "avatar_url" D.string)
        (opField "canonical_alias" D.string)
        (D.field "children_state" (D.list strippedChildStateEventDecoder))
        (D.field "guest_can_join" D.bool)
        (opFieldWithDefault "join_rule" Enums.Public Enums.joinRulesDecoder)
        (D.map2 Tuple.pair
            (opField "name" D.string)
            (D.field "num_joined_members" D.int)
        )
        (D.map2 Tuple.pair
            (D.field "room_id" smallKeyDecoder)
            (opField "room_type" D.string)
        )
        (D.map2 Tuple.pair
            (opField "topic" D.string)
            (D.field "world_readable" D.bool)
        )


{-| A client event.
-}
type alias ClientEvent =
    { content : EventContent
    , eventId : String
    , originServerTs : Time.Posix
    , roomId : String
    , sender : String
    , stateKey : Maybe String
    , contentType : String
    , unsigned : Maybe UnsignedData
    }


encodeClientEvent : ClientEvent -> E.Value
encodeClientEvent data =
    maybeObject
        [ ( "content", Just <| encodeEventContent data.content )
        , ( "event_id", Just <| E.string data.eventId )
        , ( "origin_server_ts", Just <| encodeTimestamp data.originServerTs )
        , ( "room_id", Just <| E.string data.roomId )
        , ( "sender", Just <| E.string data.sender )
        , ( "state_key", Maybe.map E.string data.stateKey )
        , ( "type", Just <| E.string data.contentType )
        , ( "unsigned", Maybe.map encodeUnsignedData data.unsigned )
        ]


clientEventDecoder : D.Decoder ClientEvent
clientEventDecoder =
    D.map8
        (\a b c d e f g h ->
            { content = a, eventId = b, originServerTs = c, roomId = d, sender = e, stateKey = f, contentType = g, unsigned = h }
        )
        (D.field "content" eventContentDecoder)
        (D.field "event_id" D.string)
        (D.field "origin_server_ts" timestampDecoder)
        (D.field "room_id" smallKeyDecoder)
        (D.field "sender" smallKeyDecoder)
        (opField "state_key" smallKeyDecoder)
        (D.field "type" smallKeyDecoder)
        (D.field "type" smallKeyDecoder
            |> D.andThen
                (\s -> opField "unsigned" (unsignedDataDecoder s))
        )


{-| Client Event that does not contain the Room ID
-}
type alias ClientEventWithoutRoomId =
    { content : EventContent
    , eventId : String
    , originServerTs : Time.Posix
    , sender : String
    , stateKey : Maybe String
    , contentType : String
    , unsigned : Maybe UnsignedData
    }


encodeClientEventWithoutRoomId : ClientEventWithoutRoomId -> E.Value
encodeClientEventWithoutRoomId data =
    maybeObject
        [ ( "content", Just <| encodeEventContent data.content )
        , ( "event_id", Just <| E.string data.eventId )
        , ( "origin_server_ts", Just <| encodeTimestamp data.originServerTs )
        , ( "sender", Just <| E.string data.sender )
        , ( "state_key", Maybe.map E.string data.stateKey )
        , ( "type", Just <| E.string data.contentType )
        , ( "unsigned", Maybe.map encodeUnsignedData data.unsigned )
        ]


clientEventWithoutRoomIdDecoder : D.Decoder ClientEventWithoutRoomId
clientEventWithoutRoomIdDecoder =
    D.map7
        (\a b c d e f g ->
            { content = a, eventId = b, originServerTs = c, sender = d, stateKey = e, contentType = f, unsigned = g }
        )
        (D.field "content" eventContentDecoder)
        (D.field "event_id" D.string)
        (D.field "origin_server_ts" timestampDecoder)
        (D.field "sender" smallKeyDecoder)
        (opField "state_key" smallKeyDecoder)
        (D.field "type" smallKeyDecoder)
        (D.field "type" smallKeyDecoder
            |> D.andThen
                (\s -> opField "unsigned" (unsignedDataDecoder s))
        )


{-| Information particular connection in a session.
-}
type alias ConnectionInfo =
    { ip : Maybe String
    , lastSeen : Maybe Time.Posix
    , userAgent : Maybe String
    }


encodeConnectionInfo : ConnectionInfo -> E.Value
encodeConnectionInfo data =
    maybeObject
        [ ( "ip", Maybe.map E.string data.ip )
        , ( "last_seen", Maybe.map encodeTimestamp data.lastSeen )
        , ( "user_agent", Maybe.map E.string data.userAgent )
        ]


connectionInfoDecoder : D.Decoder ConnectionInfo
connectionInfoDecoder =
    D.map3
        (\a b c ->
            { ip = a, lastSeen = b, userAgent = c }
        )
        (opField "ip" D.string)
        (opField "last_seen" timestampDecoder)
        (opField "user_agent" D.string)


{-| Cross signing key.
-}
type alias CrossSigningKey =
    { keys : Dict String String
    , signatures : Maybe (Dict String (Dict String String))
    , usage : List String
    , userId : String
    }


encodeCrossSigningKey : CrossSigningKey -> E.Value
encodeCrossSigningKey data =
    maybeObject
        [ ( "keys", Just <| E.dict identity E.string data.keys )
        , ( "signatures", Maybe.map (E.dict identity (E.dict identity E.string)) data.signatures )
        , ( "usage", Just <| E.list E.string data.usage )
        , ( "user_id", Just <| E.string data.userId )
        ]


crossSigningKeyDecoder : D.Decoder CrossSigningKey
crossSigningKeyDecoder =
    D.map4
        (\a b c d ->
            { keys = a, signatures = b, usage = c, userId = d }
        )
        (D.field "keys" (D.dict D.string))
        (opField "signatures" (D.dict (D.dict D.string)))
        (D.field "usage" (D.list D.string))
        (D.field "user_id" D.string)


{-| Registered devices for a user.
-}
type alias Device =
    { deviceId : String
    , displayName : Maybe String
    , lastSeenIp : Maybe String
    , lastSeenTs : Maybe Time.Posix
    }


encodeDevice : Device -> E.Value
encodeDevice data =
    maybeObject
        [ ( "device_id", Just <| E.string data.deviceId )
        , ( "display_name", Maybe.map E.string data.displayName )
        , ( "last_seen_ip", Maybe.map E.string data.lastSeenIp )
        , ( "last_seen_ts", Maybe.map encodeTimestamp data.lastSeenTs )
        ]


deviceDecoder : D.Decoder Device
deviceDecoder =
    D.map4
        (\a b c d ->
            { deviceId = a, displayName = b, lastSeenIp = c, lastSeenTs = d }
        )
        (D.field "device_id" D.string)
        (opField "display_name" D.string)
        (opField "last_seen_ip" D.string)
        (opField "last_seen_ts" timestampDecoder)


{-| Additional information about a device.
-}
type alias DeviceInfo =
    { sessions : List SessionInfo
    }


encodeDeviceInfo : DeviceInfo -> E.Value
encodeDeviceInfo data =
    maybeObject
        [ ( "sessions", Just <| E.list encodeSessionInfo data.sessions )
        ]


deviceInfoDecoder : D.Decoder DeviceInfo
deviceInfoDecoder =
    D.map
        (\a ->
            { sessions = a }
        )
        (opFieldWithDefault "sessions" [] (D.list sessionInfoDecoder))


{-| Indentity keys for a device
-}
type alias DeviceKeys =
    { algorithms : List String
    , deviceId : String
    , keys : Dict String String
    , signatures : Dict String (Dict String String)
    , userId : String
    }


encodeDeviceKeys : DeviceKeys -> E.Value
encodeDeviceKeys data =
    maybeObject
        [ ( "algorithms", Just <| E.list E.string data.algorithms )
        , ( "device_id", Just <| E.string data.deviceId )
        , ( "keys", Just <| E.dict identity E.string data.keys )
        , ( "signatures", Just <| E.dict identity (E.dict identity E.string) data.signatures )
        , ( "user_id", Just <| E.string data.userId )
        ]


deviceKeysDecoder : D.Decoder DeviceKeys
deviceKeysDecoder =
    D.map5
        (\a b c d e ->
            { algorithms = a, deviceId = b, keys = c, signatures = d, userId = e }
        )
        (D.field "algorithms" (D.list D.string))
        (D.field "device_id" D.string)
        (D.field "keys" (D.dict D.string))
        (D.field "signatures" (D.dict (D.dict D.string)))
        (D.field "user_id" D.string)


{-| Server discovery information, telling the user where to find the server.
-}
type alias DiscoveryInformation =
    { mHomeserver : HomeserverInformation
    , mIdentityServer : Maybe IdentityServerInformation
    }


encodeDiscoveryInformation : DiscoveryInformation -> E.Value
encodeDiscoveryInformation data =
    maybeObject
        [ ( "m.homeserver", Just <| encodeHomeserverInformation data.mHomeserver )
        , ( "m.identity_server", Maybe.map encodeIdentityServerInformation data.mIdentityServer )
        ]


discoveryInformationDecoder : D.Decoder DiscoveryInformation
discoveryInformationDecoder =
    D.map2
        (\a b ->
            { mHomeserver = a, mIdentityServer = b }
        )
        (D.field "m.homeserver" homeserverInformationDecoder)
        (opField "m.identity_server" identityServerInformationDecoder)


{-| Information about an encrypted file.
-}
type alias EncryptedFile =
    { url : String
    , key : Jwk
    , iv : String
    , hashes : Dict String String
    , v : String
    }


encodeEncryptedFile : EncryptedFile -> E.Value
encodeEncryptedFile data =
    maybeObject
        [ ( "url", Just <| E.string data.url )
        , ( "key", Just <| encodeJwk data.key )
        , ( "iv", Just <| E.string data.iv )
        , ( "hashes", Just <| E.dict identity E.string data.hashes )
        , ( "v", Just <| E.string data.v )
        ]


encryptedFileDecoder : D.Decoder EncryptedFile
encryptedFileDecoder =
    D.map5
        (\a b c d e ->
            { url = a, key = b, iv = c, hashes = d, v = e }
        )
        (D.field "url" D.string)
        (D.field "key" jwkDecoder)
        (D.field "iv" D.string)
        (D.field "hashes" (D.dict D.string))
        (D.field "v" D.string)


{-| Ephemeral data
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


{-| Error.
-}
type alias Error =
    { errcode : String
    , error : Maybe String
    }


encodeError : Error -> E.Value
encodeError data =
    maybeObject
        [ ( "errcode", Just <| E.string data.errcode )
        , ( "error", Maybe.map E.string data.error )
        ]


errorDecoder : D.Decoder Error
errorDecoder =
    D.map2
        (\a b ->
            { errcode = a, error = b }
        )
        (D.field "errcode" D.string)
        (opField "error" D.string)


{-| Most general event type.
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
        (D.field "type" smallKeyDecoder)


type alias EventContent =
    E.Value


encodeEventContent : EventContent -> E.Value
encodeEventContent =
    identity


eventContentDecoder : D.Decoder EventContent
eventContentDecoder =
    D.value


{-| Event context.
-}
type alias EventContext =
    { end : Maybe String
    , eventsAfter : Maybe (List Event)
    , eventsBefore : Maybe (List Event)
    , profileInfo : Dict String (Dict String String)
    , start : Maybe String
    }


encodeEventContext : EventContext -> E.Value
encodeEventContext data =
    maybeObject
        [ ( "end", Maybe.map E.string data.end )
        , ( "events_after", Maybe.map (E.list encodeEvent) data.eventsAfter )
        , ( "events_before", Maybe.map (E.list encodeEvent) data.eventsBefore )
        , ( "profile_info", Just <| E.dict identity (E.dict identity E.string) data.profileInfo )
        , ( "start", Maybe.map E.string data.start )
        ]


eventContextDecoder : D.Decoder EventContext
eventContextDecoder =
    D.map5
        (\a b c d e ->
            { end = a, eventsAfter = b, eventsBefore = c, profileInfo = d, start = e }
        )
        (opField "end" D.string)
        (opField "events_after" (D.list eventDecoder))
        (opField "events_before" (D.list eventDecoder))
        (opFieldWithDefault "profile_info" Dict.empty (D.dict (D.dict D.string)))
        (opField "start" D.string)


{-| A filter specifying which events to include or exclude.
-}
type alias EventFilter =
    { limit : Maybe Int
    , notSenders : Maybe (List String)
    , notTypes : Maybe (List String)
    , senders : Maybe (List String)
    , types : Maybe (List String)
    }


encodeEventFilter : EventFilter -> E.Value
encodeEventFilter data =
    maybeObject
        [ ( "limit", Maybe.map E.int data.limit )
        , ( "not_senders", Maybe.map (E.list E.string) data.notSenders )
        , ( "not_types", Maybe.map (E.list E.string) data.notTypes )
        , ( "senders", Maybe.map (E.list E.string) data.senders )
        , ( "types", Maybe.map (E.list E.string) data.types )
        ]


eventFilterDecoder : D.Decoder EventFilter
eventFilterDecoder =
    D.map5
        (\a b c d e ->
            { limit = a, notSenders = b, notTypes = c, senders = d, types = e }
        )
        (opField "limit" D.int)
        (opField "not_senders" (D.list smallKeyDecoder))
        (opField "not_types" (D.list D.string))
        (opField "senders" (D.list smallKeyDecoder))
        (opField "types" (D.list D.string))


{-| Information about a field on a third party's communication protocol.
-}
type alias FieldType =
    { placeholder : String
    , regexp : String
    }


encodeFieldType : FieldType -> E.Value
encodeFieldType data =
    maybeObject
        [ ( "placeholder", Just <| E.string data.placeholder )
        , ( "regexp", Just <| E.string data.regexp )
        ]


fieldTypeDecoder : D.Decoder FieldType
fieldTypeDecoder =
    D.map2
        (\a b ->
            { placeholder = a, regexp = b }
        )
        (D.field "placeholder" D.string)
        (D.field "regexp" D.string)


{-| Information about a file.
-}
type alias FileInfo =
    { mimetype : Maybe String
    , size : Maybe Int
    , thumbnailFile : Maybe EncryptedFile
    , thumbnailInfo : Maybe ThumbnailInfo
    , thumbnailUrl : Maybe String
    }


encodeFileInfo : FileInfo -> E.Value
encodeFileInfo data =
    maybeObject
        [ ( "mimetype", Maybe.map E.string data.mimetype )
        , ( "size", Maybe.map E.int data.size )
        , ( "thumbnail_file", Maybe.map encodeEncryptedFile data.thumbnailFile )
        , ( "thumbnail_info", Maybe.map encodeThumbnailInfo data.thumbnailInfo )
        , ( "thumbnail_url", Maybe.map E.string data.thumbnailUrl )
        ]


fileInfoDecoder : D.Decoder FileInfo
fileInfoDecoder =
    D.map5
        (\a b c d e ->
            { mimetype = a, size = b, thumbnailFile = c, thumbnailInfo = d, thumbnailUrl = e }
        )
        (opField "mimetype" D.string)
        (opField "size" D.int)
        (opField "thumbnail_file" encryptedFileDecoder)
        (opField "thumbnail_info" thumbnailInfoDecoder)
        (opField "thumbnail_url" D.string)


{-| A filter on events.
-}
type alias Filter =
    { containsUrl : Maybe Bool
    , includeRedundantMembers : Bool
    , lazyLoadMembers : Bool
    , limit : Maybe Int
    , notRooms : List String
    , notSenders : List String
    , notTypes : List String
    , rooms : Maybe (List String)
    , senders : Maybe (List String)
    , types : Maybe (List String)
    , unreadThreadNotifications : Bool
    }


encodeFilter : Filter -> E.Value
encodeFilter data =
    maybeObject
        [ ( "contains_url", Maybe.map E.bool data.containsUrl )
        , ( "include_redundant_members", Just <| E.bool data.includeRedundantMembers )
        , ( "lazy_load_members", Just <| E.bool data.lazyLoadMembers )
        , ( "limit", Maybe.map E.int data.limit )
        , ( "not_rooms", Just <| E.list E.string data.notRooms )
        , ( "not_senders", Just <| E.list E.string data.notSenders )
        , ( "not_types", Just <| E.list E.string data.notTypes )
        , ( "rooms", Maybe.map (E.list E.string) data.rooms )
        , ( "senders", Maybe.map (E.list E.string) data.senders )
        , ( "types", Maybe.map (E.list E.string) data.types )
        , ( "unread_thread_notifications", Just <| E.bool data.unreadThreadNotifications )
        ]


filterDecoder : D.Decoder Filter
filterDecoder =
    D.map8
        (\a b c d e ( f, g ) ( h, i ) ( j, k ) ->
            { containsUrl = a, includeRedundantMembers = b, lazyLoadMembers = c, limit = d, notRooms = e, notSenders = f, notTypes = g, rooms = h, senders = i, types = j, unreadThreadNotifications = k }
        )
        (opField "contains_url" D.bool)
        (opFieldWithDefault "include_redundant_members" False D.bool)
        (opFieldWithDefault "lazy_load_members" False D.bool)
        (opField "limit" D.int)
        (opFieldWithDefault "not_rooms" [] (D.list D.string))
        (D.map2 Tuple.pair
            (opFieldWithDefault "not_senders" [] (D.list smallKeyDecoder))
            (opFieldWithDefault "not_types" [] (D.list D.string))
        )
        (D.map2 Tuple.pair
            (opField "rooms" (D.list D.string))
            (opField "senders" (D.list smallKeyDecoder))
        )
        (D.map2 Tuple.pair
            (opField "types" (D.list D.string))
            (opFieldWithDefault "unread_thread_notifications" False D.bool)
        )


{-| Provided flow information.
-}
type alias FlowInformation =
    { stages : List String
    }


encodeFlowInformation : FlowInformation -> E.Value
encodeFlowInformation data =
    maybeObject
        [ ( "stages", Just <| E.list E.string data.stages )
        ]


flowInformationDecoder : D.Decoder FlowInformation
flowInformationDecoder =
    D.map
        (\a ->
            { stages = a }
        )
        (D.field "stages" (D.list D.string))


{-| Groups to divide events with.
-}
type alias Group =
    { key : Maybe Enums.GroupKey
    }


encodeGroup : Group -> E.Value
encodeGroup data =
    maybeObject
        [ ( "key", Maybe.map Enums.encodeGroupKey data.key )
        ]


groupDecoder : D.Decoder Group
groupDecoder =
    D.map
        (\a ->
            { key = a }
        )
        (opField "key" Enums.groupKeyDecoder)


{-| List of groups to request.
-}
type alias Groupings =
    { groupBy : List Group
    }


encodeGroupings : Groupings -> E.Value
encodeGroupings data =
    maybeObject
        [ ( "group_by", Just <| E.list encodeGroup data.groupBy )
        ]


groupingsDecoder : D.Decoder Groupings
groupingsDecoder =
    D.map
        (\a ->
            { groupBy = a }
        )
        (opFieldWithDefault "group_by" [] (D.list groupDecoder))


{-| Information about the homeserver.
-}
type alias HomeserverInformation =
    { baseUrl : String
    }


encodeHomeserverInformation : HomeserverInformation -> E.Value
encodeHomeserverInformation data =
    maybeObject
        [ ( "base_url", Just <| E.string data.baseUrl )
        ]


homeserverInformationDecoder : D.Decoder HomeserverInformation
homeserverInformationDecoder =
    D.map
        (\a ->
            { baseUrl = a }
        )
        (D.field "base_url" D.string)


{-| Identity Provider for an SSO login
-}
type alias IdP =
    { brand : Maybe String
    , icon : Maybe String
    , id : String
    , name : String
    }


encodeIdP : IdP -> E.Value
encodeIdP data =
    maybeObject
        [ ( "brand", Maybe.map E.string data.brand )
        , ( "icon", Maybe.map E.string data.icon )
        , ( "id", Just <| E.string data.id )
        , ( "name", Just <| E.string data.name )
        ]


idPDecoder : D.Decoder IdP
idPDecoder =
    D.map4
        (\a b c d ->
            { brand = a, icon = b, id = c, name = d }
        )
        (opField "brand" D.string)
        (opField "icon" D.string)
        (D.field "id" D.string)
        (D.field "name" D.string)


{-| base\_url
-}
type alias IdentityServerInformation =
    { baseUrl : String
    }


encodeIdentityServerInformation : IdentityServerInformation -> E.Value
encodeIdentityServerInformation data =
    maybeObject
        [ ( "base_url", Just <| E.string data.baseUrl )
        ]


identityServerInformationDecoder : D.Decoder IdentityServerInformation
identityServerInformationDecoder =
    D.map
        (\a ->
            { baseUrl = a }
        )
        (D.field "base_url" D.string)


{-| Information about an image.
-}
type alias ImageInfo =
    { h : Maybe Int
    , mimetype : Maybe String
    , size : Maybe Int
    , thumbnailFile : Maybe EncryptedFile
    , thumbnailInfo : Maybe ThumbnailInfo
    , thumbnailUrl : Maybe String
    , w : Maybe Int
    }


encodeImageInfo : ImageInfo -> E.Value
encodeImageInfo data =
    maybeObject
        [ ( "h", Maybe.map E.int data.h )
        , ( "mimetype", Maybe.map E.string data.mimetype )
        , ( "size", Maybe.map E.int data.size )
        , ( "thumbnail_file", Maybe.map encodeEncryptedFile data.thumbnailFile )
        , ( "thumbnail_info", Maybe.map encodeThumbnailInfo data.thumbnailInfo )
        , ( "thumbnail_url", Maybe.map E.string data.thumbnailUrl )
        , ( "w", Maybe.map E.int data.w )
        ]


imageInfoDecoder : D.Decoder ImageInfo
imageInfoDecoder =
    D.map7
        (\a b c d e f g ->
            { h = a, mimetype = b, size = c, thumbnailFile = d, thumbnailInfo = e, thumbnailUrl = f, w = g }
        )
        (opField "h" D.int)
        (opField "mimetype" D.string)
        (opField "size" D.int)
        (opField "thumbnail_file" encryptedFileDecoder)
        (opField "thumbnail_info" thumbnailInfoDecoder)
        (opField "thumbnail_url" D.string)
        (opField "w" D.int)


{-| Event context
-}
type alias IncludeEventContext =
    { afterLimit : Int
    , beforeLimit : Int
    , includeProfile : Bool
    }


encodeIncludeEventContext : IncludeEventContext -> E.Value
encodeIncludeEventContext data =
    maybeObject
        [ ( "after_limit", Just <| E.int data.afterLimit )
        , ( "before_limit", Just <| E.int data.beforeLimit )
        , ( "include_profile", Just <| E.bool data.includeProfile )
        ]


includeEventContextDecoder : D.Decoder IncludeEventContext
includeEventContextDecoder =
    D.map3
        (\a b c ->
            { afterLimit = a, beforeLimit = b, includeProfile = c }
        )
        (opFieldWithDefault "after_limit" 5 D.int)
        (opFieldWithDefault "before_limit" 5 D.int)
        (opFieldWithDefault "include_profile" False D.bool)


{-| An invite that a user may receive.
-}
type alias Invite =
    { displayName : String
    , signed : E.Value
    }


encodeInvite : Invite -> E.Value
encodeInvite data =
    maybeObject
        [ ( "display_name", Just <| E.string data.displayName )
        , ( "signed", Just <| data.signed )
        ]


inviteDecoder : D.Decoder Invite
inviteDecoder =
    D.map2
        (\a b ->
            { displayName = a, signed = b }
        )
        (D.field "display_name" D.string)
        (D.field "signed" D.value)


{-| An invite to a 3pid user.
-}
type alias Invite3pid =
    { address : String
    , idAccessToken : String
    , idServer : String
    , medium : String
    }


encodeInvite3pid : Invite3pid -> E.Value
encodeInvite3pid data =
    maybeObject
        [ ( "address", Just <| E.string data.address )
        , ( "id_access_token", Just <| E.string data.idAccessToken )
        , ( "id_server", Just <| E.string data.idServer )
        , ( "medium", Just <| E.string data.medium )
        ]


invite3pidDecoder : D.Decoder Invite3pid
invite3pidDecoder =
    D.map4
        (\a b c d ->
            { address = a, idAccessToken = b, idServer = c, medium = d }
        )
        (D.field "address" D.string)
        (D.field "id_access_token" D.string)
        (D.field "id_server" D.string)
        (D.field "medium" D.string)


{-| Invite Event.
-}
type alias InviteEvent =
    { content : EventContent
    , eventId : String
    , originServerTs : Time.Posix
    , roomId : String
    , sender : String
    , stateKey : Maybe String
    , contentType : String
    , unsigned : Maybe UnsignedData
    }


encodeInviteEvent : InviteEvent -> E.Value
encodeInviteEvent data =
    maybeObject
        [ ( "content", Just <| encodeEventContent data.content )
        , ( "event_id", Just <| E.string data.eventId )
        , ( "origin_server_ts", Just <| encodeTimestamp data.originServerTs )
        , ( "room_id", Just <| E.string data.roomId )
        , ( "sender", Just <| E.string data.sender )
        , ( "state_key", Maybe.map E.string data.stateKey )
        , ( "type", Just <| E.string data.contentType )
        , ( "unsigned", Maybe.map encodeUnsignedData data.unsigned )
        ]


inviteEventDecoder : D.Decoder InviteEvent
inviteEventDecoder =
    D.map8
        (\a b c d e f g h ->
            { content = a, eventId = b, originServerTs = c, roomId = d, sender = e, stateKey = f, contentType = g, unsigned = h }
        )
        (D.field "content" eventContentDecoder)
        (D.field "event_id" D.string)
        (D.field "origin_server_ts" timestampDecoder)
        (D.field "room_id" smallKeyDecoder)
        (D.field "sender" smallKeyDecoder)
        (opField "state_key" smallKeyDecoder)
        (D.field "type" smallKeyDecoder)
        (D.field "type" smallKeyDecoder
            |> D.andThen
                (\s -> opField "unsigned" (unsignedDataDecoder s))
        )


{-| Stripped state event that forms an invite.
-}
type alias InviteState =
    { events : List StrippedStateEvent
    }


encodeInviteState : InviteState -> E.Value
encodeInviteState data =
    maybeObject
        [ ( "events", Just <| E.list encodeStrippedStateEvent data.events )
        ]


inviteStateDecoder : D.Decoder InviteState
inviteStateDecoder =
    D.map
        (\a ->
            { events = a }
        )
        (opFieldWithDefault "events" [] (D.list strippedStateEventDecoder))


{-| A room that the user has been invited to.
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


{-| A room that the user is a joined member of.
-}
type alias JoinedRoom =
    { accountData : Maybe AccountData
    , ephemeral : Maybe Ephemeral
    , state : Maybe State
    , summary : Maybe RoomSummary
    , timeline : Maybe Timeline
    , unreadNotifications : Maybe UnreadNotificationCounts
    , unreadThreadNotifications : Dict String ThreadNotificationCounts
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
        , ( "unread_thread_notifications", Just <| E.dict identity encodeThreadNotificationCounts data.unreadThreadNotifications )
        ]


joinedRoomDecoder : D.Decoder JoinedRoom
joinedRoomDecoder =
    D.map7
        (\a b c d e f g ->
            { accountData = a, ephemeral = b, state = c, summary = d, timeline = e, unreadNotifications = f, unreadThreadNotifications = g }
        )
        (opField "account_data" accountDataDecoder)
        (opField "ephemeral" ephemeralDecoder)
        (opField "state" stateDecoder)
        (opField "summary" roomSummaryDecoder)
        (opField "timeline" timelineDecoder)
        (opField "unread_notifications" unreadNotificationCountsDecoder)
        (opFieldWithDefault "unread_thread_notifications" Dict.empty (D.dict threadNotificationCountsDecoder))


{-| JSON Web Key object.
-}
type alias Jwk =
    { kty : String
    , keyOps : List String
    , alg : String
    , k : String
    , ext : Bool
    }


encodeJwk : Jwk -> E.Value
encodeJwk data =
    maybeObject
        [ ( "kty", Just <| E.string data.kty )
        , ( "key_ops", Just <| E.list E.string data.keyOps )
        , ( "alg", Just <| E.string data.alg )
        , ( "k", Just <| E.string data.k )
        , ( "ext", Just <| E.bool data.ext )
        ]


jwkDecoder : D.Decoder Jwk
jwkDecoder =
    D.map5
        (\a b c d e ->
            { kty = a, keyOps = b, alg = c, k = d, ext = e }
        )
        (D.field "kty" D.string)
        (D.field "key_ops" (D.list D.string))
        (D.field "alg" D.string)
        (D.field "k" D.string)
        (D.field "ext" D.bool)


{-| Backup data of a key
-}
type alias KeyBackupData =
    { firstMessageIndex : Int
    , forwardedCount : Int
    , isVerified : Bool
    , sessionData : E.Value
    }


encodeKeyBackupData : KeyBackupData -> E.Value
encodeKeyBackupData data =
    maybeObject
        [ ( "first_message_index", Just <| E.int data.firstMessageIndex )
        , ( "forwarded_count", Just <| E.int data.forwardedCount )
        , ( "is_verified", Just <| E.bool data.isVerified )
        , ( "session_data", Just <| data.sessionData )
        ]


keyBackupDataDecoder : D.Decoder KeyBackupData
keyBackupDataDecoder =
    D.map4
        (\a b c d ->
            { firstMessageIndex = a, forwardedCount = b, isVerified = c, sessionData = d }
        )
        (D.field "first_message_index" D.int)
        (D.field "forwarded_count" D.int)
        (D.field "is_verified" D.bool)
        (D.field "session_data" D.value)


{-| Updates to the state of a knocked room.
-}
type alias KnockState =
    { events : List StrippedStateEvent
    }


encodeKnockState : KnockState -> E.Value
encodeKnockState data =
    maybeObject
        [ ( "events", Just <| E.list encodeStrippedStateEvent data.events )
        ]


knockStateDecoder : D.Decoder KnockState
knockStateDecoder =
    D.map
        (\a ->
            { events = a }
        )
        (opFieldWithDefault "events" [] (D.list strippedStateEventDecoder))


{-| The state of a room that the user has knocked upon.
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


{-| The state of a room that the user has left.
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


{-| Matrix aliases for third party locations.
-}
type alias Location =
    { alias : String
    , fields : Dict String E.Value
    , protocol : String
    }


encodeLocation : Location -> E.Value
encodeLocation data =
    maybeObject
        [ ( "alias", Just <| E.string data.alias )
        , ( "fields", Just <| E.dict identity identity data.fields )
        , ( "protocol", Just <| E.string data.protocol )
        ]


locationDecoder : D.Decoder Location
locationDecoder =
    D.map3
        (\a b c ->
            { alias = a, fields = b, protocol = c }
        )
        (D.field "alias" D.string)
        (D.field "fields" (D.dict D.value))
        (D.field "protocol" D.string)


{-| A location file containing metadata about a geographical location.
-}
type alias LocationInfo =
    { thumbnailFile : Maybe EncryptedFile
    , thumbnailInfo : Maybe ThumbnailInfo
    , thumbnailUrl : Maybe String
    }


encodeLocationInfo : LocationInfo -> E.Value
encodeLocationInfo data =
    maybeObject
        [ ( "thumbnail_file", Maybe.map encodeEncryptedFile data.thumbnailFile )
        , ( "thumbnail_info", Maybe.map encodeThumbnailInfo data.thumbnailInfo )
        , ( "thumbnail_url", Maybe.map E.string data.thumbnailUrl )
        ]


locationInfoDecoder : D.Decoder LocationInfo
locationInfoDecoder =
    D.map3
        (\a b c ->
            { thumbnailFile = a, thumbnailInfo = b, thumbnailUrl = c }
        )
        (opField "thumbnail_file" encryptedFileDecoder)
        (opField "thumbnail_info" thumbnailInfoDecoder)
        (opField "thumbnail_url" D.string)


{-| Supported login type by the homeserver.
-}
type alias LoginFlow =
    { contentType : Maybe String
    }


encodeLoginFlow : LoginFlow -> E.Value
encodeLoginFlow data =
    maybeObject
        [ ( "type", Maybe.map E.string data.contentType )
        ]


loginFlowDecoder : D.Decoder LoginFlow
loginFlowDecoder =
    D.map
        (\a ->
            { contentType = a }
        )
        (opField "type" D.string)


{-| A notifcation, including what event triggered the notification.
-}
type alias Notification =
    { actions : List E.Value
    , event : Event
    , profileTag : Maybe String
    , read : Bool
    , roomId : String
    , ts : Time.Posix
    }


encodeNotification : Notification -> E.Value
encodeNotification data =
    maybeObject
        [ ( "actions", Just <| E.list identity data.actions )
        , ( "event", Just <| encodeEvent data.event )
        , ( "profile_tag", Maybe.map E.string data.profileTag )
        , ( "read", Just <| E.bool data.read )
        , ( "room_id", Just <| E.string data.roomId )
        , ( "ts", Just <| encodeTimestamp data.ts )
        ]


notificationDecoder : D.Decoder Notification
notificationDecoder =
    D.map6
        (\a b c d e f ->
            { actions = a, event = b, profileTag = c, read = d, roomId = e, ts = f }
        )
        (D.field "actions" (D.list D.value))
        (D.field "event" eventDecoder)
        (opField "profile_tag" D.string)
        (D.field "read" D.bool)
        (D.field "room_id" smallKeyDecoder)
        (D.field "ts" timestampDecoder)


{-| Power level requirements for specific notification types.
-}
type alias Notifications =
    { room : Int
    }


encodeNotifications : Notifications -> E.Value
encodeNotifications data =
    maybeObject
        [ ( "room", Just <| E.int data.room )
        ]


notificationsDecoder : D.Decoder Notifications
notificationsDecoder =
    D.map
        (\a ->
            { room = a }
        )
        (opFieldWithDefault "room" 50 D.int)


{-| Session description type that indicates offering a call.
-}
type alias Offer =
    { sdp : String
    , contentType : Enums.SessionDescriptionType
    }


encodeOffer : Offer -> E.Value
encodeOffer data =
    maybeObject
        [ ( "sdp", Just <| E.string data.sdp )
        , ( "type", Just <| Enums.encodeSessionDescriptionType data.contentType )
        ]


offerDecoder : D.Decoder Offer
offerDecoder =
    D.map2
        (\a b ->
            { sdp = a, contentType = b }
        )
        (D.field "sdp" D.string)
        (D.field "type" Enums.sessionDescriptionTypeDecoder)


{-| OpenID token information.
-}
type alias OpenIdCredentials =
    { accessToken : String
    , expiresIn : Int
    , matrixServerName : String
    , tokenType : String
    }


encodeOpenIdCredentials : OpenIdCredentials -> E.Value
encodeOpenIdCredentials data =
    maybeObject
        [ ( "access_token", Just <| E.string data.accessToken )
        , ( "expires_in", Just <| E.int data.expiresIn )
        , ( "matrix_server_name", Just <| E.string data.matrixServerName )
        , ( "token_type", Just <| E.string data.tokenType )
        ]


openIdCredentialsDecoder : D.Decoder OpenIdCredentials
openIdCredentialsDecoder =
    D.map4
        (\a b c d ->
            { accessToken = a, expiresIn = b, matrixServerName = c, tokenType = d }
        )
        (D.field "access_token" D.string)
        (D.field "expires_in" D.int)
        (D.field "matrix_server_name" D.string)
        (D.field "token_type" D.string)


{-| Pagination chunk for a room.
-}
type alias PaginationChunk =
    { chunk : List ClientEvent
    , end : String
    , start : Maybe String
    }


encodePaginationChunk : PaginationChunk -> E.Value
encodePaginationChunk data =
    maybeObject
        [ ( "chunk", Just <| E.list encodeClientEvent data.chunk )
        , ( "end", Just <| E.string data.end )
        , ( "start", Maybe.map E.string data.start )
        ]


paginationChunkDecoder : D.Decoder PaginationChunk
paginationChunkDecoder =
    D.map3
        (\a b c ->
            { chunk = a, end = b, start = c }
        )
        (D.field "chunk" (D.list clientEventDecoder))
        (D.field "end" D.string)
        (opField "start" D.string)


{-| Updates to the presence status of other users.
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


{-| A reference to a room that is being replaced.
-}
type alias PreviousRoom =
    { eventId : String
    , roomId : String
    }


encodePreviousRoom : PreviousRoom -> E.Value
encodePreviousRoom data =
    maybeObject
        [ ( "event_id", Just <| E.string data.eventId )
        , ( "room_id", Just <| E.string data.roomId )
        ]


previousRoomDecoder : D.Decoder PreviousRoom
previousRoomDecoder =
    D.map2
        (\a b ->
            { eventId = a, roomId = b }
        )
        (D.field "event_id" D.string)
        (D.field "room_id" smallKeyDecoder)


{-| Protocol.
-}
type alias Protocol =
    { fieldTypes : Dict String FieldType
    , icon : String
    , instances : List ProtocolInstance
    , locationFields : List String
    , userFields : List String
    }


encodeProtocol : Protocol -> E.Value
encodeProtocol data =
    maybeObject
        [ ( "field_types", Just <| E.dict identity encodeFieldType data.fieldTypes )
        , ( "icon", Just <| E.string data.icon )
        , ( "instances", Just <| E.list encodeProtocolInstance data.instances )
        , ( "location_fields", Just <| E.list E.string data.locationFields )
        , ( "user_fields", Just <| E.list E.string data.userFields )
        ]


protocolDecoder : D.Decoder Protocol
protocolDecoder =
    D.map5
        (\a b c d e ->
            { fieldTypes = a, icon = b, instances = c, locationFields = d, userFields = e }
        )
        (D.field "field_types" (D.dict fieldTypeDecoder))
        (D.field "icon" D.string)
        (D.field "instances" (D.list protocolInstanceDecoder))
        (D.field "location_fields" (D.list D.string))
        (D.field "user_fields" (D.list D.string))


{-| Object representing an independent instance of configuration.
-}
type alias ProtocolInstance =
    { desc : String
    , fields : E.Value
    , icon : Maybe String
    , networkId : String
    }


encodeProtocolInstance : ProtocolInstance -> E.Value
encodeProtocolInstance data =
    maybeObject
        [ ( "desc", Just <| E.string data.desc )
        , ( "fields", Just <| data.fields )
        , ( "icon", Maybe.map E.string data.icon )
        , ( "network_id", Just <| E.string data.networkId )
        ]


protocolInstanceDecoder : D.Decoder ProtocolInstance
protocolInstanceDecoder =
    D.map4
        (\a b c d ->
            { desc = a, fields = b, icon = c, networkId = d }
        )
        (D.field "desc" D.string)
        (D.field "fields" D.value)
        (opField "icon" D.string)
        (D.field "network_id" D.string)


{-| Keys with which a token may be signed.
-}
type alias PublicKeys =
    { keyValidityUrl : Maybe String
    , publicKey : String
    }


encodePublicKeys : PublicKeys -> E.Value
encodePublicKeys data =
    maybeObject
        [ ( "key_validity_url", Maybe.map E.string data.keyValidityUrl )
        , ( "public_key", Just <| E.string data.publicKey )
        ]


publicKeysDecoder : D.Decoder PublicKeys
publicKeysDecoder =
    D.map2
        (\a b ->
            { keyValidityUrl = a, publicKey = b }
        )
        (opField "key_validity_url" D.string)
        (D.field "public_key" D.string)


{-| A chunk containing a public room.
-}
type alias PublicRoomsChunk =
    { avatarUrl : Maybe String
    , canonicalAlias : Maybe String
    , guestCanJoin : Bool
    , joinRule : Enums.JoinRules
    , name : Maybe String
    , numJoinedMembers : Int
    , roomId : String
    , roomType : Maybe String
    , topic : Maybe String
    , worldReadable : Bool
    }


encodePublicRoomsChunk : PublicRoomsChunk -> E.Value
encodePublicRoomsChunk data =
    maybeObject
        [ ( "avatar_url", Maybe.map E.string data.avatarUrl )
        , ( "canonical_alias", Maybe.map E.string data.canonicalAlias )
        , ( "guest_can_join", Just <| E.bool data.guestCanJoin )
        , ( "join_rule", Just <| Enums.encodeJoinRules data.joinRule )
        , ( "name", Maybe.map E.string data.name )
        , ( "num_joined_members", Just <| E.int data.numJoinedMembers )
        , ( "room_id", Just <| E.string data.roomId )
        , ( "room_type", Maybe.map E.string data.roomType )
        , ( "topic", Maybe.map E.string data.topic )
        , ( "world_readable", Just <| E.bool data.worldReadable )
        ]


publicRoomsChunkDecoder : D.Decoder PublicRoomsChunk
publicRoomsChunkDecoder =
    D.map8
        (\a b c d e f ( g, h ) ( i, j ) ->
            { avatarUrl = a, canonicalAlias = b, guestCanJoin = c, joinRule = d, name = e, numJoinedMembers = f, roomId = g, roomType = h, topic = i, worldReadable = j }
        )
        (opField "avatar_url" D.string)
        (opField "canonical_alias" D.string)
        (D.field "guest_can_join" D.bool)
        (opFieldWithDefault "join_rule" Enums.Public Enums.joinRulesDecoder)
        (opField "name" D.string)
        (D.field "num_joined_members" D.int)
        (D.map2 Tuple.pair
            (D.field "room_id" smallKeyDecoder)
            (opField "room_type" D.string)
        )
        (D.map2 Tuple.pair
            (opField "topic" D.string)
            (D.field "world_readable" D.bool)
        )


{-| A condition that must hold true for an event in order for a rule to be applied to an event.
-}
type alias PushCondition =
    { is : Maybe String
    , key : Maybe String
    , kind : String
    , pattern : Maybe String
    }


encodePushCondition : PushCondition -> E.Value
encodePushCondition data =
    maybeObject
        [ ( "is", Maybe.map E.string data.is )
        , ( "key", Maybe.map E.string data.key )
        , ( "kind", Just <| E.string data.kind )
        , ( "pattern", Maybe.map E.string data.pattern )
        ]


pushConditionDecoder : D.Decoder PushCondition
pushConditionDecoder =
    D.map4
        (\a b c d ->
            { is = a, key = b, kind = c, pattern = d }
        )
        (opField "is" D.string)
        (opField "key" D.string)
        (D.field "kind" D.string)
        (opField "pattern" D.string)


{-| Push rule.
-}
type alias PushRule =
    { actions : List E.Value
    , conditions : Maybe (List PushCondition)
    , default : Bool
    , enabled : Bool
    , pattern : Maybe String
    , ruleId : String
    }


encodePushRule : PushRule -> E.Value
encodePushRule data =
    maybeObject
        [ ( "actions", Just <| E.list identity data.actions )
        , ( "conditions", Maybe.map (E.list encodePushCondition) data.conditions )
        , ( "default", Just <| E.bool data.default )
        , ( "enabled", Just <| E.bool data.enabled )
        , ( "pattern", Maybe.map E.string data.pattern )
        , ( "rule_id", Just <| E.string data.ruleId )
        ]


pushRuleDecoder : D.Decoder PushRule
pushRuleDecoder =
    D.map6
        (\a b c d e f ->
            { actions = a, conditions = b, default = c, enabled = d, pattern = e, ruleId = f }
        )
        (D.field "actions" (D.list D.value))
        (opField "conditions" (D.list pushConditionDecoder))
        (D.field "default" D.bool)
        (D.field "enabled" D.bool)
        (opField "pattern" D.string)
        (D.field "rule_id" D.string)


{-| A pusher for the user.
-}
type alias Pusher =
    { appDisplayName : String
    , appId : String
    , data : PusherData
    , deviceDisplayName : String
    , kind : String
    , lang : String
    , profileTag : Maybe String
    , pushkey : String
    }


encodePusher : Pusher -> E.Value
encodePusher data =
    maybeObject
        [ ( "app_display_name", Just <| E.string data.appDisplayName )
        , ( "app_id", Just <| E.string data.appId )
        , ( "data", Just <| encodePusherData data.data )
        , ( "device_display_name", Just <| E.string data.deviceDisplayName )
        , ( "kind", Just <| E.string data.kind )
        , ( "lang", Just <| E.string data.lang )
        , ( "profile_tag", Maybe.map E.string data.profileTag )
        , ( "pushkey", Just <| E.string data.pushkey )
        ]


pusherDecoder : D.Decoder Pusher
pusherDecoder =
    D.map8
        (\a b c d e f g h ->
            { appDisplayName = a, appId = b, data = c, deviceDisplayName = d, kind = e, lang = f, profileTag = g, pushkey = h }
        )
        (D.field "app_display_name" D.string)
        (D.field "app_id" D.string)
        (D.field "data" pusherDataDecoder)
        (D.field "device_display_name" D.string)
        (D.field "kind" D.string)
        (D.field "lang" D.string)
        (opField "profile_tag" D.string)
        (D.field "pushkey" D.string)


{-| Information about the pusher implementation itself.
-}
type alias PusherData =
    { format : Maybe String
    , url : Maybe String
    }


encodePusherData : PusherData -> E.Value
encodePusherData data =
    maybeObject
        [ ( "format", Maybe.map E.string data.format )
        , ( "url", Maybe.map E.string data.url )
        ]


pusherDataDecoder : D.Decoder PusherData
pusherDataDecoder =
    D.map2
        (\a b ->
            { format = a, url = b }
        )
        (opField "format" D.string)
        (opField "url" D.string)


{-| errcode
-}
type alias RateLimitError =
    { errcode : String
    , error : Maybe String
    , retryAfterMs : Maybe Int
    }


encodeRateLimitError : RateLimitError -> E.Value
encodeRateLimitError data =
    maybeObject
        [ ( "errcode", Just <| E.string data.errcode )
        , ( "error", Maybe.map E.string data.error )
        , ( "retry_after_ms", Maybe.map E.int data.retryAfterMs )
        ]


rateLimitErrorDecoder : D.Decoder RateLimitError
rateLimitErrorDecoder =
    D.map3
        (\a b c ->
            { errcode = a, error = b, retryAfterMs = c }
        )
        (D.field "errcode" D.string)
        (opField "error" D.string)
        (opField "retry_after_ms" D.int)


{-| An event relating to another event.
-}
type alias RelatesTo =
    { eventId : String
    , relType : String
    }


encodeRelatesTo : RelatesTo -> E.Value
encodeRelatesTo data =
    maybeObject
        [ ( "event_id", Just <| E.string data.eventId )
        , ( "rel_type", Just <| E.string data.relType )
        ]


relatesToDecoder : D.Decoder RelatesTo
relatesToDecoder =
    D.map2
        (\a b ->
            { eventId = a, relType = b }
        )
        (D.field "event_id" D.string)
        (D.field "rel_type" D.string)


{-| Response to a user's request for a token.
-}
type alias RequestTokenResponse =
    { sid : String
    , submitUrl : Maybe String
    }


encodeRequestTokenResponse : RequestTokenResponse -> E.Value
encodeRequestTokenResponse data =
    maybeObject
        [ ( "sid", Just <| E.string data.sid )
        , ( "submit_url", Maybe.map E.string data.submitUrl )
        ]


requestTokenResponseDecoder : D.Decoder RequestTokenResponse
requestTokenResponseDecoder =
    D.map2
        (\a b ->
            { sid = a, submitUrl = b }
        )
        (D.field "sid" D.string)
        (opField "submit_url" D.string)


{-| Information about a requested key.
-}
type alias RequestedKeyInfo =
    { algorihm : String
    , roomId : String
    , sessionId : String
    }


encodeRequestedKeyInfo : RequestedKeyInfo -> E.Value
encodeRequestedKeyInfo data =
    maybeObject
        [ ( "algorihm", Just <| E.string data.algorihm )
        , ( "room_id", Just <| E.string data.roomId )
        , ( "session_id", Just <| E.string data.sessionId )
        ]


requestedKeyInfoDecoder : D.Decoder RequestedKeyInfo
requestedKeyInfoDecoder =
    D.map3
        (\a b c ->
            { algorihm = a, roomId = b, sessionId = c }
        )
        (D.field "algorihm" D.string)
        (D.field "room_id" smallKeyDecoder)
        (D.field "session_id" D.string)


{-| Result of a search
-}
type alias Result =
    { context : Maybe EventContext
    , rank : Maybe Int
    , result : Maybe Event
    }


encodeResult : Result -> E.Value
encodeResult data =
    maybeObject
        [ ( "context", Maybe.map encodeEventContext data.context )
        , ( "rank", Maybe.map E.int data.rank )
        , ( "result", Maybe.map encodeEvent data.result )
        ]


resultDecoder : D.Decoder Result
resultDecoder =
    D.map3
        (\a b c ->
            { context = a, rank = b, result = c }
        )
        (opField "context" eventContextDecoder)
        (opField "rank" D.int)
        (opField "result" eventDecoder)


{-| Which categories to search in and their criteria.
-}
type alias ResultCategories =
    { roomEvents : Maybe ResultRoomEvents
    }


encodeResultCategories : ResultCategories -> E.Value
encodeResultCategories data =
    maybeObject
        [ ( "room_events", Maybe.map encodeResultRoomEvents data.roomEvents )
        ]


resultCategoriesDecoder : D.Decoder ResultCategories
resultCategoriesDecoder =
    D.map
        (\a ->
            { roomEvents = a }
        )
        (opField "room_events" resultRoomEventsDecoder)


{-| Mapping of category name to search criteria.
-}
type alias ResultRoomEvents =
    { count : Maybe Int
    , groups : Dict String Enums.GroupKey
    , highlights : List String
    , nextBatch : Maybe String
    , results : List Result
    , state : Maybe (Dict String (List ClientEvent))
    }


encodeResultRoomEvents : ResultRoomEvents -> E.Value
encodeResultRoomEvents data =
    maybeObject
        [ ( "count", Maybe.map E.int data.count )
        , ( "groups", Just <| E.dict identity Enums.encodeGroupKey data.groups )
        , ( "highlights", Just <| E.list E.string data.highlights )
        , ( "next_batch", Maybe.map E.string data.nextBatch )
        , ( "results", Just <| E.list encodeResult data.results )
        , ( "state", Maybe.map (E.dict identity (E.list encodeClientEvent)) data.state )
        ]


resultRoomEventsDecoder : D.Decoder ResultRoomEvents
resultRoomEventsDecoder =
    D.map6
        (\a b c d e f ->
            { count = a, groups = b, highlights = c, nextBatch = d, results = e, state = f }
        )
        (opField "count" D.int)
        (opFieldWithDefault "groups" Dict.empty (D.dict Enums.groupKeyDecoder))
        (opFieldWithDefault "highlights" [] (D.list D.string))
        (opField "next_batch" D.string)
        (opFieldWithDefault "results" [] (D.list resultDecoder))
        (opField "state" (D.dict (D.list clientEventDecoder)))


{-| Results of a search.
-}
type alias Results =
    { searchCategories : ResultCategories
    }


encodeResults : Results -> E.Value
encodeResults data =
    maybeObject
        [ ( "search_categories", Just <| encodeResultCategories data.searchCategories )
        ]


resultsDecoder : D.Decoder Results
resultsDecoder =
    D.map
        (\a ->
            { searchCategories = a }
        )
        (D.field "search_categories" resultCategoriesDecoder)


{-| A filter that indicates which message and state events should be included for a room.
-}
type alias RoomEventFilter =
    { containsUrl : Maybe Bool
    , includeRedundantMembers : Bool
    , lazyLoadMembers : Bool
    , limit : Maybe Int
    , notRooms : List String
    , notSenders : List String
    , notTypes : List String
    , rooms : Maybe (List String)
    , senders : Maybe (List String)
    , types : Maybe (List String)
    , unreadThreadNotifications : Bool
    }


encodeRoomEventFilter : RoomEventFilter -> E.Value
encodeRoomEventFilter data =
    maybeObject
        [ ( "contains_url", Maybe.map E.bool data.containsUrl )
        , ( "include_redundant_members", Just <| E.bool data.includeRedundantMembers )
        , ( "lazy_load_members", Just <| E.bool data.lazyLoadMembers )
        , ( "limit", Maybe.map E.int data.limit )
        , ( "not_rooms", Just <| E.list E.string data.notRooms )
        , ( "not_senders", Just <| E.list E.string data.notSenders )
        , ( "not_types", Just <| E.list E.string data.notTypes )
        , ( "rooms", Maybe.map (E.list E.string) data.rooms )
        , ( "senders", Maybe.map (E.list E.string) data.senders )
        , ( "types", Maybe.map (E.list E.string) data.types )
        , ( "unread_thread_notifications", Just <| E.bool data.unreadThreadNotifications )
        ]


roomEventFilterDecoder : D.Decoder RoomEventFilter
roomEventFilterDecoder =
    D.map8
        (\a b c d e ( f, g ) ( h, i ) ( j, k ) ->
            { containsUrl = a, includeRedundantMembers = b, lazyLoadMembers = c, limit = d, notRooms = e, notSenders = f, notTypes = g, rooms = h, senders = i, types = j, unreadThreadNotifications = k }
        )
        (opField "contains_url" D.bool)
        (opFieldWithDefault "include_redundant_members" False D.bool)
        (opFieldWithDefault "lazy_load_members" False D.bool)
        (opField "limit" D.int)
        (opFieldWithDefault "not_rooms" [] (D.list D.string))
        (D.map2 Tuple.pair
            (opFieldWithDefault "not_senders" [] (D.list smallKeyDecoder))
            (opFieldWithDefault "not_types" [] (D.list D.string))
        )
        (D.map2 Tuple.pair
            (opField "rooms" (D.list D.string))
            (opField "senders" (D.list smallKeyDecoder))
        )
        (D.map2 Tuple.pair
            (opField "types" (D.list D.string))
            (opFieldWithDefault "unread_thread_notifications" False D.bool)
        )


{-| Mapping of category name to search criteria.
-}
type alias RoomEventsCriteria =
    { eventContext : Maybe IncludeEventContext
    , filter : Maybe Filter
    , groupings : Maybe Groupings
    , includeState : Maybe Bool
    , keys : Maybe (List String)
    , orderBy : Enums.SearchOrdering
    , searchTerm : String
    }


encodeRoomEventsCriteria : RoomEventsCriteria -> E.Value
encodeRoomEventsCriteria data =
    maybeObject
        [ ( "event_context", Maybe.map encodeIncludeEventContext data.eventContext )
        , ( "filter", Maybe.map encodeFilter data.filter )
        , ( "groupings", Maybe.map encodeGroupings data.groupings )
        , ( "include_state", Maybe.map E.bool data.includeState )
        , ( "keys", Maybe.map (E.list E.string) data.keys )
        , ( "order_by", Just <| Enums.encodeSearchOrdering data.orderBy )
        , ( "search_term", Just <| E.string data.searchTerm )
        ]


roomEventsCriteriaDecoder : D.Decoder RoomEventsCriteria
roomEventsCriteriaDecoder =
    D.map7
        (\a b c d e f g ->
            { eventContext = a, filter = b, groupings = c, includeState = d, keys = e, orderBy = f, searchTerm = g }
        )
        (opField "event_context" includeEventContextDecoder)
        (opField "filter" filterDecoder)
        (opField "groupings" groupingsDecoder)
        (opField "include_state" D.bool)
        (opField "keys" (D.list D.string))
        (opFieldWithDefault "order_by" Enums.Rank Enums.searchOrderingDecoder)
        (D.field "search_term" D.string)


{-| Filters to be applied to room data.
-}
type alias RoomFilter =
    { accountData : Maybe RoomEventFilter
    , ephemeral : Maybe RoomEventFilter
    , includeLeave : Bool
    , notRooms : List String
    , rooms : Maybe (List String)
    , state : Maybe StateFilter
    , timeline : Maybe RoomEventFilter
    }


encodeRoomFilter : RoomFilter -> E.Value
encodeRoomFilter data =
    maybeObject
        [ ( "account_data", Maybe.map encodeRoomEventFilter data.accountData )
        , ( "ephemeral", Maybe.map encodeRoomEventFilter data.ephemeral )
        , ( "include_leave", Just <| E.bool data.includeLeave )
        , ( "not_rooms", Just <| E.list E.string data.notRooms )
        , ( "rooms", Maybe.map (E.list E.string) data.rooms )
        , ( "state", Maybe.map encodeStateFilter data.state )
        , ( "timeline", Maybe.map encodeRoomEventFilter data.timeline )
        ]


roomFilterDecoder : D.Decoder RoomFilter
roomFilterDecoder =
    D.map7
        (\a b c d e f g ->
            { accountData = a, ephemeral = b, includeLeave = c, notRooms = d, rooms = e, state = f, timeline = g }
        )
        (opField "account_data" roomEventFilterDecoder)
        (opField "ephemeral" roomEventFilterDecoder)
        (opFieldWithDefault "include_leave" False D.bool)
        (opFieldWithDefault "not_rooms" [] (D.list D.string))
        (opField "rooms" (D.list D.string))
        (opField "state" stateFilterDecoder)
        (opField "timeline" roomEventFilterDecoder)


{-| Information about a room.
-}
type alias RoomInfo =
    { accountData : List ClientEvent
    , invite : Maybe InviteEvent
    , membership : Enums.MembershipState
    , messages : Maybe PaginationChunk
    , roomId : String
    , state : Maybe (List ClientEvent)
    , visibility : Maybe Enums.RoomVisibility
    }


encodeRoomInfo : RoomInfo -> E.Value
encodeRoomInfo data =
    maybeObject
        [ ( "account_data", Just <| E.list encodeClientEvent data.accountData )
        , ( "invite", Maybe.map encodeInviteEvent data.invite )
        , ( "membership", Just <| Enums.encodeMembershipState data.membership )
        , ( "messages", Maybe.map encodePaginationChunk data.messages )
        , ( "room_id", Just <| E.string data.roomId )
        , ( "state", Maybe.map (E.list encodeClientEvent) data.state )
        , ( "visibility", Maybe.map Enums.encodeRoomVisibility data.visibility )
        ]


roomInfoDecoder : D.Decoder RoomInfo
roomInfoDecoder =
    D.map7
        (\a b c d e f g ->
            { accountData = a, invite = b, membership = c, messages = d, roomId = e, state = f, visibility = g }
        )
        (opFieldWithDefault "account_data" [] (D.list clientEventDecoder))
        (opField "invite" inviteEventDecoder)
        (D.field "membership" Enums.membershipStateDecoder)
        (opField "messages" paginationChunkDecoder)
        (D.field "room_id" smallKeyDecoder)
        (opField "state" (D.list clientEventDecoder))
        (opField "visibility" Enums.roomVisibilityDecoder)


{-| Backup of a given key from a given room.
-}
type alias RoomKeyBackup =
    { sessions : Dict String E.Value
    }


encodeRoomKeyBackup : RoomKeyBackup -> E.Value
encodeRoomKeyBackup data =
    maybeObject
        [ ( "sessions", Just <| E.dict identity identity data.sessions )
        ]


roomKeyBackupDecoder : D.Decoder RoomKeyBackup
roomKeyBackupDecoder =
    D.map
        (\a ->
            { sessions = a }
        )
        (D.field "sessions" (D.dict D.value))


{-| Information on a successful key update.
-}
type alias RoomKeysUpdateResponse =
    { count : Int
    , etag : String
    }


encodeRoomKeysUpdateResponse : RoomKeysUpdateResponse -> E.Value
encodeRoomKeysUpdateResponse data =
    maybeObject
        [ ( "count", Just <| E.int data.count )
        , ( "etag", Just <| E.string data.etag )
        ]


roomKeysUpdateResponseDecoder : D.Decoder RoomKeysUpdateResponse
roomKeysUpdateResponseDecoder =
    D.map2
        (\a b ->
            { count = a, etag = b }
        )
        (D.field "count" D.int)
        (D.field "etag" D.string)


{-| A member of a Matrix room.
-}
type alias RoomMember =
    { avatarUrl : Maybe String
    , displayName : Maybe String
    }


encodeRoomMember : RoomMember -> E.Value
encodeRoomMember data =
    maybeObject
        [ ( "avatar_url", Maybe.map E.string data.avatarUrl )
        , ( "display_name", Maybe.map E.string data.displayName )
        ]


roomMemberDecoder : D.Decoder RoomMember
roomMemberDecoder =
    D.map2
        (\a b ->
            { avatarUrl = a, displayName = b }
        )
        (opField "avatar_url" D.string)
        (opField "display_name" D.string)


{-| Summary of the room.
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


{-| A description of which room versions are available and/or (un)stable.
-}
type alias RoomVersionsCapability =
    { available : Dict String Enums.RoomVersionStability
    , default : String
    }


encodeRoomVersionsCapability : RoomVersionsCapability -> E.Value
encodeRoomVersionsCapability data =
    maybeObject
        [ ( "available", Just <| E.dict identity Enums.encodeRoomVersionStability data.available )
        , ( "default", Just <| E.string data.default )
        ]


roomVersionsCapabilityDecoder : D.Decoder RoomVersionsCapability
roomVersionsCapabilityDecoder =
    D.map2
        (\a b ->
            { available = a, default = b }
        )
        (D.field "available" (D.dict Enums.roomVersionStabilityDecoder))
        (D.field "default" D.string)


{-| A summary of rooms that the user is in.
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


{-| A set of rules.
-}
type alias Ruleset =
    { content : List PushRule
    , override : List PushRule
    , room : List PushRule
    , sender : List PushRule
    , underride : List PushRule
    }


encodeRuleset : Ruleset -> E.Value
encodeRuleset data =
    maybeObject
        [ ( "content", Just <| E.list encodePushRule data.content )
        , ( "override", Just <| E.list encodePushRule data.override )
        , ( "room", Just <| E.list encodePushRule data.room )
        , ( "sender", Just <| E.list encodePushRule data.sender )
        , ( "underride", Just <| E.list encodePushRule data.underride )
        ]


rulesetDecoder : D.Decoder Ruleset
rulesetDecoder =
    D.map5
        (\a b c d e ->
            { content = a, override = b, room = c, sender = d, underride = e }
        )
        (opFieldWithDefault "content" [] (D.list pushRuleDecoder))
        (opFieldWithDefault "override" [] (D.list pushRuleDecoder))
        (opFieldWithDefault "room" [] (D.list pushRuleDecoder))
        (opFieldWithDefault "sender" [] (D.list pushRuleDecoder))
        (opFieldWithDefault "underride" [] (D.list pushRuleDecoder))


{-| Format of a backed-up session key, prior to encryption.
-}
type alias SessionData =
    { algorithm : String
    , forwardingCurve25519KeyChain : List String
    , senderClaimedKeys : Dict String String
    , senderKey : String
    , sessionKey : String
    }


encodeSessionData : SessionData -> E.Value
encodeSessionData data =
    maybeObject
        [ ( "algorithm", Just <| E.string data.algorithm )
        , ( "forwarding_curve25519_key_chain", Just <| E.list E.string data.forwardingCurve25519KeyChain )
        , ( "sender_claimed_keys", Just <| E.dict identity E.string data.senderClaimedKeys )
        , ( "sender_key", Just <| E.string data.senderKey )
        , ( "session_key", Just <| E.string data.sessionKey )
        ]


sessionDataDecoder : D.Decoder SessionData
sessionDataDecoder =
    D.map5
        (\a b c d e ->
            { algorithm = a, forwardingCurve25519KeyChain = b, senderClaimedKeys = c, senderKey = d, sessionKey = e }
        )
        (D.field "algorithm" D.string)
        (D.field "forwarding_curve25519_key_chain" (D.list D.string))
        (D.field "sender_claimed_keys" (D.dict D.string))
        (D.field "sender_key" D.string)
        (D.field "session_key" D.string)


{-| connections
-}
type alias SessionInfo =
    { connections : List ConnectionInfo
    }


encodeSessionInfo : SessionInfo -> E.Value
encodeSessionInfo data =
    maybeObject
        [ ( "connections", Just <| E.list encodeConnectionInfo data.connections )
        ]


sessionInfoDecoder : D.Decoder SessionInfo
sessionInfoDecoder =
    D.map
        (\a ->
            { connections = a }
        )
        (opFieldWithDefault "connections" [] (D.list connectionInfoDecoder))


{-| Updates to the state of a room.
-}
type alias State =
    { events : List ClientEventWithoutRoomId
    }


encodeState : State -> E.Value
encodeState data =
    maybeObject
        [ ( "events", Just <| E.list encodeClientEventWithoutRoomId data.events )
        ]


stateDecoder : D.Decoder State
stateDecoder =
    D.map
        (\a ->
            { events = a }
        )
        (opFieldWithDefault "events" [] (D.list clientEventWithoutRoomIdDecoder))


{-| State event.
-}
type alias StateEvent =
    { content : EventContent
    , stateKey : String
    , contentType : String
    }


encodeStateEvent : StateEvent -> E.Value
encodeStateEvent data =
    maybeObject
        [ ( "content", Just <| encodeEventContent data.content )
        , ( "state_key", Just <| E.string data.stateKey )
        , ( "type", Just <| E.string data.contentType )
        ]


stateEventDecoder : D.Decoder StateEvent
stateEventDecoder =
    D.map3
        (\a b c ->
            { content = a, stateKey = b, contentType = c }
        )
        (D.field "content" eventContentDecoder)
        (opFieldWithDefault "state_key" "" smallKeyDecoder)
        (D.field "type" smallKeyDecoder)


{-| A filter indicating what state events to filter for a room.
-}
type alias StateFilter =
    { containsUrl : Maybe Bool
    , includeRedundantMembers : Bool
    , lazyLoadMembers : Bool
    , limit : Maybe Int
    , notRooms : List String
    , notSenders : List String
    , notTypes : List String
    , rooms : Maybe (List String)
    , senders : Maybe (List String)
    , types : Maybe (List String)
    , unreadThreadNotifications : Bool
    }


encodeStateFilter : StateFilter -> E.Value
encodeStateFilter data =
    maybeObject
        [ ( "contains_url", Maybe.map E.bool data.containsUrl )
        , ( "include_redundant_members", Just <| E.bool data.includeRedundantMembers )
        , ( "lazy_load_members", Just <| E.bool data.lazyLoadMembers )
        , ( "limit", Maybe.map E.int data.limit )
        , ( "not_rooms", Just <| E.list E.string data.notRooms )
        , ( "not_senders", Just <| E.list E.string data.notSenders )
        , ( "not_types", Just <| E.list E.string data.notTypes )
        , ( "rooms", Maybe.map (E.list E.string) data.rooms )
        , ( "senders", Maybe.map (E.list E.string) data.senders )
        , ( "types", Maybe.map (E.list E.string) data.types )
        , ( "unread_thread_notifications", Just <| E.bool data.unreadThreadNotifications )
        ]


stateFilterDecoder : D.Decoder StateFilter
stateFilterDecoder =
    D.map8
        (\a b c d e ( f, g ) ( h, i ) ( j, k ) ->
            { containsUrl = a, includeRedundantMembers = b, lazyLoadMembers = c, limit = d, notRooms = e, notSenders = f, notTypes = g, rooms = h, senders = i, types = j, unreadThreadNotifications = k }
        )
        (opField "contains_url" D.bool)
        (opFieldWithDefault "include_redundant_members" False D.bool)
        (opFieldWithDefault "lazy_load_members" False D.bool)
        (opField "limit" D.int)
        (opFieldWithDefault "not_rooms" [] (D.list D.string))
        (D.map2 Tuple.pair
            (opFieldWithDefault "not_senders" [] (D.list smallKeyDecoder))
            (opFieldWithDefault "not_types" [] (D.list D.string))
        )
        (D.map2 Tuple.pair
            (opField "rooms" (D.list D.string))
            (opField "senders" (D.list smallKeyDecoder))
        )
        (D.map2 Tuple.pair
            (opField "types" (D.list D.string))
            (opFieldWithDefault "unread_thread_notifications" False D.bool)
        )


{-| Stripped version of a state event.
-}
type alias StrippedChildStateEvent =
    { content : EventContent
    , originServerTs : Time.Posix
    , sender : String
    , stateKey : String
    , contentType : String
    }


encodeStrippedChildStateEvent : StrippedChildStateEvent -> E.Value
encodeStrippedChildStateEvent data =
    maybeObject
        [ ( "content", Just <| encodeEventContent data.content )
        , ( "origin_server_ts", Just <| encodeTimestamp data.originServerTs )
        , ( "sender", Just <| E.string data.sender )
        , ( "state_key", Just <| E.string data.stateKey )
        , ( "type", Just <| E.string data.contentType )
        ]


strippedChildStateEventDecoder : D.Decoder StrippedChildStateEvent
strippedChildStateEventDecoder =
    D.map5
        (\a b c d e ->
            { content = a, originServerTs = b, sender = c, stateKey = d, contentType = e }
        )
        (D.field "content" eventContentDecoder)
        (D.field "origin_server_ts" timestampDecoder)
        (D.field "sender" smallKeyDecoder)
        (D.field "state_key" smallKeyDecoder)
        (D.field "type" smallKeyDecoder)


{-| content
-}
type alias StrippedStateEvent =
    { content : EventContent
    , sender : String
    , stateKey : String
    , contentType : String
    }


encodeStrippedStateEvent : StrippedStateEvent -> E.Value
encodeStrippedStateEvent data =
    maybeObject
        [ ( "content", Just <| encodeEventContent data.content )
        , ( "sender", Just <| E.string data.sender )
        , ( "state_key", Just <| E.string data.stateKey )
        , ( "type", Just <| E.string data.contentType )
        ]


strippedStateEventDecoder : D.Decoder StrippedStateEvent
strippedStateEventDecoder =
    D.map4
        (\a b c d ->
            { content = a, sender = b, stateKey = c, contentType = d }
        )
        (D.field "content" eventContentDecoder)
        (D.field "sender" smallKeyDecoder)
        (D.field "state_key" smallKeyDecoder)
        (D.field "type" smallKeyDecoder)


{-| Tag on a room and its content.
-}
type alias Tag =
    { order : Maybe Float
    }


encodeTag : Tag -> E.Value
encodeTag data =
    maybeObject
        [ ( "order", Maybe.map E.float data.order )
        ]


tagDecoder : D.Decoder Tag
tagDecoder =
    D.map
        (\a ->
            { order = a }
        )
        (opField "order" D.float)


{-| Third party identifier.
-}
type alias ThirdPartyIdentifier =
    { addedAt : Time.Posix
    , address : String
    , medium : Enums.ThirdPartyMedium
    , validatedAt : Time.Posix
    }


encodeThirdPartyIdentifier : ThirdPartyIdentifier -> E.Value
encodeThirdPartyIdentifier data =
    maybeObject
        [ ( "added_at", Just <| encodeTimestamp data.addedAt )
        , ( "address", Just <| E.string data.address )
        , ( "medium", Just <| Enums.encodeThirdPartyMedium data.medium )
        , ( "validated_at", Just <| encodeTimestamp data.validatedAt )
        ]


thirdPartyIdentifierDecoder : D.Decoder ThirdPartyIdentifier
thirdPartyIdentifierDecoder =
    D.map4
        (\a b c d ->
            { addedAt = a, address = b, medium = c, validatedAt = d }
        )
        (D.field "added_at" timestampDecoder)
        (D.field "address" D.string)
        (D.field "medium" Enums.thirdPartyMediumDecoder)
        (D.field "validated_at" timestampDecoder)


{-| Third party signed.
-}
type alias ThirdPartySigned =
    { mxid : String
    , sender : String
    , signatures : Dict String String
    , token : String
    }


encodeThirdPartySigned : ThirdPartySigned -> E.Value
encodeThirdPartySigned data =
    maybeObject
        [ ( "mxid", Just <| E.string data.mxid )
        , ( "sender", Just <| E.string data.sender )
        , ( "signatures", Just <| E.dict identity E.string data.signatures )
        , ( "token", Just <| E.string data.token )
        ]


thirdPartySignedDecoder : D.Decoder ThirdPartySigned
thirdPartySignedDecoder =
    D.map4
        (\a b c d ->
            { mxid = a, sender = b, signatures = c, token = d }
        )
        (D.field "mxid" smallKeyDecoder)
        (D.field "sender" smallKeyDecoder)
        (D.field "signatures" (D.dict D.string))
        (D.field "token" D.string)


{-| Unread notification counts for a given thread.
-}
type alias ThreadNotificationCounts =
    { highlightCount : Maybe Int
    , notificationCount : Maybe Int
    }


encodeThreadNotificationCounts : ThreadNotificationCounts -> E.Value
encodeThreadNotificationCounts data =
    maybeObject
        [ ( "highlight_count", Maybe.map E.int data.highlightCount )
        , ( "notification_count", Maybe.map E.int data.notificationCount )
        ]


threadNotificationCountsDecoder : D.Decoder ThreadNotificationCounts
threadNotificationCountsDecoder =
    D.map2
        (\a b ->
            { highlightCount = a, notificationCount = b }
        )
        (opField "highlight_count" D.int)
        (opField "notification_count" D.int)


{-| Three PID Credentials.
-}
type alias ThreePidCredentials =
    { clientSecret : String
    , idAccessToken : String
    , idServer : String
    , sid : String
    }


encodeThreePidCredentials : ThreePidCredentials -> E.Value
encodeThreePidCredentials data =
    maybeObject
        [ ( "client_secret", Just <| E.string data.clientSecret )
        , ( "id_access_token", Just <| E.string data.idAccessToken )
        , ( "id_server", Just <| E.string data.idServer )
        , ( "sid", Just <| E.string data.sid )
        ]


threePidCredentialsDecoder : D.Decoder ThreePidCredentials
threePidCredentialsDecoder =
    D.map4
        (\a b c d ->
            { clientSecret = a, idAccessToken = b, idServer = c, sid = d }
        )
        (D.field "client_secret" D.string)
        (D.field "id_access_token" D.string)
        (D.field "id_server" D.string)
        (D.field "sid" D.string)


{-| Information about the thumbnail of an image.
-}
type alias ThumbnailInfo =
    { h : Maybe Int
    , mimetype : Maybe String
    , size : Maybe Int
    , w : Maybe Int
    }


encodeThumbnailInfo : ThumbnailInfo -> E.Value
encodeThumbnailInfo data =
    maybeObject
        [ ( "h", Maybe.map E.int data.h )
        , ( "mimetype", Maybe.map E.string data.mimetype )
        , ( "size", Maybe.map E.int data.size )
        , ( "w", Maybe.map E.int data.w )
        ]


thumbnailInfoDecoder : D.Decoder ThumbnailInfo
thumbnailInfoDecoder =
    D.map4
        (\a b c d ->
            { h = a, mimetype = b, size = c, w = d }
        )
        (opField "h" D.int)
        (opField "mimetype" D.string)
        (opField "size" D.int)
        (opField "w" D.int)


{-| A timeline of events.
-}
type alias Timeline =
    { events : List ClientEventWithoutRoomId
    , limited : Maybe Bool
    , prevBatch : Maybe String
    }


encodeTimeline : Timeline -> E.Value
encodeTimeline data =
    maybeObject
        [ ( "events", Just <| E.list encodeClientEventWithoutRoomId data.events )
        , ( "limited", Maybe.map E.bool data.limited )
        , ( "prev_batch", Maybe.map E.string data.prevBatch )
        ]


timelineDecoder : D.Decoder Timeline
timelineDecoder =
    D.map3
        (\a b c ->
            { events = a, limited = b, prevBatch = c }
        )
        (D.field "events" (D.list clientEventWithoutRoomIdDecoder))
        (opField "limited" D.bool)
        (opField "prev_batch" D.string)


{-| Unread notification counts.
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


{-| Optional extra information about an event.
-}
type UnsignedData
    = UnsignedData
        { age : Maybe Int
        , prevContent : Maybe EventContent
        , redactedBecause : Maybe ClientEvent
        , transactionId : Maybe String
        }


encodeUnsignedData : UnsignedData -> E.Value
encodeUnsignedData info =
    case info of
        UnsignedData data ->
            maybeObject
                [ ( "age", Maybe.map E.int data.age )
                , ( "prev_content", Maybe.map encodeEventContent data.prevContent )
                , ( "redacted_because", Maybe.map encodeClientEvent data.redactedBecause )
                , ( "transaction_id", Maybe.map E.string data.transactionId )
                ]


unsignedDataDecoder : String -> D.Decoder UnsignedData
unsignedDataDecoder eventType =
    D.map4
        (\a b c d ->
            UnsignedData { age = a, prevContent = b, redactedBecause = c, transactionId = d }
        )
        (opField "age" D.int)
        (opField "prev_content" eventContentDecoder)
        (opField "redacted_because" clientEventDecoder)
        (opField "transaction_id" D.string)


{-| Displayed user.
-}
type alias User =
    { avatarUrl : Maybe String
    , displayName : Maybe String
    , userId : String
    }


encodeUser : User -> E.Value
encodeUser data =
    maybeObject
        [ ( "avatar_url", Maybe.map E.string data.avatarUrl )
        , ( "display_name", Maybe.map E.string data.displayName )
        , ( "user_id", Just <| E.string data.userId )
        ]


userDecoder : D.Decoder User
userDecoder =
    D.map3
        (\a b c ->
            { avatarUrl = a, displayName = b, userId = c }
        )
        (opField "avatar_url" D.string)
        (opField "display_name" D.string)
        (D.field "user_id" D.string)


{-| User identifier.
-}
type alias UserIdentifier =
    { contentType : String
    }


encodeUserIdentifier : UserIdentifier -> E.Value
encodeUserIdentifier data =
    maybeObject
        [ ( "type", Just <| E.string data.contentType )
        ]


userIdentifierDecoder : D.Decoder UserIdentifier
userIdentifierDecoder =
    D.map
        (\a ->
            { contentType = a }
        )
        (D.field "type" D.string)


{-| User profile.
-}
type alias UserProfile =
    { avatarUrl : Maybe String
    , displayname : Maybe String
    }


encodeUserProfile : UserProfile -> E.Value
encodeUserProfile data =
    maybeObject
        [ ( "avatar_url", Maybe.map E.string data.avatarUrl )
        , ( "displayname", Maybe.map E.string data.displayname )
        ]


userProfileDecoder : D.Decoder UserProfile
userProfileDecoder =
    D.map2
        (\a b ->
            { avatarUrl = a, displayname = b }
        )
        (opField "avatar_url" D.string)
        (opField "displayname" D.string)


{-| Event that verification relates to.
-}
type alias VerificationRelatesTo =
    { eventId : Maybe String
    , relType : Maybe String
    }


encodeVerificationRelatesTo : VerificationRelatesTo -> E.Value
encodeVerificationRelatesTo data =
    maybeObject
        [ ( "event_id", Maybe.map E.string data.eventId )
        , ( "rel_type", Maybe.map E.string data.relType )
        ]


verificationRelatesToDecoder : D.Decoder VerificationRelatesTo
verificationRelatesToDecoder =
    D.map2
        (\a b ->
            { eventId = a, relType = b }
        )
        (opField "event_id" D.string)
        (opField "rel_type" D.string)


{-| Information about a video.
-}
type alias VideoInfo =
    { duration : Maybe Int
    , h : Maybe Int
    , mimetype : Maybe String
    , size : Maybe Int
    , thumbnailFile : Maybe EncryptedFile
    , thumbnailInfo : Maybe ThumbnailInfo
    , thumbnailUrl : Maybe String
    , w : Maybe Int
    }


encodeVideoInfo : VideoInfo -> E.Value
encodeVideoInfo data =
    maybeObject
        [ ( "duration", Maybe.map E.int data.duration )
        , ( "h", Maybe.map E.int data.h )
        , ( "mimetype", Maybe.map E.string data.mimetype )
        , ( "size", Maybe.map E.int data.size )
        , ( "thumbnail_file", Maybe.map encodeEncryptedFile data.thumbnailFile )
        , ( "thumbnail_info", Maybe.map encodeThumbnailInfo data.thumbnailInfo )
        , ( "thumbnail_url", Maybe.map E.string data.thumbnailUrl )
        , ( "w", Maybe.map E.int data.w )
        ]


videoInfoDecoder : D.Decoder VideoInfo
videoInfoDecoder =
    D.map8
        (\a b c d e f g h ->
            { duration = a, h = b, mimetype = c, size = d, thumbnailFile = e, thumbnailInfo = f, thumbnailUrl = g, w = h }
        )
        (opField "duration" D.int)
        (opField "h" D.int)
        (opField "mimetype" D.string)
        (opField "size" D.int)
        (opField "thumbnail_file" encryptedFileDecoder)
        (opField "thumbnail_info" thumbnailInfoDecoder)
        (opField "thumbnail_url" D.string)
        (opField "w" D.int)


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


{-| Decode a small key of which its size does not exceed 255 bytes
-}
smallKeyDecoder : D.Decoder String
smallKeyDecoder =
    V.decoder (V.maxWidth 255) D.string
