defmodule RealworldPhoenixLiveviewWeb.ArticleLive.Index do
  use RealworldPhoenixLiveviewWeb, :live_view

  alias RealworldPhoenixLiveview.Blogs
  alias RealworldPhoenixLiveview.Repo

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :articles, list_articles())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Articles")
    |> assign(:article, nil)
  end

  defp list_articles do
    Blogs.list_articles() |> Repo.preload(:author)
  end
end
