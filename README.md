# CommunityWall 🧱

Social media feeds for events and digital displays! You can display this app while waiting people to come, between sessions and after party 🎉

Community wall helps you, community leader to display Instagram images, Tweets (coming soon) on any digital service to increase engagement and drive conversions.

![](./communitywall.gif)

[View live demo of the app](https://communitywall.herokuapp.com/)

## Getting Started

### Prerequisite

You need Erlang and Elixir installed. And also Heroku account and Heroku Toolbelt

* Erlang version 22.0 or newer
* Elixir version 1.9.0 or newer
* Heroku Toolbelt version 7.35.1 or newer

### Installation

Clone the project.
```
$ git clone https://github.com/rizafahmi/community_wall.git
$ cd community_wall
```

Copy `.env.example` to `.env` and add some configuration such as below

```
export AUTO_REFRESH_MILISECONDS=50000
export HASHTAG=devcjakarta
```

Source it to export all variables into your environment variable.

```
$ source .env
```

Run the web 🕸️.

```
$ cd apps/wall_web
$ mix phx.server
$ open http://localhost:4000
```

Done! 🎉🎉🎉

## Deployment

You can deploy using any VM service such as [Digital Ocean](https://m.do.co/c/ccb8fe03d9f6), [AWS EC2](https://aws.amazon.com/ec2/), [GCP Compute Engine](https://cloud.google.com/compute/), or others.

I used PaaS [Heroku](https://heroku.com) to deploy [the demo app](https://communitywall.herokuapp.com). So I will guide you to use Heroku. Please help me create guide for other platform.

### Heroku

You can easily follow guide provided by [phoenix framework](https://hexdocs.pm/phoenix/heroku.html#content) with small difference because we use [Elixir Umbrella Project](https://elixir-lang.org/getting-started/mix-otp/dependencies-and-umbrella-projects.html). Everything already provided over [here](./phoenix_static_buildpack.config) and [Procfile](./Procfile)

#### Creating Heroku Application

Make sure you already have Heroku account and Heroku Toolbelt installed. We will use latest published [ buildpack for Elixir ](https://github.com/HashNuke/heroku-buildpack-elixir).

```
$ heroku create --buildpack hashnuke/elixir
Creating app... done, ⬢ mysterious-meadow-6277
Setting buildpack to hashnuke/elixir... done
https://mysterious-meadow-6277.herokuapp.com/ | https://git.heroku.com/mysterious-meadow-6277.git
```
> Note: the name of the Heroku application is the random string after "Creating" in the output above (mysterious-meadow-6277). This will be unique, so expect to see a different name from "mysterious-meadow-6277".


#### Adding the Phoenix Static Buildpack

We need to compile static assets for a successful Phoenix deployment. The [ Phoenix static buildpack ](https://github.com/gjaldon/heroku-buildpack-phoenix-static) can take care of that for us, so let's add it now.

```
$ heroku buildpacks:add https://github.com/gjaldon/heroku-buildpack-phoenix-static.git
Buildpack added. Next release on mysterious-meadow-6277 will use:
  1. https://github.com/HashNuke/heroku-buildpack-elixir.git
  2. https://github.com/gjaldon/heroku-buildpack-phoenix-static.git
```

We use this configuration: [ phoenix_static_buildpack.config ](./phoenix_static_buildpack.config).

And we use [Procfile](./Procfile).

```
web: cd apps/wall_web && MIX_ENV=prod mix phx.server
```

#### Configuration for Heroku

Tell phoenix to use Heroku URL and enforce SSL in `config/prod.exs`:

```
url: [scheme: "https", host: "communitywall.herokuapp.com", port: 443],
force_ssl: [rewrite_on: [:x_forwarded_proto]]

```

#### Add Environment Variables in Heroku

You can add env variables using Heroku Toolbelt or via Heroku Web Dashboard. We need to create `SECRET_KEY_BASE` config based on random string. We can generate using `mix phx.gen.secret`.

```
$ cd apps/wall_web/
$ mix phx.gen.secret
xvafzY4y01jYuzLm3ecJqo008dVnU3CN4f+MamNd1Zue4pXvfvUjbiXT8akaIF53
```

Copy that and set it in Heroku

```
$ heroku config:set SECRET_KEY_BASE="xvafzY4y01jYuzLm3ecJqo008dVnU3CN4f+MamNd1Zue4pXvfvUjbiXT8akaIF53"
Setting config vars and restarting mysterious-meadow-6277... done, v3
SECRET_KEY_BASE: xvafzY4y01jYuzLm3ecJqo008dVnU3CN4f+MamNd1Zue4pXvfvUjbiXT8akaIF53
```

Then you have to set two env variables needed for the app: `AUTO_REFRESH_MILISECONDS` and `HASHTAG` as seen as in [.env.example](./.env.example).

```
$ heroku config:set AUTO_REFRESH_MILISECONDS=50000
$ heroku config:set HASHTAG=devcjakarta
```

### Deployment Time

Commit all our changes.

```
$ git add config/prod.exs
$ git add elixir_buildpack.config
$ git add phoenix_static_buildpack.config
$ git commit -m "Use production config from Heroku ENV variables"
```

And deploy!

```
$ git push heroku master
```

## Build With

* [Elixir](https://elixir-lang.org)
* [Phoenix](http://www.phoenixframework.org)
* [Tailwind CSS](https://tailwindcss.com)
* [Purge CSS](https://www.purgecss.com)
* JavaScript

## Contributing

Please send me some [ issues ](https://github.com/rizafahmi/community_wall/issues), or even better [ some PR ](https://github.com/rizafahmi/community_wall/pulls)! This project is a long way from finish. We need your contributions.

For starter, this app still using traditional request response application. If you want to build client side app, and can commit your time, just let me know. I'll create the backend API.

## License

This project is licensed under an MIT License - see the [LICENSE.md](./LICENSE.md) file for details.

## Donation

* [ PayPal ](https://www.paypal.com/paypalme2/rizafahmi)
* [ KaryaKarsa ](https://karyakarsa.com/rizafahmi/) (For 🇮🇩 Indonesia only)
