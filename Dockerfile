FROM ruby:2.7.0

# Install system dependencies
RUN apt-get update -y && apt-get install -y \
  build-essential \
  libpq-dev \
  postgresql-client-11

# Setup app user, group and home directory
ENV APP_HOME='/bikeramp'

RUN groupadd -r --gid=999 app
RUN useradd -r -g app --uid=999 --home-dir="${APP_HOME}" --shell="/bin/bash" app
RUN mkdir -p "${APP_HOME}/src"
RUN chown -R app:app "${APP_HOME}"

USER app:app
WORKDIR ${APP_HOME}/src

# Install ruby dependencies
ENV BUNDLE_PATH="${APP_HOME}/bundle"
COPY --chown=app:app Gemfile Gemfile.lock ./
RUN bundle install --no-cache --jobs $(nproc)

# Add app code
COPY --chown=app:app . ./

ENTRYPOINT ["bundle", "exec"]
CMD ["rails", "server", "-b", "0.0.0.0"]
