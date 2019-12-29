defmodule WallWeb.PageControllerTest do
  use WallWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ System.get_env("HASHTAG")
  end
end
