module Matrix exposing
    ( Credentials
    , Updater, syncCredentials
    )

{-| The Matrix module takes care of all high-level communication.


# Credentials

@docs Credentials, fromAccessToken


# Updating credentials

Every now and then, the Matrix homeserver sends new information that you need to remember.
Don't worry, the `Credentials` have got you covered. You will need to update your credentials, though.

@docs Updater, syncCredentials

-}

import Internal.Credentials


{-| The Matrix API requires the user to keep track of lots of tokens:
access tokens, registration tokens, third party tokens, opaque batch values, and more.
That's too much work!

You can consider the `Credentials` type as a large ring of keys,
and Elm will figure out which key to use.
If you pass the `Credentials` into any function, then the library will look for
the right keys and tokens to get the right information.

You can use the module Matrix.Credentials to initialize your credentials, or load existing credentials from JSON.

-}
type alias Credentials =
    Internal.Credentials.Credentials


{-| Some functions render a `Cmd msg` that ultimately results in an update function for your credentials.

**Why not just pass new Credentials?** This won't work if you send multiple commands.


    type Msg
        = ChangesMade (Credentials -> Credentials)

    -- someAction : Updater msg -> Cmd msg
    -- someAction ChangesMade  --> Cmd Msg

-}
type alias Updater msg =
    (Credentials -> Credentials) -> msg


{-| Get the latest changes from the Matrix homeserver.

The Matrix API has a `/sync` endpoint that basically says _"give me an update on EVERYTHING"_.
This command will reach that endpoint and make sure all the latest data has been retrieved.

-}
syncCredentials : Updater msg -> Credentials -> Cmd msg
syncCredentials =
    Internal.Credentials.sync
