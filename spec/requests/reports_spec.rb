RSpec.describe "Reports" do
  let(:user) { create :user }
  let(:report_body) { {
    "@context": "https://www.w3.org/ns/activitystreams",
    "id": "https://mastodon.me.uk/d977f377-214b-4efd-8a47-70a37fb7ea20",
    "type": "Flag",
    "actor": "https://mastodon.me.uk/actor",
    "content": "Test, please ignore",
    "object": [
      "https://example.com/models/abc123"
    ]
  } }

  it "should accept Flag activities" do
    post user.actor.inbox_url, params: report_body, as: :json
    expect(response.status).to eq 201
  end

  it "should call registered Report handler when a flag is received by Federails" do
    expect(Federails::Moderation::ReportCreationService).to receive(:call).once { |args|
      expect(args["content"]).to eq "Test, please ignore"
    }
    post user.actor.inbox_url, params: report_body, as: :json
  end
end
