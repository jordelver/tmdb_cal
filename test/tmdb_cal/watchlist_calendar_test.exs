defmodule TmdbCal.WatchlistCalendarTest do
  use TmdbCal.DataCase, async: true
  import TmdbCal.Fixtures

  describe ".to_ics" do
    test "renders ical compatible content" do
      _movie_item = watchlist_item_fixture(%{
        payload: %{
          "adult" => false,
          "backdrop_path" => "/kyqM6padQzZ1eYxv84i9smNvZAG.jpg",
          "genre_ids" => [27, 9648],
          "id" => 1078605,
          "original_language" => "en",
          "original_title" => "Weapons",
          "overview" => "When all but one child from the same class mysteriously vanish on the same night at exactly the same time, a community is left questioning who or what is behind their disappearance.",
          "popularity" => 249.1853,
          "poster_path" => "/cpf7vsRZ0MYRQcnLWteD5jK9ymT.jpg",
          "release_date" => "2025-08-06",
          "title" => "Weapons",
          "video" => false,
          "vote_average" => 7.8,
          "vote_count" => 200
        }
      })

      _tv_item = watchlist_item_fixture(%{
        payload: %{
          "adult" => false,
          "backdrop_path" => "/25g7mthXoJFcNZhAKz0evk17Bsx.jpg",
          "first_air_date" => "2025-08-12",
          "genre_ids" => [18, 10765],
          "id" => 157239,
          "name" => "Alien: Earth",
          "origin_country" => ["US"],
          "original_language" => "en",
          "original_name" => "Alien: Earth",
          "overview" => "When the mysterious deep space research vessel USCSS Maginot crash-lands on Earth, Wendy and a ragtag group of tactical soldiers make a fateful discovery that puts them face-to-face with the planet's greatest threat.",
          "popularity" => 29.2277,
          "poster_path" => "/oNWaBgCDqACEP6SHLpjOUJiYLDw.jpg",
          "vote_average" => 8.75,
          "vote_count" => 8
        }
      })

      actual = TmdbCal.WatchlistCalendar.to_ics()

      expected = """
      BEGIN:VCALENDAR
      CALSCALE:GREGORIAN
      VERSION:2.0
      PRODID:-//Elixir ICalendar//tmdb_cal//EN
      BEGIN:VEVENT
      DESCRIPTION:https://www.themoviedb.org/movie/1078605
      DTEND:20250806T000000Z
      DTSTART:20250806T000000Z
      SUMMARY:Weapons is airing
      UID:1078605
      END:VEVENT
      BEGIN:VEVENT
      DESCRIPTION:https://www.themoviedb.org/tv/157239
      DTEND:20250812T000000Z
      DTSTART:20250812T000000Z
      SUMMARY:Alien: Earth is airing
      UID:157239
      END:VEVENT
      END:VCALENDAR
      """

      assert expected =~ actual
    end
  end
end
