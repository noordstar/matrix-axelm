module Internal.Event exposing (..)

import Internal.Api.Sync.V1_5.Objects as O
import Internal.Values.Event as Event exposing (Event(..))

fromClientEventWithoutRoomId : String -> O.ClientEventWithoutRoomId -> Event
fromClientEventWithoutRoomId roomId event =
    Event
        { content = event.content
        , eventId = Just event.eventId
        , originServerTs = Just event.originServerTs
        , roomId = roomId
        , sender = Just event.sender
        , stateKey = event.stateKey
        , contentType = event.contentType
        , unsigned =
            case event.unsigned of
                Just (O.UnsignedData data) ->
                    { age = data.age
                    , prevContent = data.prevContent
                    , redactedBecause = Maybe.map (fromOldBlindEvent roomId) data.redactedBecause
                    , transactionId = data.transactionId
                    }

                Nothing ->
                    { age = Nothing
                    , prevContent = Nothing
                    , redactedBecause = Nothing
                    , transactionId = Nothing
                    }
        }

fromOldBlindEvent : String -> O.OldBlindEvent -> Event
fromOldBlindEvent roomId event =
    Event
        { content = event.content
        , eventId = event.eventId
        , originServerTs = event.originServerTs
        , roomId = roomId
        , sender = event.sender
        , stateKey = event.stateKey
        , contentType = event.contentType
        , unsigned = 
            case event.unsigned of
                Just (O.UnsignedData data) ->
                    { age = data.age
                    , prevContent = data.prevContent
                    , redactedBecause = Maybe.map (fromOldBlindEvent roomId) data.redactedBecause
                    , transactionId = data.transactionId
                    }

                Nothing ->
                    { age = Nothing
                    , prevContent = Nothing
                    , redactedBecause = Nothing
                    , transactionId = Nothing
                    }
        }

