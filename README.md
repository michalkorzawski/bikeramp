# README

## Setup

1. create `.env` file based on `.env.template`

    ```sh
    cp .env.template .env
    ```
2. build

  `docker-compose build`

3. setup database

  `docker-compose run --rm web rails db:setup`

4. run

  `docker-compose up`

## Tests

  `docker-compose run --rm web rspec` to run rspec tests

## Code analyzer

  `docker-compose run --rm web rubocop` to run rubocop
  `docker-compose run --rm web rubocop -a` to run rubocop in the auto-correct mode

## Debugging
 
  You need to run rails server with ports expose to the host. It can by achieved by --service-ports flag.

  `docker-compose run --service-ports web`

  Now you can put `binding.pry` anywhere in the code. The code execution will stop in this point and you can then start “asking” questions like `params` or try to reach some variables etc.

## Deprecation warnings

  `RUBYOPT='-W:no-deprecated -W:no-experimental' + rails commands`

<!-- https://prathamesh.tech/2019/12/26/managing-warnings-emitted-by-ruby-2-7/ -->
<!-- https://blog.toshima.ru/2020/01/01/stop-emitting-warning-ruby27.html -->
