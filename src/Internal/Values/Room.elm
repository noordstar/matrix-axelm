module Internal.Values.Room exposing (..)

import Dict
import Internal.Api.Sync.V1_5.Objects as O
import Internal.Values.Event as Ev
import Json.Encode as E


type Room
    = Room
        { accountData : List O.BlindEvent
        , ephemeral : List O.BlindEvent
        , events : Dict.Dict String Ev.Event
        , startOfTime : List Ev.Event
        , timeline : List TimelinePiece
        }


type TimelinePiece
    = BlindEvent { content : E.Value, contentType : String }
    | TimelineEvent String
    | Gap { from : String, to : String }
    | BatchBorder { sinceParam : String, deltaState : List Ev.Event }
