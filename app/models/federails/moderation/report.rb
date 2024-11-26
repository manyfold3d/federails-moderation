class Federails::Moderation::Report
  def self.handle_flag(activity)
    Rails.logger.debug activity.inspect
  end
end
