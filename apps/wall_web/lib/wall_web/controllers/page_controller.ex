defmodule WallWeb.PageController do
  use WallWeb, :controller

  def show(conn, %{"hashtag" => hashtag}) do
    # hashtag = System.get_env("HASHTAG") || "ceritanyadeveloper"
    edges = Crawler.get_instagram(hashtag)
    {auto_refresh, _} = Integer.parse(System.get_env("AUTO_REFRESH_MILISECONDS"))
    refresh_every = round(auto_refresh)
    render(conn, "show.html", hashtag: hashtag, edges: edges, refresh_every: refresh_every)
  end

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
