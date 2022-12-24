module Internal.Api.Sync.V1_1.Convert exposing (..)

import Dict
import Internal.Api.Sync.V1_1.Objects as O
import Internal.Api.Sync.V1_1.SpecObjects as SO


convert : SO.Sync -> O.Sync
convert sync =
    { accountData = convertEventHolder sync.accountData
    , nextBatch = sync.nextBatch
    , presence = convertEventHolder sync.presence
    , rooms = Maybe.map convertRooms sync.rooms
    }


convertEventHolder : Maybe { a | events : List b } -> List b
convertEventHolder =
    Maybe.map .events >> Maybe.withDefault []


convertRooms : SO.Rooms -> O.Rooms
convertRooms rooms =
    { invite =
        Dict.map
            (\_ -> .inviteState >> Maybe.map .events >> Maybe.withDefault [])
            rooms.invite
    , join = Dict.map (\_ -> convertJoinedRoom) rooms.join
    , knock =
        Dict.map
            (\_ -> .knockState >> Maybe.map .events >> Maybe.withDefault [])
            rooms.knock
    , leave = Dict.map (\_ -> convertLeftRoom) rooms.leave
    }


convertJoinedRoom : SO.JoinedRoom -> O.JoinedRoom
convertJoinedRoom room =
    { accountData = convertEventHolder room.accountData
    , ephemeral = convertEventHolder room.ephemeral
    , state = convertEventHolder room.state
    , summary = room.summary
    , timeline = room.timeline
    , unreadNotifications = room.unreadNotifications
    }


convertLeftRoom : SO.LeftRoom -> O.LeftRoom
convertLeftRoom room =
    { accountData = convertEventHolder room.accountData
    , state = convertEventHolder room.state
    , timeline = room.timeline
    }
