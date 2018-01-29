# Load the Rails application.
require File.expand_path('../application', __FILE__)

DIGEST_REVISION = `/usr/bin/git log | grep '^commit' | wc -l`

if RAILS_ENV('EMAIL_FROM').nil? then
    EMAIL = 'muv-digest@tacid.cf'
    EMAIL_FROM = '"MUV Digest" <'+EMAIL+'>' unless defined? EMAIL_FROM
else
    EMAIL_FROM = RAILS_ENV('EMAIL_FROM')
end

# Initialize the Rails application.
Eotdigest::Application.initialize!
