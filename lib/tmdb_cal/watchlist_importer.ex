defmodule TmdbCal.Watchlist.Importer do
  @moduledoc """
  Responsible for importing watchlist items from TMDB and persisting them the
  local database.
  """

  alias TmdbCal.{Repo, TMDBClient, Watchlist}

  def import do
    now = DateTime.truncate(DateTime.utc_now(), :second)

    items_to_insert =
      Enum.map(watchlist_items(), fn item ->
        %{
          payload: item,
          inserted_at: now,
          updated_at: now
        }
      end)

    Repo.transaction(fn ->
      Repo.delete_all(Watchlist.Schema)
      Repo.insert_all(Watchlist.Schema, items_to_insert)
    end)
  end

  defp watchlist_items do
    movies() ++ tv()
  end

  defp movies do
    case TMDBClient.get_watchlist_movies() do
      {:ok, %{"results" => results}} ->
        results
      {:error, _} ->
        []
    end
  end

  defp tv do
    case TMDBClient.get_watchlist_tv() do
      {:ok, %{"results" => results}} ->
        results
      {:error, _} ->
        []
    end
  end
end
