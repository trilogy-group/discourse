FROM ruby:2.5.1

RUN mkdir -p /data
COPY Gemfile Gemfile.lock /data/
WORKDIR /data

RUN gem install bundler &&\
    bundle install --jobs 20 --retry 5

RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main' >  /etc/apt/sources.list.d/pgdg.list &&\
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - &&\
    apt-get update &&\
    yes Y | apt-get install postgresql-client-10

RUN apt-get -yqq install \
    vim curl expect debconf-utils git-core build-essential zlib1g-dev libssl-dev \
    openssl libcurl4-openssl-dev libreadline6-dev libpcre3 libpcre3-dev imagemagick \
    gifsicle jhead jpegoptim \
    libjpeg-turbo-progs optipng pngcrush pngquant gnupg2 \
    software-properties-common

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - &&\
    apt-get install -y nodejs &&\
    npm install -g svgo

EXPOSE 3000 1080 1025

WORKDIR /

# Install mail catcher server
RUN gem install mailcatcher

# Starts the Development Server
RUN touch start.sh &&\
    chmod 777 start.sh &&\
    echo "if [ -x setup.sh ]; then ./setup.sh; rm setup.sh; else echo setup already complete; fi" >> start.sh &&\
    echo "mailcatcher --ip=0.0.0.0" >> start.sh &&\
    echo "cd /data" >> start.sh &&\
    echo "bundle exec unicorn -c config/unicorn.conf.rb" >> start.sh &&\
    echo "cd .." >> start.sh

# Sets up the development enviornment for first time use
RUN touch setup.sh &&\
    chmod 777 setup.sh &&\
    echo "cd /data" >> setup.sh &&\
    echo "bundle exec rake db:create" >> setup.sh &&\
    echo "bundle exec rake db:migrate" >> setup.sh &&\
    echo "echo *** setup complete ***" >> setup.sh &&\
    echo "cd .." >> setup.sh

CMD ./start.sh
