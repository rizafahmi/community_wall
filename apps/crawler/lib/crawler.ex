defmodule Crawler do
  def get_instagram(hashtag) do
    case Mojito.request(:get, "https://www.instagram.com/explore/tags/#{hashtag}/?__a=1") do
      {:ok, %Mojito.Response{body: body}} ->
        %{"graphql" => %{"hashtag" => %{"edge_hashtag_to_media" => %{"edges" => edges}}}} =
          Jason.decode!(body)

        edges

      _ ->
        {:error}
    end
  end
end
