defmodule WallWeb.PageController do
  use WallWeb, :controller

  def index(conn, _params) do
    hashtag = System.get_env("HASHTAG") || "ceritanyadeveloper"
    edges = Crawler.get_instagram(hashtag)
    {auto_refresh, _} = Integer.parse(System.get_env("AUTO_REFRESH_MILISECONDS"))
    refresh_every = round(auto_refresh)
    render(conn, "index.html", hashtag: hashtag, edges: edges, refresh_every: refresh_every)
  end
end
