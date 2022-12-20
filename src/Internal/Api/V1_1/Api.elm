module Internal.Api.V1_1.Api exposing (..)

import Internal.Api.Request as R
import Internal.Api.VersionControl exposing (..)
import Internal.Api.V1_1.Objects as O
import Internal.Api.V1_1.SpecObjects as SO
import Internal.Values.Exceptions as X
import Internal.Values.SpecEnums as Enums
import Json.Decode as D
import Task exposing (Task)
import Dict

packet : VersionPacket () Sync
packet =
    { sync = sync
    , upcastSync = 
        (\_ -> 
            { accountData = { events = [] }
            , nextBatch = ""
            , presence = { events = [] }
            , rooms =
                { invite = Dict.empty
                , join = Dict.empty
                , knock = Dict.empty
                , leave = Dict.empty
                }
            }
        ) 
    }

sync : SyncInput -> Task X.Error Sync
sync data =
    R.rawApiCall
        { headers = R.WithAccessToken data.accessToken
        , method = "GET"
        , baseUrl = data.baseUrl
        , path = "/_matrix/client/v3/sync"
        , pathParams = []
        , queryParams =
            [ R.OpQueryParamString "filter" data.filter
            , R.QueryParamBool "full_state" (Maybe.withDefault False data.fullState)
            , R.OpQueryParamString "set_presence" (Maybe.map Enums.fromUserPresence data.setPresence)
            , R.OpQueryParamString "since" data.since
            , R.OpQueryParamInt "timeout" data.timeout
            ]
        , bodyParams = []
        , timeout = 
            data.timeout
            |> Maybe.map (\t -> t + 10000)
            |> Maybe.map toFloat
        , decoder = (\_ -> syncDecoder)
        }

type alias Sync =
    { accountData : SO.AccountData
    , nextBatch   : String
    , presence : SO.Presence
    , rooms : SO.Rooms
    }

syncDecoder : D.Decoder Sync
syncDecoder =
    D.map4
        (\a b c d -> { accountData = a, nextBatch = b, presence = c, rooms = d })
        (D.field "account_data" SO.accountDataDecoder)
        (D.field "next_batch" D.string)
        (D.field "presence" SO.presenceDecoder)
        (D.field "rooms" SO.roomsDecoder)
