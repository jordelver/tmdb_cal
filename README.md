# `tmdb_cal`

`tmdb_cal` is a tool to produce an [iCalendar] compatible feed from your [TMDB]
watchlist to which you can subscribe. It imports your watchlist from TMDB and
outputs a suitable `.ics` file.

## Development

To start your Phoenix server:

* Run `mix setup` to install and setup dependencies
* Setup your environment variables as detailed below
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Environment variables

Locally, the values from `.envrc` are used using [`direnv`]. A sample file is
available at `.envrc-sample`.

## Deployment

Deploy with `fly deploy`.

The following environment variables are required to be set on production.

- `PHX_HOST`
- `SECRET_KEY_BASE`
- `TMDB_ACCOUNT_ID`
- `TMDB_API_TOKEN`

## Remote shell on Fly

    fly ssh console --pty -C "/app/bin/tmdb_cal remote"

**NOTE:** Run `fly ssh issue --agent` before first run to setup SSH access.

[`direnv`]: https://direnv.net/
[iCalendar]: https://en.wikipedia.org/wiki/ICalendar
[TMDB]: https://www.themoviedb.org/
