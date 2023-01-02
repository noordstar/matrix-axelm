module Matrix.Credentials exposing (loginAsDeviceName)

{-|

The Credentials take care of a lot of stuff for you,
and the library is designed so that you don't have to worry about how it works.
However, sometimes you'll want to customize its behaviour and you'll be able
to do so here.

@docs loginAsDeviceName

-}
import Internal.Values.Credentials exposing (Credentials)

{-| When the credentials are logging into an account and then Matrix API asks them
for a device name, the credentials will use this name.
-}
loginAsDeviceName : String -> Credentials -> Credentials
loginAsDeviceName =
    Internal.Values.Credentials.loginAsDeviceName
