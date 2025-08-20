defmodule TmdbCal.WatchlistItemTest do
  use ExUnit.Case, async: true

  alias TmdbCal.WatchlistItem

  describe "new/1" do
    test "creates watchlist item from movie payload" do
      item = %{
        payload: %{
          "id" => 123,
          "title" => "Test Movie",
          "release_date" => "2023-05-15",
          "overview" => "A test movie synopsis"
        }
      }

      result = WatchlistItem.new(item)

      assert result.id == 123
      assert result.title == "Test Movie"
      assert result.release_date == "2023-05-15"
      assert result.first_air_date == nil
      assert result.synopsis == "A test movie synopsis"
    end

    test "creates watchlist item from TV payload" do
      item = %{
        payload: %{
          "id" => 456,
          "original_name" => "Test TV Show",
          "first_air_date" => "2023-03-10",
          "overview" => "A test TV show synopsis"
        }
      }

      result = WatchlistItem.new(item)

      assert result.id == 456
      assert result.title == "Test TV Show"
      assert result.release_date == nil
      assert result.first_air_date == "2023-03-10"
      assert result.synopsis == "A test TV show synopsis"
    end
  end

  describe "release_date/1" do
    test "returns formatted movie release date" do
      item = %WatchlistItem{
        id: 123,
        title: "Test Movie",
        release_date: "2023-05-15",
        first_air_date: nil,
        synopsis: "Synopsis"
      }

      result = WatchlistItem.release_date(item)

      assert result == "20230515"
    end

    test "returns formatted TV release date" do
      item = %WatchlistItem{
        id: 456,
        title: "Test TV Show",
        release_date: nil,
        first_air_date: "2023-03-10",
        synopsis: "Synopsis"
      }

      result = WatchlistItem.release_date(item)

      assert result == "20230310"
    end
  end

  describe "tmdb_url/1" do
    test "returns movie URL for movie items" do
      item = %WatchlistItem{
        id: 123,
        title: "Test Movie",
        release_date: "2023-05-15",
        first_air_date: nil,
        synopsis: "Synopsis"
      }

      result = WatchlistItem.tmdb_url(item)

      assert result == "https://www.themoviedb.org/movie/123"
    end

    test "returns TV show URL for TV items" do
      item = %WatchlistItem{
        id: 456,
        title: "Test TV Show",
        release_date: nil,
        first_air_date: "2023-03-10",
        synopsis: "Synopsis"
      }

      result = WatchlistItem.tmdb_url(item)

      assert result == "https://www.themoviedb.org/tv/456"
    end
  end

  describe "display_title/1" do
    test "returns display title with 'is airing' suffix" do
      item = %WatchlistItem{
        id: 123,
        title: "Breaking Bad",
        release_date: "2008-01-20",
        first_air_date: nil,
        synopsis: "A chemistry teacher turned meth cook"
      }

      result = WatchlistItem.display_title(item)

      assert result == "Breaking Bad is airing"
    end
  end
end
