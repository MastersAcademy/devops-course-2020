FROM ruby:4.6.0
RUN apt-get update
RUN gem install sinatra -v '~> 2.1.0'
RUN gem install pg -v '~> 0.18.4'
RUN gem install redis -v '~> 4.2.2'
COPY . .
CMD ["ruby", "server.rb"]