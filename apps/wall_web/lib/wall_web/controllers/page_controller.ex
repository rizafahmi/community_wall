defmodule WallWeb.PageController do
  use WallWeb, :controller

  def index(conn, _params) do
    edges = Crawler.get_instagram("ceritanyadeveloper")
    render(conn, "index.html", edges: edges)
  end

  def show(conn, %{"hashtag" => hashtag}) do
    edges = Crawler.get_instagram(hashtag)
    {auto_refresh, _} = Integer.parse(System.get_env("AUTO_REFRESH_MILISECONDS"))
    refresh_every = round(auto_refresh / 2)
    render(conn, "index.html", hashtag: hashtag, edges: edges, refresh_every: refresh_every)
  end
end
