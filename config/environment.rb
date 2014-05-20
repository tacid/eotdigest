# Load the Rails application.
require File.expand_path('../application', __FILE__)

DIGEST_REVISION = `git shortlog -s | awk '{sum+=$1}  END {print sum}'`

# Initialize the Rails application.
Eotdigest::Application.initialize!
