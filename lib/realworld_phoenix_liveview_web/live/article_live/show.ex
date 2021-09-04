defmodule RealworldPhoenixLiveviewWeb.ArticleLive.Show do
  use RealworldPhoenixLiveviewWeb, :live_view

  alias RealworldPhoenixLiveview.Blogs
  alias RealworldPhoenixLiveview.Repo

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:article, Blogs.get_article!(id) |> preaload)}
  end

  defp preaload(article) do
    article
    |> Repo.preload(:author)
    |> Repo.preload(:comments)
  end

  defp page_title(:show), do: "Show Article"
  defp page_title(:edit), do: "Edit Article"
end
