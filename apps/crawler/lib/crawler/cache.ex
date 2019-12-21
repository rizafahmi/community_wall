defmodule Crawler.Cache do
  use GenServer

  def start_link(default) do
    GenServer.start_link(__MODULE__, default, name: CrawlerCache)
  end

  def init(state) do
    :ets.new(:content_cache, [:set, :public, :named_table])
    {:ok, state}
  end

  def delete(key) do
    GenServer.cast(CrawlerCache, {:delete, key})
  end

  def get(key) do
    GenServer.call(CrawlerCache, {:get, key})
  end

  def put(key, data) do
    GenServer.cast(CrawlerCache, {:put, key, data})
  end

  ### INTERNAL API
  def handle_call({:get, key}, _from, state) do
    reply =
      case :ets.lookup(:content_cache, key) do
        [] -> nil
        [{_key, value}] -> value
      end

    {:reply, reply, state}
  end

  def handle_cast({:delete, key}, state) do
    :ets.delete(:content_cache, key)
    {:noreply, state}
  end

  def handle_cast({:put, key, data}, state) do
    :ets.insert(:content_cache, {key, data})
    {:noreply, state}
  end
end
