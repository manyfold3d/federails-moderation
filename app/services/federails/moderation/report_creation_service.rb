module Federails::Moderation
  class ReportCreationService < ApplicationService
    def initialize(activity)
      @activity = activity
      Rails.logger.info "Report recieved: #{@activity.inspect}"
    end

    def call
      Report.create!(
        federails_actor: Federails::Actor.find_or_create_by_federation_url(@activity["actor"]),
        federated_url: @activity["id"],
        content: @activity["content"]
      )
    end
  end
end
