#console

## DB Seed
參考 priv/repo 裡面的 seeds.exs

參考，可以整理出 iex 啟動時要預載的資料

https://samuelmullen.com/articles/customizing_elixirs_iex/


然後可以用以下的幾個片段：

    File.exists?(Path.expand("~/.iex.exs")) && import_file("~/.iex.exs")

    import Ecto.Query

    alias Project.Repo

    alias Project.User
    alias Project.Post

    #=======

    dwarves = ["Fili","Kili", "Oin", "Gloin", "Thorin", "Dwalin", "Balin", "Bifur",
      "Bofur", "Bombur", "Dori", "Nori", "Ori"]

    #======

    timestamp = fn -> # for use in your prompt
      {_date, {hour, minute, _second}} = :calendar.local_time
      [hour, minute]
      |> Enum.map(&(String.pad_leading(Integer.to_string(&1), 2, "0")))
      |> Enum.join(":")
    end
