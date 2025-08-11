defmodule TmdbCal.WatchlistCalendar do
  @moduledoc """
  Responsible for returning a calendar of ???.
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
      summary: item.title,
      dtstart: format_date(item.release_date),
      dtend: format_date(item.release_date)
    }
  end

  defp format_date(date) do
    {:ok, date} = Date.from_iso8601(date)
    DateTime.new!(date, ~T[00:00:00], "Etc/UTC")
  end
end
