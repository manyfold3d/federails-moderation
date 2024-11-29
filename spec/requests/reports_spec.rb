RSpec.describe "Reports" do
  let(:user) { create :user }
  let(:actor) { create :distant_actor }
  let(:valid_activity) { {
    "@context" => "https://www.w3.org/ns/activitystreams",
    "id" => "https://mastodon.me.uk/d977f377-214b-4efd-8a47-70a37fb7ea20",
    "type" => "Flag",
    "actor" => actor.federated_url,
    "content" => "I don't like spiders",
    "object" => [
      user.federails_actor.federated_url
    ]
  } }

  it "should accept Flag activities" do
    post user.federails_actor.inbox_url, params: valid_activity, as: :json
    expect(response.status).to eq 201
  end

  it "should call registered Report handler when a flag is received by Federails" do
    expect(Federails::Moderation::ReportCreationService).to receive(:call).once { |args|
      expect(args["content"]).to eq "I don't like spiders"
    }
    post user.federails_actor.inbox_url, params: valid_activity, as: :json
  end
end
