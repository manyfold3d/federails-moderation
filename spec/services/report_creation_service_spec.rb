RSpec.describe Federails::Moderation::ReportCreationService do
  let(:object) { create :user }
  let(:actor) { create :distant_actor }
  let(:valid_activity) { {
    "@context" => "https://www.w3.org/ns/activitystreams",
    "id" => "https://mastodon.me.uk/d977f377-214b-4efd-8a47-70a37fb7ea20",
    "type" => "Flag",
    "actor" => actor.federated_url,
    "content" => "I don't like spiders",
    "object" => [
      object.federails_actor.federated_url
    ]
  } }

  it "should create a new Report when passed a valid activity" do
    expect { described_class.call(valid_activity) }.to change(Federails::Moderation::Report, :count).by(1)
  end

  context "when creating a new report" do
    let(:report) { described_class.call(valid_activity) }

    it "stores activity content in new report" do
      expect(report.content).to eq "I don't like spiders"
    end

    it "stores activity id in new report" do
      expect(report.federated_url).to eq "https://mastodon.me.uk/d977f377-214b-4efd-8a47-70a37fb7ea20"
    end
  end
end
