defmodule RealworldPhoenixLiveviewWeb.ArticleLive.Index do
  use RealworldPhoenixLiveviewWeb, :live_view

  alias RealworldPhoenixLiveview.Blogs
  alias RealworldPhoenixLiveview.Repo

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, articles: list_articles(), tags: list_tags())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  def handle_event("tag", %{"tagname" => tag_name}, socket) do
    {:reply, %{}, assign(socket, articles: list_articles(tag_name))}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Articles")
    |> assign(:article, nil)
  end

  defp list_articles(tag_name) do
    Blogs.list_articles_by_tag(tag_name) |> Repo.preload(:author)
  end

  defp list_articles do
    Blogs.list_articles() |> Repo.preload(:author)
  end

  defp list_tags do
    Blogs.list_tags()
  end
end
