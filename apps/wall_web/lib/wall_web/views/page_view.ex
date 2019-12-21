defmodule WallWeb.PageView do
  use WallWeb, :view

  def show_text(edge) do
    {text, _image} = edge
    String.slice(text, 0, 250) <> "..."
  end

  def show_image(edge) do
    {_text, image} = edge
    image
  end
end
