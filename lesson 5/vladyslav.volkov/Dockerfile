FROM ruby:2.6.0

RUN gem install sinatra -v 2.1.0 && gem install pg -v 0.18.4 && gem install redis -v 4.2.2

EXPOSE 4567

COPY server.rb /app/

CMD ["ruby", "/app/server.rb"]
