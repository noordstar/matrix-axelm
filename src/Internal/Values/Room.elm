module Internal.Values.Room exposing (..)

import Dict
import Internal.Api.Sync.V1_5.Objects as O
import Internal.Values.Event as Ev
import Internal.Values.StateManager as S
import Json.Encode as E


type Room
    = Room
        { accountData : S.EventManager
        , ephemeral : List O.BlindEvent
        , events : Dict.Dict String Ev.Event
        , roomId : String
        , startOfTime : S.StateEventManager
        , timeline : List TimelinePiece
        }


type TimelinePiece
    = BlindEvent { content : E.Value, contentType : String }
    | TimelineEvent String
    | Gap { from : String, to : String }
    | BatchBorder { sinceParam : String, deltaState : List Ev.Event }
