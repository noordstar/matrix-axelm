module Matrix exposing
    ( Credentials
    , fromAccessToken, withUsernameAndPassword
    , getRooms, getRoomById
    , syncCredentials, Response, mostRecentSync
    , Updater
    )

{-| The Matrix module takes care of all high-level communication.


# Credentials

Credentials are the central type that keeps you connected to your homeserver.

@docs Credentials


## Creating Credentials

Logging into a Matrix account doesn't always work the way people think it does.
You don't need to log in if you already have access, ever.

For that reason, we avoid the term "login" here and we're only talking about
creating Credentials using certain values.

The Credentials will take care of when to log in!

@docs fromAccessToken, withUsernameAndPassword


# Looking at rooms

You can view all rooms that the user has joined.

@docs getRooms, getRoomById


# Updating credentials

Every now and then, the Matrix homeserver sends new information that you need to remember.
Don't worry, the [Credentials](#Credentials) type has got you covered.
You will need to update your credentials, though.

@docs syncCredentials, Response, mostRecentSync


## Updating

@docs Updater

-}

import Internal.Credentials
import Internal.Values.Credentials
import Internal.Values.Event exposing (Event)
import Internal.Values.Exceptions as X
import Internal.Values.Room exposing (Room)
import Internal.Values.SpecEnums exposing (LoginType(..))


{-| The Matrix API requires the user to keep track of lots of tokens:
access tokens, registration tokens, third party tokens, opaque batch values, and more.
That's too much work!

You can consider the `Credentials` type as a large ring of keys,
and Elm will figure out which key to use.
If you pass the `Credentials` into any function, then the library will look for
the right keys and tokens to get the right information.

-}
type alias Credentials =
    Internal.Values.Credentials.Credentials


{-| Some functions render a `Cmd msg` that ultimately results in an update function for your credentials.

**Why not just pass new Credentials?** This won't work if you send multiple commands.


    type Msg
        = ChangesMade (Credentials -> Credentials)

    -- someAction : Updater msg -> Cmd msg
    -- someAction ChangesMade  --> Cmd Msg

-}
type alias Updater msg =
    (Credentials -> Credentials) -> msg


{-| Not all functions may return a successful response in all cases.
If the Matrix response has a chance to fail, it will use a `Response -> msg` tag,
which either returns a succesful updater function or an error message.

See [syncCredentials](#syncCredentials) for a clear example where this is put into practice.

-}
type alias Response =
    Result String (Credentials -> Credentials)


{-| This is the simplest way to connect to a homeserver.
If you know the server's base URL and you have a valid access token, you have access.

    cred : Credentials
    cred =
        fromAccessToken
            { baseUrl = "https://matrix.example.org"
            , token = "your-access-token-here"
            }

The Credentials type will try its best to keep its connection with the homeserver.
Usually, this will last until the token expires or until the user is deactivated.

-}
fromAccessToken : { baseUrl : String, token : String } -> Credentials
fromAccessToken data =
    Internal.Credentials.fromAccessToken data.baseUrl data.token


{-| The most definite way of connecting to a homeserver is by using a username and password.

    cred : Credentials
    cred =
        withUsernameAndPassword
            { baseUrl = "https://matrix.example.org"
            , username = "privacy-pam"
            , password = "d0nt-us3-th1s-p@ssw0rd"
            }

Traditional SDKs will log you in whenever they restart.
This is a huge waste, because every login will be marked as a new device on the account!
Credentials in this SDK will only log in to get an access token.
As long as that access token remains valid, it will not login again.

This option is a more long-term option because it keeps the user logged in for a longer time.
Unlike [fromAccessToken](#fromAccessToken), the connection will last until the access tokens expire and the user's password has changed.

-}
withUsernameAndPassword : { baseUrl : String, username : String, password : String } -> Credentials
withUsernameAndPassword data =
    Internal.Credentials.withUsernameAndPassword
        data.baseUrl
        data.username
        data.password


{-| Get the latest changes from the Matrix homeserver.

The Matrix API has a `/sync` endpoint that basically says _"give me an update on EVERYTHING"_.
This command will reach that endpoint and make sure all the latest data has been retrieved.

    cred : Credentials
    cred =
        fromAccessToken
            { baseUrl = "https://matrix.example.org"
            , token = "your-access-token-here"
            }

    type Msg
        = ReceiveSync Response
        | SendSync

    update : Msg -> Credentials -> ( Credentials, Cmd Msg )
    update msg model =
        case msg of
            SendSync ->
                ( model, syncCredentials ReceiveSync model )

            ReceiveSync resp ->
                case resp of
                    -- updateCred is a function that updates your credentials
                    Ok updateCred ->
                        ( updateCred model, Cmd.none )

                    -- e is an error string explaining what went wrong
                    Err e ->
                        ( model, Cmd.none )

On a success, the `Cmd Msg` returns an updater function that updates the keys in your [Credentials](#Credentials) type.
On a failure, the `Cmd Msg` returns a string that explains in human friendly format what went wrong.

-}
syncCredentials : (Response -> msg) -> Credentials -> Cmd msg
syncCredentials =
    Internal.Credentials.sync


{-| Get the events that were found at the latest sync.

**Note:** there are more efficient ways to view the most recent events.
This function is meant to help you gain insight on which Matrix rooms are the most active.

-}
mostRecentSync : Credentials -> List Event
mostRecentSync =
    Internal.Credentials.mostRecentSync


{-| Get all rooms that the member has joined.

This room list is relative to the latest sync, so it might not always be 100% accurate.
Some moderator might have kicked the user, or you might have accepted an invite and not received the room status.

    credentials
        |> getRooms
        |> List.map Room.getRoomId

-}
getRooms : Credentials -> List Room
getRooms =
    Internal.Credentials.getRooms


{-| Get a room by its room id. The user must have joined the room.

This function only works if the user was still in the room after the latest sync.

-}
getRoomById : String -> Credentials -> Maybe Room
getRoomById =
    Internal.Credentials.getRoomById
