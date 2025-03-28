# Dockerfile development version
FROM ruby:3.3.4-alpine AS easy_login-development

RUN apk -U upgrade && apk add --no-cache curl build-base tzdata bash gcompat git yaml-dev

WORKDIR /opt/app

COPY Gemfile Gemfile.lock ./

ENV LANG=C.UTF-8 \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3 \
    BUNDLE_PATH="/usr/local/bundle"

RUN rm -rf node_modules vendor && \
    gem install bundler && \
    bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

COPY . .

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["/usr/bin/entrypoint.sh"]

RUN adduser easy_login --disabled-password --shell /bin/bash && \
    chown -R easy_login:easy_login log tmp
USER easy_login

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
