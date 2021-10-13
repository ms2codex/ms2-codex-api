use Mix.Config

config :codex, Codex.Repo,
  username: "ms2db",
  password: "d10l4dr0",
  database: "ms2db",
  hostname: "localhost",
  pool_size: 10

config :codex, CodexWeb.Endpoint,
  http: [ip: {:local, "/var/www/apps/ms2db/tmp/ms2db.sock"}, port: 0]
