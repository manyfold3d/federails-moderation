require "fediverse/inbox"

class Federails::Moderation::Report
  def self.handle_flag(activity)
    Rails.logger.debug activity.inspect
  end
end

Fediverse::Inbox.register_handler "Flag", "*", Federails::Moderation::Report, :handle_flag
