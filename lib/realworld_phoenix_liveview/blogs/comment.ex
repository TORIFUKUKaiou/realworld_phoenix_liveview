defmodule RealworldPhoenixLiveview.Blogs.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :body, :string

    belongs_to :author, User

    belongs_to :article, RealworldPhoenixLiveview.Blogs.Article

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :article_id, :author_id])
    |> validate_required([:body, :article_id, :author_id])
  end
end
