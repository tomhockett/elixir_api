# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :elixir_api,
  ecto_repos: [ElixirApi.Repo],
  generators: [timestamp_type: :utc_datetime, binary_id: true]

# Configures the endpoint
config :elixir_api, ElixirApiWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [json: ElixirApiWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: ElixirApi.PubSub,
  live_view: [signing_salt: "ZYn4RmXw"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :elixir_api, ElixirApiWeb.Auth.Guardian,
  issuer: "elixir_api",
  secret_key: "#{GUARDIAN_SECRET_KEY}"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :guardian, Guardian.DB,
  # Add your repository module
  repo: ElixirApi.Repo,
  # default
  schema_name: "guardian_tokens",
  # default: 60 minutes
  sweep_interval: 60

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
