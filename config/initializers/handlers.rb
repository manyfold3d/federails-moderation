require "fediverse/inbox"

Rails.application.config.after_initialize do
  Fediverse::Inbox.register_handler "Flag", "*", Federails::Moderation::Report, :handle_flag
end
