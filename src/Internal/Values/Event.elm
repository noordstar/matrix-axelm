module Internal.Values.Event exposing (..)

import Internal.Tools.Timestamp as T
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
