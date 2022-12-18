module Internal.Events exposing (..)

{-|


# Matrix Events

Matrix contains a large number of events, each with different rules on how to decode them.
Additionally, these events are sent by unknown Matrix users, which means their
content is not always to be trusted. This is tricky!

This file addresses a large list of event types. If you extract an event's content,
you can use the functions here to interpret them. All events will be `Value` types from
the `elm/json` library though, so you can always try and decode them yourself!

-}

import Internal.Tools.DecodeExtra exposing (opField)
import Internal.Values.Objects as O
import Internal.Values.SpecEnums as Enums
import Internal.Values.SpecObjects as Objects
import Json.Decode as D


{-| Function used to decode events by using their respected decoder.
-}
decodeWith : D.Decoder a -> D.Value -> Result String a
decodeWith decoder value =
    case D.decodeValue decoder value of
        Ok v ->
            Ok v

        Err ->
            D.errorToString e
                |> Err



{- ROOM AVATAR -}


type RoomAvatar
    = RoomAvatar Maybe O.Image


roomAvatarDecoder : D.Decoder RoomAvatar
roomAvatarDecoder =
    opField "url" D.string
    |> D.andThen
        (\v -> 
            case v of
                Just _ ->
                    D.map Just O.imageDecoder
                Nothing ->
                    D.succeed Nothing
        )

getRoomAvatarImage : RoomAvatar -> Maybe O.Image
getRoomAvatarImage (RoomAvatar img) =
    img



{- ROOM NAME -}


type RoomName
    = RoomName Maybe String


roomNameDecoder : D.Decoder RoomName
roomNameDecoder =
    D.string
        |> opField "name"
        |> D.maybe
        |> D.andThen
            (\v ->
                case v of
                    Nothing ->
                        D.succeed Nothing

                    -- A room with an m.room.name event with an empty name field
                    -- should be treated the same as a room with no m.room.name
                    -- event.
                    Just "" ->
                        D.succeed Nothing

                    _ ->
                        D.succeed (RoomName v)
            )


getRoomName : RoomName -> Maybe String
getRoomName name =
    case name of
        RoomName s ->
            s



{- ROOM TOPIC -}


type RoomTopic
    = RoomTopic String


roomTopicDecoder : D.Decoder RoomTopic
roomTopicDecoder =
    D.string
        |> D.field "topic"
        |> D.map RoomTopic


getRoomTopic : RoomTopic -> String
getRoomTopic topic =
    case topic of
        RoomTopic t ->
            t
