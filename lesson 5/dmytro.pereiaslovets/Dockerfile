FROM ruby:2.6.0
RUN gem install sinatra:2.1.0 pg:0.18.4 redis:4.2.2
WORKDIR /usr/src/app
COPY server.rb .
CMD ["ruby", "server.rb"]
