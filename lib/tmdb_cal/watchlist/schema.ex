defmodule TmdbCal.Watchlist.Schema do
  @moduledoc """
  Database schema for storing watchlist items.

  This schema defines the structure for persisting TMDB watchlist data
  in the database. Each record stores the raw JSON payload from TMDB
  along with timestamps for tracking when items were added or updated.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "watchlist" do
    field :payload, :map

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:payload])
    |> validate_required([:payload])
  end
end
