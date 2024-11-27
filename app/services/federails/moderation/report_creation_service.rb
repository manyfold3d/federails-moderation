module Federails::Moderation
  class ReportCreationService < ApplicationService
    def initialize(activity)
      @activity = activity
    end

    def call
      Report.create!(
        federated_url: @activity["id"],
        content: @activity["content"]
      )
    end
  end
end
