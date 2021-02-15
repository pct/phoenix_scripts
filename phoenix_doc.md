# phoenix_scripts 教學

## template source

```
$ git clone https://github.com/pct/phoenix_scripts
```

## init

```
$ ./phoenix_scripts/init.sh <project_name>
```

## 設定開發用 DB

```
$ cd <project_name>; vim config/dev.exs
```

## 開發 db create/migrate

```
$ mix ecto.create
$ mix ecto.migrate
```

## 執行

```
$ mix phx.server
```

或，可以 debug 的

```
`$ iex -S mix phx.server`
```

* * *

# Phoenix 教學

* https://hexdocs.pm/phoenix/overview.html

## scaffolding

```
$ mix phx.gen.html Blog Post posts title body:text
```

## deploy step1 - secret

```
$ `mix phx``.``gen``.``secret
`"my_secret_result"
`$ ``export`` SECRET_KEY_BASE``="my_secret_result"`
`$ export DATABASE_URL=ecto://USER:PASS@HOST/database`
```

如果非不得已要寫檔，那就寫在 `config/prod.secret.exs`，但記得不要 git commit 上去，以免被有心人士取走

## deploy step2 - compile

```
$ `mix deps``.``get`` ``--``only prod
$ MIX_ENV=prod mix compile
`
```

## deploy step3 - assets

```
$ `npm run deploy ``--``prefix ``./``assets`
`$ mix phx.digest`
```

## production server

```
$ `PORT=4001 MIX_ENV=prod mix phx.server`
```

如果要關 terminal 後仍可以執行，就改用：

```
`PORT=4001 MIX_ENV=prod elixir --erl "-detached" -S mix phx.server`
```

## 整理出的 product_update.sh

```
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

# Finally run the server #關 terminal 也無妨
PORT=4001 elixir --erl "-detached" -S mix phx.server
```

## 補充：如果要 build 成 binary

* 參考：https://hexdocs.pm/phoenix/releases.html#content

修改 config/prod.secret.exs，取消註解

```
`config :my_app, MyApp.Endpoint, server: true
`
```

然後

```
$ MIX_ENV=prod mix release
```

然後檔案會被放到

```
`_build/prod/rel/<my_app>`
```

要執行就使用以下指令

```
$ `_build/prod/rel/my_app/bin/<my_app> start`
```

```
注意其 assets 都被放到 *build/prod/rel/<my_*app>/lib/<my_app>-xxx/priv/static 底下
```


這樣，就可以打包 _build/prod/rel/my_app 到相同環境的 server 去執行了，不用任何 source code

詳細設定還要繼續參考：https://hexdocs.pm/phoenix/releases.html#releases-assemble

* * *

## 自訂錯誤頁面

* https://hexdocs.pm/phoenix/custom_error_pages.html

* * *

## Docker

* https://hexdocs.pm/phoenix/releases.html#releases-assemble

```
`FROM elixir:1.9.0-alpine AS build

# install build dependencies
RUN apk add --no-cache build-base npm git python

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV=prod

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix do deps.get, deps.compile

# build assets
COPY assets/package.json assets/package-lock.json ./assets/
RUN npm --prefix ./assets ci --progress=false --no-audit --loglevel=error

COPY priv priv
COPY assets assets
RUN npm run --prefix ./assets deploy
RUN mix phx.digest

# compile and build release
COPY lib lib
# uncomment COPY if rel/ exists
# COPY rel rel
RUN mix do compile, release

# prepare release image
FROM alpine:3.9 AS app
RUN apk add --no-cache openssl ncurses-libs

WORKDIR /app

RUN chown nobody:nobody /app

USER nobody:nobody

COPY --from=build --chown=nobody:nobody /app/_build/prod/rel/my_app ./

ENV HOME=/app

CMD ["bin/my_app", "start"]`
```

* * *

# 測試

修改 config/test.exs

```
$ mix test
```

* * *

# 名詞解釋

## ecto

* phoenix 用來連結 DB 的函式
* https://github.com/elixir-ecto/ecto


