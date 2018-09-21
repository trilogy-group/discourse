# Dockerization of Discourse
## What is discourse?
Discourse is the 100% open source discussion platform built for the next decade of the Internet. Use it as a:

- mailing list
- discussion forum
- long-form chat room

To learn more about the philosophy and goals of the project, [visit **discourse.org**](http://www.discourse.org).

## [Discourse Repository](https://github.com/trilogy-group/discourse)
For the purpose of Dockerization a fork of the current repository. Is being used and following files have been change to represent the configuration of servers needed to run the discource development enviornment. The forked repository is not available at 

https://github.com/trilogy-group/discourse

The original repo from which this repo has been forked is present at https://github.com/discourse/discourse

## Using the Artifacts / files in the repository

### Docker Requirements
 1. Docker version 18.06.1-ce
 2. Docker compose version 1.22.0

### Version of container dependencies used
1. [Ruby 2.5.1](https://github.com/docker-library/ruby/blob/38e06eaab48f587fca9993a6c7124a11512ac65c/2.5/stretch/Dockerfile)
2. [Redis 4.0.11](https://github.com/docker-library/redis/blob/7900c5d31e0b3a4c463c57a8d69cc497d58fbe70/4.0/Dockerfile)
3. [postgres 10](https://github.com/docker-library/postgres/blob/3f585c58df93e93b730c09a13e8904b96fa20c58/10/Dockerfile)

## Building the docker development environment
`docker-compose build`

## Debugging the Product
`docker-compose up`

You can see the mail catcher at localhost:1080

You can see the discord app running at localhost:3000

`Do Some code changes`
