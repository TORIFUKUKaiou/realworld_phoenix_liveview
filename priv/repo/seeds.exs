# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     RealworldPhoenixLiveview.Repo.insert!(%RealworldPhoenixLiveview.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias RealworldPhoenixLiveview.Blogs
alias RealworldPhoenixLiveview.Blogs.Article
alias RealworldPhoenixLiveview.Blogs.Comment
alias RealworldPhoenixLiveview.Blogs.Tag

alias RealworldPhoenixLiveview.Accounts
alias RealworldPhoenixLiveview.Accounts.User

alias RealworldPhoenixLiveview.Repo

{:ok, author} = Accounts.register_user(%{email: "hoge@test.com", password: "validpassword"})

%{title: "some title1", body: "some body", tags: ["tag1", "tag2"], author_id: author.id}
|> Blogs.create_article()

%{title: "some title2", body: "some body", tags: ["tag2", "tag3"], author_id: author.id}
|> Blogs.create_article()
