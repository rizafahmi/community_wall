defmodule Crawler do
  def get_instagram(hashtag) do
    case Mojito.request(:get, "https://www.instagram.com/explore/tags/#{hashtag}/?__a=1") do
      {:ok, %Mojito.Response{body: body}} ->
        %{"graphql" => %{"hashtag" => %{"edge_hashtag_to_media" => %{"edges" => edges}}}} =
          Jason.decode!(body)

        deep_edges =
          Enum.map(edges, fn edge ->
            %{"node" => %{"edge_media_to_caption" => %{"edges" => edges}}} = edge
            edges
          end)

        texts =
          Enum.map(deep_edges, fn edge ->
            %{"node" => %{"text" => text}} = Enum.at(edge, 0)
            text
          end)

        thumbnails =
          Enum.map(edges, fn edge ->
            %{"node" => %{"thumbnail_src" => thumbnail_src}} = edge
            thumbnail_src
          end)

        data =
          texts
          |> Enum.with_index()
          |> Enum.map(fn {_num, i} ->
            List.insert_at([], i, {Enum.at(texts, i), Enum.at(thumbnails, i)})
          end)
          |> List.flatten()

        data

      _ ->
        {:error}
    end
  end
end
