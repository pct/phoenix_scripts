# 如何做 phoenix admin 面板

首先，在 project 的以下幾個地方，就是預設會 gen 出的程式碼：

*  deps/phoenix/priv/templates/phx.gen.html
* deps/phoenix/lib/mix/tasks/phx.gen.html.ex


詳細教學：

* https://medium.com/@mutablestate/customise-your-phoenix-html-generator-d45fecd48683

所以，按照這篇的教學，把 phx.gen.html 的對應檔案都複製一份到新的面板(如 ooo)，這樣就可以不使用 mix phx.gen.html 而改用 mix ooo.gen.html 來 gen scaffolding 程式碼 



