defmodule TmdbCal.WatchlistItem do
  @moduledoc """
  Represents a single watchlist item from TMDB.

  This struct contains the essential information about a movie or TV show
  from the user's watchlist, including its ID, title, release date, and synopsis.
  """

  defstruct [:id, :title, :release_date, :synopsis]
end

defmodule TmdbCal.Watchlist do
  @moduledoc """
  Provides functions for working with watchlist data.

  This module handles the retrieval and transformation of watchlist items
  from the database into structured `TmdbCal.WatchlistItem` structs.
  """

  alias TmdbCal.Repo

  @doc """
  Returns all watchlist items as structured `TmdbCal.WatchlistItem` structs.

  Fetches all stored watchlist data from the database and transforms
  it into a list of `TmdbCal.WatchlistItem` structs with standardized fields.
  """
  def items do
    watchlist_items = Repo.all(TmdbCal.Watchlist.Schema)

    Enum.map(watchlist_items, fn item ->
      %TmdbCal.WatchlistItem{
        id: item.payload["id"],
        title: item.payload["title"] || item.payload["original_name"],
        release_date: item.payload["release_date"] || item.payload["first_air_date"],
        synopsis: item.payload["overview"]
      }
    end)
  end
end
