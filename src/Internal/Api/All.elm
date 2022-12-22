module Internal.Api.All exposing (..)

{-| This module lists all available functions to reach the Matrix API.
-}

import Internal.Api.GetEvent.Main as GetEvent


type alias Versions =
    List String


{-| Get a particular event by its event id and room id.
-}
getEvent : Versions -> GetEvent.EventInput -> GetEvent.EventOutput
getEvent =
    GetEvent.getEvent
