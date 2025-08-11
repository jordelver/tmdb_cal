defmodule TmdbCalWeb.CalendarController do
  @moduledoc """
  Controller for serving calendar data.

  This controller handles requests for calendar exports, specifically
  providing watchlist data in iCalendar format.
  """

  use TmdbCalWeb, :controller

  @doc """
  Serves the watchlist calendar in iCalendar format.

  Returns the calendar data with appropriate content type headers
  for calendar applications to consume.
  """
  def index(conn, _params) do
    ical_content = TmdbCal.WatchlistCalendar.to_ics()

    conn
    |> put_resp_content_type("text/calendar")
    |> send_resp(200, ical_content)
  end
end
