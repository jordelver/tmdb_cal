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

    Enum.map(watchlist_items, &TmdbCal.WatchlistItem.new/1)
  end
end
