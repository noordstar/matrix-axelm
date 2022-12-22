module Internal.Api.GetEvent.V1_5.Objects exposing
    ( OldBlindEvent
    , UnsignedData(..)
    , encodeOldBlindEvent
    , encodeUnsignedData
    , oldBlindEventDecoder
    , unsignedDataDecoder
    )

{-| Automatically generated 'Objects'

Last generated at Unix time 1671727473

-}

import Dict exposing (Dict)
import Internal.Tools.DecodeExtra exposing (opField, opFieldWithDefault)
import Internal.Tools.EncodeExtra exposing (maybeObject)
import Internal.Tools.Timestamp exposing (Timestamp, encodeTimestamp, timestampDecoder)
import Internal.Values.SpecEnums as Enums
import Json.Decode as D
import Json.Encode as E


{-| Client Event that contains significantly less information in older spec versions.
-}
type alias OldBlindEvent =
    { content : E.Value
    , eventId : Maybe String
    , originServerTs : Maybe Timestamp
    , roomId : Maybe String
    , sender : Maybe String
    , stateKey : Maybe String
    , contentType : String
    , unsigned : Maybe UnsignedData
    }


encodeOldBlindEvent : OldBlindEvent -> E.Value
encodeOldBlindEvent data =
    maybeObject
        [ ( "content", Just <| data.content )
        , ( "event_id", Maybe.map E.string data.eventId )
        , ( "origin_server_ts", Maybe.map encodeTimestamp data.originServerTs )
        , ( "room_id", Maybe.map E.string data.roomId )
        , ( "sender", Maybe.map E.string data.sender )
        , ( "state_key", Maybe.map E.string data.stateKey )
        , ( "type", Just <| E.string data.contentType )
        , ( "unsigned", Maybe.map encodeUnsignedData data.unsigned )
        ]


oldBlindEventDecoder : D.Decoder OldBlindEvent
oldBlindEventDecoder =
    D.map8
        (\a b c d e f g h ->
            { content = a, eventId = b, originServerTs = c, roomId = d, sender = e, stateKey = f, contentType = g, unsigned = h }
        )
        (D.field "content" D.value)
        (opField "event_id" D.string)
        (opField "origin_server_ts" timestampDecoder)
        (opField "room_id" D.string)
        (opField "sender" D.string)
        (opField "state_key" D.string)
        (D.field "type" D.string)
        (opField "unsigned" (D.lazy (\_ -> unsignedDataDecoder)))


{-| Extra information about the event.
-}
type UnsignedData
    = UnsignedData
        { age : Maybe Int
        , prevContent : Maybe E.Value
        , redactedBecause : Maybe OldBlindEvent
        , transactionId : Maybe String
        }


encodeUnsignedData : UnsignedData -> E.Value
encodeUnsignedData (UnsignedData data) =
    maybeObject
        [ ( "age", Maybe.map E.int data.age )
        , ( "prev_content", data.prevContent )
        , ( "redacted_because", Maybe.map encodeOldBlindEvent data.redactedBecause )
        , ( "transaction_id", Maybe.map E.string data.transactionId )
        ]


unsignedDataDecoder : D.Decoder UnsignedData
unsignedDataDecoder =
    D.map4
        (\a b c d ->
            UnsignedData { age = a, prevContent = b, redactedBecause = c, transactionId = d }
        )
        (opField "age" D.int)
        (opField "prev_content" D.value)
        (opField "redacted_because" oldBlindEventDecoder)
        (opField "transaction_id" D.string)
