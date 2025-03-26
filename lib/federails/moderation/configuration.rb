module Federails::Moderation
  # rubocop:disable Style/ClassVars

  # Stores the Federails::Moderation configuration in a _singleton_.
  module Configuration
    # A proc that is called any time new report is created
    # Useful for sending notifications
    mattr_accessor :on_report_created
    @@on_report_received = nil
  end
  # rubocop:enable Style/ClassVars
end
