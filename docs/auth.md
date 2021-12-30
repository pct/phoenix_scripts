```
$ mix phx.gen.auth Admins Admin admins --web Admins
$ mix ecto.create
$ mix deps.get
$ mix ecto.migrate
```

##記得處理
1.把需要後台登入才能管理的項目都寫到 routes 的 :require_authenticated_admin 裡。
2.記得拔掉 admin 的註冊(admin不該能註冊)，去除 routes 這兩行

    get "/admins/register", AdminRegistrationController, :new
    post "/admins/register", AdminRegistrationController, :create


----

Accounts.register_user( %{email: "", password: ""} )


