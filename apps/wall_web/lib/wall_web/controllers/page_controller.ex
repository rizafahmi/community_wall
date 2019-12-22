defmodule WallWeb.PageController do
  use WallWeb, :controller

  def index(conn, _params) do
    edges = Crawler.get_instagram("ceritanyadeveloper")
    render(conn, "index.html", edges: edges)
  end

  def show(conn, %{"hashtag" => hashtag}) do
    edges = Crawler.get_instagram(hashtag)
    render(conn, "index.html", hashtag: hashtag, edges: edges)
  end
end
