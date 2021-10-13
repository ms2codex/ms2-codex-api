use Mix.Config

config :codex, CodexWeb.Endpoint,
  url: [host: "ms2db.bootando.com", port: 80],
  server: true

config :logger, level: :info

import_config "prod.secret.exs"
