#!/bin/sh
export MIX_ENV=prod

# mix phx.gen.secret
export SECRET_KEY_BASE=REALLY_LONG_SECRET

# database
export DATABASE_URL=ecto://USER:PASS@HOST/database

# Initial setup
mix deps.get --only prod
mix compile

# Compile assets
mix assets.deploy

# Custom tasks (like DB migrations)
mix ecto.migrate

# Finally run the server #關掉 terminal 也無妨
PORT=4001 elixir --erl "-detached" -S mix phx.server
