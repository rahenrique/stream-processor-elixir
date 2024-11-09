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
