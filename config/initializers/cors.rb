# Restricting cors for sulmanbaig.com and localhost origins
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'localhost*', '127.0.0.1*', '*.sulmanbaig.com'
    resource '*', headers: :any, methods: [:get, :post, :options, :put, :delete, :patch], expose: %w[Authorization expiry]
  end
end