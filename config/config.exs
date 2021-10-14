# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :codex,
  ecto_repos: [Codex.Repo]

# Configures the endpoint
config :codex, CodexWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kAEcZZLsrSpsDwSxrU1OpqnOacGOwHNT3cLu3VSt/czTGvV5OM5R8tbOr93CtH66",
  render_errors: [view: CodexWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Codex.PubSub,
  live_view: [signing_salt: "wPbI7SSO"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :cors_plug,
  methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
