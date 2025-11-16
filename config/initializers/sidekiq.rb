require "sidekiq"
require "openssl"

Sidekiq.configure_server do |config|
  redis_url = ENV['REDIS_URL'] || ENV['REDIS_TLS_URL'] || "redis://localhost:6379"

  config.redis = {
    url: redis_url,
    ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }
  }
end

Sidekiq.configure_client do |config|
  redis_url = ENV['REDIS_URL'] || ENV['REDIS_TLS_URL'] || "redis://localhost:6379"

  config.redis = {
    url: redis_url,
    ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }
  }
end
