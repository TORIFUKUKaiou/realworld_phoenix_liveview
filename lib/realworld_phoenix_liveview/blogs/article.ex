defmodule RealworldPhoenixLiveview.Blogs.Article do
  use Ecto.Schema
  import Ecto.Changeset

  import Ecto.Query

  alias RealworldPhoenixLiveview.Repo
  alias RealworldPhoenixLiveview.Blogs.Tag
  alias RealworldPhoenixLiveview.Blogs.ArticleTag

  alias RealworldPhoenixLiveview.Accounts.User

  schema "articles" do
    field :body, :string
    field :title, :string

    belongs_to :author, User

    has_many :comments, RealworldPhoenixLiveview.Blogs.Comment

    many_to_many :tags, Tag,
      join_through: ArticleTag,
      on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :body, :author_id])
    |> validate_required([:title, :body, :author_id])
    |> put_assoc(:tags, parse_tags(attrs))
  end

  # Parse tags has slightly changed
  defp parse_tags(params) do
    (params[:tags] || params["tags"] || [])
    |> insert_and_get_all()
  end

  defp insert_and_get_all([]), do: []

  defp insert_and_get_all(names) do
    timestamp =
      NaiveDateTime.utc_now()
      |> NaiveDateTime.truncate(:second)

    placeholders = %{timestamp: timestamp}

    maps =
      names
      |> Enum.map(
        &%{
          tag: &1,
          inserted_at: {:placeholder, :timestamp},
          updated_at: {:placeholder, :timestamp}
        }
      )

    Repo.insert_all(
      Tag,
      maps,
      placeholders: placeholders,
      on_conflict: :nothing
    )

    from(t in Tag, where: t.tag in ^names)
    |> Repo.all()
  end
end
