module Matrix.Credentials exposing ()

{-|


# Matrix.Credentials

The Matrix API requires the user to keep track of lots of tokens:
access tokens, registration tokens, third party tokens, opaque batch values, and more.
That's too much work!

You can consider the `Credentials` type as a large ring of keys,
and Elm will figure out which key to use.
If you pass the `Credentials` into any function, then the library will look for
the right keys and tokens to get the right information.


# Creating new credentials


-}

import Internal.Credentials as Internal
import Matrix exposing (Credentials)


a =
    5
