FROM elixir:1.14

RUN apt-get update && \
    apt-get install -y postgresql-client && \
    apt-get install -y inotify-tools && \
    mix local.hex --force && \
    mix local.rebar --force

ENV APP_HOME /app
WORKDIR $APP_HOME

COPY ./app/mix.exs ./app/mix.lock $APP_HOME/
RUN mix deps.get

COPY ./app $APP_HOME

RUN mix compile

EXPOSE 4000

CMD ["mix", "run", "--no-halt"]



# --------------------------------------------------------------------------------

# FROM elixir:1.14.1-alpine

# # Build Args
# ARG PHOENIX_VERSION=1.6.15

# # Apk
# RUN apk add bash git inotify-tools nodejs-current npm yarn

# # Phoenix
# RUN mix local.hex --force
# RUN mix archive.install --force hex phx_new #{PHOENIX_VERSION}
# RUN mix local.rebar --force

# # App Directory
# ENV APP_HOME /app
# RUN mkdir -p $APP_HOME
# WORKDIR $APP_HOME

# # App Port
# EXPOSE 4000

# # Default Command
# CMD ["mix", "phx.server"]


# --------------------------------------------------------------------------------

# FROM elixir

# RUN apt-get update && \
#     apt-get install -y postgresql-client && \
#     apt-get install -y inotify-tools && \
#     apt-get install -y nodejs && \
#     # curl -L https://npmjs.org/install.sh | sh && \
#     mix local.hex --force && \
#     mix archive.install hex phx_new 1.5.3 --force && \
#     mix local.rebar --force

# ENV APP_HOME /app
# RUN mkdir $APP_HOME
# WORKDIR $APP_HOME

# CMD ["mix", "phx.server"]
