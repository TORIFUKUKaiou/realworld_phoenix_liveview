defmodule RealworldPhoenixLiveviewWeb.CommentController do
  use RealworldPhoenixLiveviewWeb, :controller

  alias RealworldPhoenixLiveview.Blogs
  alias RealworldPhoenixLiveview.Blogs.Comment

  action_fallback RealworldPhoenixLiveviewWeb.FallbackController

  def index(conn, _params) do
    comments = Blogs.list_comments()
    render(conn, "index.json", comments: comments)
  end

  def create(conn, %{"comment" => comment_params}) do
    user = conn.assigns.current_user
    comment_params = Map.put(comment_params, "author_id", user.id)

    with {:ok, %Comment{} = comment} <- Blogs.create_comment(comment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.comment_path(conn, :show, comment))
      |> render("show.json", comment: comment)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Blogs.get_comment!(id)
    render(conn, "show.json", comment: comment)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    user = conn.assigns.current_user
    comment_params = Map.put(comment_params, "author_id", user.id)

    comment = Blogs.get_comment!(id)

    with {:ok, %Comment{} = comment} <- Blogs.update_comment(comment, comment_params) do
      render(conn, "show.json", comment: comment)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Blogs.get_comment!(id)

    with {:ok, %Comment{}} <- Blogs.delete_comment(comment) do
      send_resp(conn, :no_content, "")
    end
  end
end
