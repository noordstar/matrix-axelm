module Internal.Api.SendStateKey.V1_2.SpecObjects exposing
    ( EventResponse
    , encodeEventResponse
    , eventResponseDecoder
    )

{-| Automatically generated 'SpecObjects'

Last generated at Unix time 1671796682

-}

import Internal.Tools.EncodeExtra exposing (maybeObject)
import Json.Decode as D
import Json.Encode as E


{-| A response confirming that an event has been sent.
-}
type alias EventResponse =
    { eventId : String
    }


encodeEventResponse : EventResponse -> E.Value
encodeEventResponse data =
    maybeObject
        [ ( "event_id", Just <| E.string data.eventId )
        ]


eventResponseDecoder : D.Decoder EventResponse
eventResponseDecoder =
    D.map
        (\a ->
            { eventId = a }
        )
        (D.field "event_id" D.string)
