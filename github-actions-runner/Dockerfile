FROM ghcr.io/actions/actions-runner:2.304.0

USER root

# install curl and jq
RUN apt-get update && apt-get install -y curl jq && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh
# Switch to user 'runner'
# Otherwise we get 'Must not run with sudo'
# USER runner

ENTRYPOINT ["./entrypoint.sh"]