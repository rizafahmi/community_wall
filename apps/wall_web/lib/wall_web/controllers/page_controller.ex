defmodule WallWeb.PageController do
  use WallWeb, :controller

  def index(conn, _params) do
    edges = Crawler.get_instagram("ceritanyadeveloper")
    render(conn, "index.html", edges: edges)
  end
end
