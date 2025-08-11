defmodule TmdbCal.Repo.Migrations.CreateWatchlist do
  use Ecto.Migration

  def change do
    create table(:watchlist, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :payload, :map

      timestamps(type: :utc_datetime)
    end
  end
end
