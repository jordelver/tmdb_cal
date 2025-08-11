defmodule TmdbCal.TMDBClient do
  @moduledoc """
  Client for interacting with TMDB API.

  This module provides functions to fetch watchlist data from TMDB,
  including movies and TV shows. It handles authentication and
  request/response processing.
  """

  @doc """
  Retrieves movies from the user's TMDB watchlist.

  Returns a tuple with `:ok` and the response body on success,
  or `:error` with failure details on error.
  """
  def get_watchlist_movies do
    params = %{
      "language" => "en-US",
      "page" => 1,
      "sort_by" => "created_at.asc"
    }

    case Req.get(url("/watchlist/movies"), params: params, headers: headers()) do
      {:ok, %Req.Response{status: 200, body: body}} ->
        {:ok, body}
      {:ok, %Req.Response{status: status, body: body}} ->
        {:error, {status, body}}
      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Retrieves TV shows from the user's TMDB watchlist.

  Returns a tuple with `:ok` and the response body on success,
  or `:error` with failure details on error.
  """
  def get_watchlist_tv do
    params = %{
      "language" => "en-US",
      "page" => 1,
      "sort_by" => "created_at.asc"
    }

    case Req.get(url("/watchlist/tv"), params: params, headers: headers()) do
      {:ok, %Req.Response{status: 200, body: body}} ->
        {:ok, body}
      {:ok, %Req.Response{status: status, body: body}} ->
        {:error, {status, body}}
      {:error, reason} ->
        {:error, reason}
    end
  end

  defp url(endpoint), do: "#{base_url()}#{endpoint}"

  @doc """
  Returns the base URL for TMDB API requests.
  """
  def base_url do
    "https://api.themoviedb.org/3/account/#{tmdb_account_id()}"
  end

  @doc """
  Returns the headers required for TMDB API authentication.
  """
  def headers do
    [
      {"Authorization", bearer_token()},
      {"accept", "application/json"}
    ]
  end

  defp bearer_token, do: "Bearer #{tmdb_api_token()}"

  defp tmdb_account_id, do: Application.get_env(:tmdb_cal, :tmdb_account_id)

  defp tmdb_api_token, do: Application.get_env(:tmdb_cal, :tmdb_api_token)
end
