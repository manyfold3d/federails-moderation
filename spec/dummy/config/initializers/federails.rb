# frozen_string_literal: true

Federails.configure do |conf|
  conf.app_name = "Dummy"
  conf.app_version = "0.1"

  conf.site_host = "localhost"
  conf.site_port = "3000"
  conf.force_ssl = false

  conf.enable_discovery = true
  conf.open_registrations = true
  conf.server_routes_path = "federation"
  conf.client_routes_path = nil
end
