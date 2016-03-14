#!/bin/sh
git pull
 RETVAL=$? && [ $RETVAL -eq 0 ] || exit $RETVAL
env RAILS_ENV=production bundle update
 RETVAL=$? && [ $RETVAL -eq 0 ] || exit $RETVAL
env RAILS_ENV=production bundle exec rake db:migrate
 RETVAL=$? && [ $RETVAL -eq 0 ] || exit $RETVAL
./generate_secret.sh
./precompile.sh
touch tmp/restart.txt

