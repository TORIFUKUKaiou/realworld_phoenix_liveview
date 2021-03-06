defmodule RealworldPhoenixLiveview.Blogs.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tags" do
    field :tag, :string

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:tag])
    |> validate_required([:tag])
    |> unique_constraint(:tag)
  end
end
