#!/bin/sh
export MIX_ENV=prod

# Initial setup
mix deps.get --only prod
mix compile

# Compile assets
$ npm run deploy --prefix ./assets
$ mix phx.digest

# Custom tasks (like DB migrations)
mix ecto.migrate

# Finally run the server #關掉 terminal 也無妨
PORT=4001 elixir --erl "-detached" -S mix phx.server
