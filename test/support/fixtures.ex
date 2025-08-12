defmodule TmdbCal.Fixtures do
  alias TmdbCal.Watchlist

  def watchlist_item_fixture(attrs \\ %{}) do
    default_attrs = %{
      payload: %{}
    }

    attrs = Map.merge(default_attrs, attrs)

    %Watchlist.Schema{}
    |> Watchlist.Schema.changeset(attrs)
    |> TmdbCal.Repo.insert!
  end
end
