defmodule RealworldPhoenixLiveview.Blogs.ArticleTag do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "articles_tags" do
    field :article_id, :id
    field :tag_id, :id
  end

  @doc false
  def changeset(article_tag, attrs) do
    article_tag
    |> cast(attrs, [:tag_id, :article_id])
    |> validate_required([:tag_id, :article_id])
  end
end
