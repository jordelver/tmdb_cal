defmodule TmdbCal.Repo do
  use Ecto.Repo,
    otp_app: :tmdb_cal,
    adapter: Ecto.Adapters.SQLite3
end
