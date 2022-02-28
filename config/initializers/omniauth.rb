Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '', ''
end

OmniAuth.config.allowed_request_methods = %i[get]
