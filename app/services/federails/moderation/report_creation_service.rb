module Federails::Moderation
  class ReportCreationService < ApplicationService
    def initialize(activity)
      @activity = activity
    end

    def call
      Rails.logger.debug @activity.inspect
    end
  end
end
