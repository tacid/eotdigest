# Load the Rails application.
require File.expand_path('../application', __FILE__)

DIGEST_REVISION = `git log | grep '^commit' | wc -l`

# Initialize the Rails application.
Eotdigest::Application.initialize!
