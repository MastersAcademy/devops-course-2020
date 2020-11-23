FROM ruby:2.6.0
RUN gem install sinatra:2.1.0 pg:0.18.4 redis:4.2.2
RUN wget https://raw.githubusercontent.com/adm-crc/devops-course-2020/master/lesson%205/server.rb
CMD ["ruby", "server.rb"]