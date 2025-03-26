RSpec.describe Federails::Moderation::ReportCreationService do
  let(:object) { create(:user).federails_actor }
  let(:actor) { create :distant_actor }
  let(:valid_activity) { {
    "@context" => "https://www.w3.org/ns/activitystreams",
    "id" => "https://mastodon.me.uk/d977f377-214b-4efd-8a47-70a37fb7ea20",
    "type" => "Flag",
    "actor" => actor.federated_url,
    "content" => "I don't like spiders",
    "object" => [
      object.federated_url,
      "https://localhost/unknown/object"
    ]
  } }

  it "should create a new Report when passed a valid activity" do
    expect { described_class.call(valid_activity) }.to change(Federails::Moderation::Report, :count).by(1)
  end

  it "should execute callback when a new Report is created" do
    callback = double("callback", call: nil)
    Federails::Moderation.configure { |conf| conf.after_report_created = callback }
    described_class.call(valid_activity)
    expect(callback).to have_received(:call).once
    Federails::Moderation.configure { |conf| conf.after_report_created = nil }
  end

  context "when creating a new report" do
    let(:report) { described_class.call(valid_activity) }

    it "stores activity content in new report" do
      expect(report.content).to eq "I don't like spiders"
    end

    it "stores activity id in new report" do
      expect(report.federated_url).to eq "https://mastodon.me.uk/d977f377-214b-4efd-8a47-70a37fb7ea20"
    end

    it "associates report with actor" do
      expect(report.federails_actor).to eq actor
    end

    it "associates report with object" do
      expect(report.object).to eq object
    end
  end

  context "with anonymous report" do
    let(:anonymous_activity) { valid_activity.except("actor") }
    let(:report) { described_class.call(anonymous_activity) }

    it "creates valid report" do
      expect(report).to be_valid
    end

    it "does not associate an actor" do
      expect(report.federails_actor).to be_nil
    end
  end
end
