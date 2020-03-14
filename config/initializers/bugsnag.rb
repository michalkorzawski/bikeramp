require 'bugsnag'

Bugsnag.configure do |config|
  config.api_key = ENV["BUGSNAG_API_KEY"]
  config.notify_release_stages = ENV["BUGSNAG_RELEASE_STAGE"].split(',').map(&:strip)
end
