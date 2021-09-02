defmodule RealworldPhoenixLiveview.Repo.Migrations.AddColumnAuthorId do
  use Ecto.Migration

  def change do
    alter table("articles") do
      add :author_id, references(:users, on_delete: :nothing)
    end

    alter table("comments") do
      add :author_id, references(:users, on_delete: :nothing)
    end
  end
end
