defmodule TmdbCalWeb.PageController do
  use TmdbCalWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
