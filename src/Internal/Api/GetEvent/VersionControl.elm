module Internal.Api.GetEvent.VersionControl exposing (..)

import Internal.Values.Exceptions as X
import Task exposing (Task)


type alias GetEventVersion pIn pOut cIn cOut =
    { version : String
    , downcast : cIn -> pIn
    , current : cIn -> Task X.Error cOut
    , upcast : pOut -> cOut
    }
