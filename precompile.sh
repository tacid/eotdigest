#!/bin/sh
cd `dirname $0`
env RAILS_ENV=production /usr/local/bin/bundle exec rake assets:precompile
