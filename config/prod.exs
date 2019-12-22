use Mix.Config

config :wall_web, WallWeb.Endpoint,
  url: [schema: "https", host: "communitywall.herokuapp.com", port: 443],
  cache_static_manifest: "priv/static/cache_manifest.json",
  force_ssl: [rewrite_on: [:x_forwarded_proto]]
