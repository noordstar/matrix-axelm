module Internal.Values.Names exposing (..)

import Internal.Values.Credentials as C
import Internal.Values.Exceptions as X


type alias Updater msg =
    (C.Credentials -> C.Credentials) -> msg


type alias Response =
    Result String (C.Credentials -> C.Credentials)


type SharedInfo info msg
    = Available info
    | OnlineAvailable ((Response -> msg) -> Cmd msg)
    | Unavailable
