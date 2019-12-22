defmodule WallWeb.Router do
  use WallWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", WallWeb do
    pipe_through(:browser)

    get("/", PageController, :index)
    get("/:hashtag", PageController, :show)
  end

  # Other scopes may use custom stacks.
  # scope "/api", WallWeb do
  #   pipe_through :api
  # end
end
