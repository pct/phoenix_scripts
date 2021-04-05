#console

## DB Seed
參考 priv/repo 裡面的 seeds.exs

參考，可以整理出 iex 啟動時要預載的資料

https://samuelmullen.com/articles/customizing_elixirs_iex/


然後可以用以下的幾個片段：

    admin = %{email: "aa@bb.cc", password: "my_new_password", password_confirmation: "my_new_password"}
    Admins.register_admin(admin)
