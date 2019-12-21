defmodule Crawler do
  def get_instagram(hashtag) do
    case Mojito.request(:get, "https://www.instagram.com/explore/tags/#{hashtag}/?__a=1") do
      {:ok, %Mojito.Response{body: body}} ->
        edges = decode_body(body)

        texts = edges |> get_captions() |> get_texts()
        thumbnails = edges |> get_thumbnails()

        combine_data(texts, thumbnails)

      _ ->
        {:error}
    end
  end

  defp decode_body(body) do
    %{"graphql" => %{"hashtag" => %{"edge_hashtag_to_media" => %{"edges" => edges}}}} =
      Jason.decode!(body)

    edges
  end

  defp get_captions(edges) do
    Enum.map(edges, fn edge ->
      %{"node" => %{"edge_media_to_caption" => %{"edges" => edges}}} = edge
      edges
    end)
  end

  defp get_texts(edges) do
    Enum.map(edges, fn edge ->
      %{"node" => %{"text" => text}} = Enum.at(edge, 0)
      text
    end)
  end

  defp get_thumbnails(edges) do
    Enum.map(edges, fn edge ->
      %{"node" => %{"thumbnail_src" => thumbnail_src}} = edge
      thumbnail_src
    end)
  end

  defp combine_data(texts, thumbnails) do
    texts
    |> Enum.with_index()
    |> Enum.map(fn {_num, i} ->
      List.insert_at([], i, {Enum.at(texts, i), Enum.at(thumbnails, i)})
    end)
    |> List.flatten()
  end
end
