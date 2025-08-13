defmodule TmdbCal.WatchlistCalendar do
  alias TmdbCal.WatchlistItem

  @moduledoc """
  Responsible for returning a calendar of items on a watchlist.
  """

  @doc """
  Returns a watchlist calendar in iCal format.
  """
  def to_ics do
    events = Enum.map(TmdbCal.Watchlist.items, &create_event_from_item/1)

    calendar = %ICalendar{events: events}

    ICalendar.to_ics(calendar, vendor: "tmdb_cal")
  end

  defp create_event_from_item(item) do
    %ICalendar.Event{
      uid: item.id,
      summary: WatchlistItem.display_title(item),
      description: WatchlistItem.tmdb_url(item),
      dtstart: WatchlistItem.release_date(item),
      dtend: WatchlistItem.release_date(item)
    }
  end
end
