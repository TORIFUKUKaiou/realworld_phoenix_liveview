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
alias RealworldPhoenixLiveview.Repo

article =
  %{title: "some title", body: "some body", tags: ["tag1", "tag2"]}
  |> Blogs.create_article()
