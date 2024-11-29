module Federails::Moderation
  class ReportCreationService < ApplicationService
    def initialize(activity)
      @activity = activity
      Rails.logger.info "Report recieved: #{@activity.inspect}"
    end

    def call
      Report.create!(
        federails_actor: find_reporter,
        federated_url: @activity["id"],
        content: @activity["content"]
      )
    end

    private

    def find_reporter
      Federails::Actor.find_or_create_by_federation_url(@activity["actor"])
    rescue ActiveRecord::RecordInvalid, URI::InvalidURIError
      # Anonymous reports will try to create invalid actors, so we end up here
      nil
    end
  end
end
