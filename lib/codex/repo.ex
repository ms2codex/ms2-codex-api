defmodule Codex.Repo do
  use Ecto.Repo,
    otp_app: :codex,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 20
end
