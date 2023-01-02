module Internal.Values.EventTypes exposing
    ( MRoomName
    , MRoomTopic
    , encodeMRoomName
    , encodeMRoomTopic
    , mRoomNameDecoder
    , mRoomTopicDecoder
    )

{-| Automatically generated 'EventTypes'

Last generated at Unix time 1672363433

-}

import Internal.Tools.EncodeExtra exposing (maybeObject)
import Json.Decode as D
import Json.Encode as E


{-| The room name is a human-friendly string designed to be displayed to the end-user.
-}
type alias MRoomName =
    { name : String
    }


encodeMRoomName : MRoomName -> E.Value
encodeMRoomName data =
    maybeObject
        [ ( "name", Just <| E.string data.name )
        ]


mRoomNameDecoder : D.Decoder MRoomName
mRoomNameDecoder =
    D.map
        (\a ->
            { name = a }
        )
        (D.field "name" D.string)


{-| A topic is a short message detailing what is currently being discussed in the room. It can also be used as a way to display extra information about the room, which may not be suitable for the room name.
-}
type alias MRoomTopic =
    { topic : String
    }


encodeMRoomTopic : MRoomTopic -> E.Value
encodeMRoomTopic data =
    maybeObject
        [ ( "topic", Just <| E.string data.topic )
        ]


mRoomTopicDecoder : D.Decoder MRoomTopic
mRoomTopicDecoder =
    D.map
        (\a ->
            { topic = a }
        )
        (D.field "topic" D.string)
