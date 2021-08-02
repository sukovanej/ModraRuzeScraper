FROM haskell:8.10.4 as dependencies

WORKDIR /app

COPY stack.yaml package.yaml stack.yaml.lock ModraRuzeScraper.cabal ./
RUN stack build --system-ghc --dependencies-only

FROM haskell:8.10.4 as build

COPY --from=dependencies /root/.stack /root/.stack

WORKDIR /app
COPY . /app

RUN stack build --copy-bins

CMD ["ModraRuzeScraper-exe", "--notify-slack", "--api"]