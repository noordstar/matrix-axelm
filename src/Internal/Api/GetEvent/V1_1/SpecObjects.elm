module Internal.Api.GetEvent.V1_1.SpecObjects exposing
    ( Event
    , encodeEvent
    , eventDecoder
    )

{-| Automatically generated 'SpecObjects'

Last generated at Unix time 1671746367

-}

import Internal.Tools.EncodeExtra exposing (maybeObject)
import Json.Decode as D
import Json.Encode as E


{-| The event that has been requested.
-}
type alias Event =
    { content : E.Value
    , contentType : String
    }


encodeEvent : Event -> E.Value
encodeEvent data =
    maybeObject
        [ ( "content", Just <| data.content )
        , ( "type", Just <| E.string data.contentType )
        ]


eventDecoder : D.Decoder Event
eventDecoder =
    D.map2
        (\a b ->
            { content = a, contentType = b }
        )
        (D.field "content" D.value)
        (D.field "type" D.string)
