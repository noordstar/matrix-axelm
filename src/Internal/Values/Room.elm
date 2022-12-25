module Internal.Values.Room exposing (..)

import Dict
import Internal.Values.Event as Ev
import Json.Encode as E

type Room =
    Room { events : Dict.Dict String Ev.Event 
         , timeline : Timeline
         }

type alias Timeline =
    { startOfTime : List Ev.Event
    , timeline : List TimelinePiece
    }

type TimelinePiece
    = BlindEvent { content : E.Value, contentType : String }
    | TimelineEvent String
    | Gap { from : String, to : String }
    | BatchBorder { sinceParam : String, deltaState : List Ev.Event }