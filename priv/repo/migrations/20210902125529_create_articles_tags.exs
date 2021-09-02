defmodule RealworldPhoenixLiveview.Repo.Migrations.CreateArticlesTags do
  use Ecto.Migration

  def change do
    create table(:articles_tags, primary_key: false) do
      add :article_id, references(:articles, on_delete: :nothing)
      add :tag_id, references(:tags, on_delete: :nothing)
    end

    create index(:articles_tags, [:article_id])
    create index(:articles_tags, [:tag_id])
  end
end
