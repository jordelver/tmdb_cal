defmodule TmdbCal.WatchlistCalendar do
  alias TmdbCal.WatchlistItem
  require EEx

  @moduledoc """
  Responsible for returning a calendar of items on a watchlist.
  """

  @doc """
  Returns a watchlist calendar in iCal format.
  """
  def to_ics do
    TmdbCal.Watchlist.items |> ical()
  end

  EEx.function_from_file(:def, :ical,
    "lib/tmdb_cal/calendar_entry.eex", [:events], trim: true)
end
