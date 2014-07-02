#!/bin/sh
cd `dirname $0`
env RAILS_ENV=production bundle exec rake assets:precompile
