module Internal.Api.GetEvent.V1_1.Objects exposing
    ( BlindEvent
    , blindEventDecoder
    , encodeBlindEvent
    )

{-| Automatically generated 'Objects'

Last generated at Unix time 1671726618

-}

import Dict exposing (Dict)
import Internal.Tools.DecodeExtra exposing (opField, opFieldWithDefault)
import Internal.Tools.EncodeExtra exposing (maybeObject)
import Internal.Tools.Timestamp exposing (Timestamp, encodeTimestamp, timestampDecoder)
import Internal.Values.SpecEnums as Enums
import Json.Decode as D
import Json.Encode as E


{-| Blind event
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
