use Mix.Config

config :wall_web, WallWeb.Endpoint,
  http: [port: {:system, "PORT"}],
  load_from_system_env: true,
  url: [scheme: "https", host: "communitywall.herokuapp.com", port: 443],
  cache_static_manifest: "priv/static/cache_manifest.json",
  secret_key_base: Map.fetch!(System.get_env(), "SECRET_KEY_BASE"),
  force_ssl: [rewrite_on: [:x_forwarded_proto]]
