module Matrix.Credentials exposing (fromAccessToken, withUsernameAndPassword)

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

Logging into a Matrix account doesn't always work the way people think it does.
You don't need to log in if you already have access, ever.

For that reason, we avoid the term "login" here and we're only talking about
creating Credentials using certain values.

The Credentials will take care of when to log in!

@docs fromAccessToken, withUsernameAndPassword

-}

import Internal.Credentials as Internal
import Matrix exposing (Credentials)


{-| Create new [Credentials](Matrix#Credentials) using an access token.

This function is mostly useful for bots and small scripts. You can use
this function to connect to a homeserver without needing to log in,
but the Credentials will no longer work if the access token ever expires.

    cred : Credentials
    cred =
        fromAccessToken
            { baseUrl = "https://matrix.example.com"
            , token = "my-secret-access-token"
            }

-}
fromAccessToken : { baseUrl : String, token : String } -> Credentials
fromAccessToken data =
    Internal.fromAccessToken data.baseUrl data.token


{-| Create new [Credentials](Matrix#Credentials) using a username and a password.

This function is mostly useful for clients that aim to be logged in automatically.
Using a password, the credentials can automatically log back in after old tokens
expire or lose their validity.

-}
withUsernameAndPassword : { baseUrl : String, username : String, password : String } -> Credentials
withUsernameAndPassword data =
    Internal.withUsernameAndPassword data.baseUrl data.username data.password
