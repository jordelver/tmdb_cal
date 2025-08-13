defmodule TmdbCal.WatchlistItem do
  @moduledoc """
  Represents a single watchlist item from TMDB.

  This struct contains the essential information about a movie or TV show
  from the user's watchlist, including its ID, title, release date, and synopsis.
  """

  defstruct [:id, :title, :release_date, :first_air_date, :synopsis]

  @doc """
  Creates a new `WatchlistItem` struct from database item attributes.
  """
  def new(item) do
    %__MODULE__{
      id: item.payload["id"],
      title: item.payload["title"] || item.payload["original_name"],
      release_date: item.payload["release_date"],
      first_air_date: item.payload["first_air_date"],
      synopsis: item.payload["overview"]
    }
  end

  @doc """
  Returns the release date for this TV show or movie item
  """
  def release_date(%__MODULE__{release_date: release_date, first_air_date: first_air_date}) do
    date = release_date || first_air_date
    {:ok, date} = Date.from_iso8601(date)
    DateTime.new!(date, ~T[00:00:00], "Etc/UTC")
  end

  @doc """
  Returns the TMDB URL for this TV show or movie item
  """
  def tmdb_url(%__MODULE__{id: id} = item) do
    base_url = "https://www.themoviedb.org"
    if tv_show?(item) do
      base_url <> "/tv/#{id}"
    else
      base_url <> "/movie/#{id}"
    end
  end

  defp tv_show?(%__MODULE__{first_air_date: nil}), do: false
  defp tv_show?(%__MODULE__{first_air_date: _}), do: true

  @doc """
  Returns a display title.
  """
  def display_title(%__MODULE__{title: title}) do
    "#{title} is airing"
  end
end

