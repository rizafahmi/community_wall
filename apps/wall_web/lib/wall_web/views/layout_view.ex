defmodule WallWeb.LayoutView do
  use WallWeb, :view

  def get_title(hashtag) do
    "#" <> hashtag
  end
end
