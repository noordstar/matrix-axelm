module Internal.Values.Event exposing (..)

import Internal.Tools.Timestamp as T
import Json.Decode as D
import Json.Encode as E


type Event
    = Event
        { content : E.Value
        , eventId : Maybe String
        , originServerTs : Maybe T.Timestamp
        , roomId : String
        , sender : Maybe String
        , stateKey : Maybe String
        , contentType : String
        , unsigned : UnsignedData
        }


type alias UnsignedData =
    { age : Maybe Int
    , prevContent : Maybe E.Value
    , redactedBecause : Maybe Event
    , transactionId : Maybe String
    }


eventId : Event -> Maybe String
eventId (Event event) =
    event.eventId


getContent : Event -> E.Value
getContent (Event event) =
    event.content


decodeContentWith : D.Decoder a -> Event -> Maybe a
decodeContentWith decoder (Event event) =
    case D.decodeValue decoder event.content of
        Ok v ->
            Just v

        _ ->
            Nothing


roomId : Event -> String
roomId (Event event) =
    event.roomId
