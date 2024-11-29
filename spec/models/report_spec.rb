RSpec.describe Federails::Moderation::Report do
  context "with a complete report" do
    let(:actor) { create :distant_actor }
    let(:object) { create :note }
    let(:report) { create :report, federails_actor: actor, object: object }

    it "has a federation URL / activitypub ID" do
      expect(report.federated_url).to be_present
    end

    it "is reported by an actor" do
      expect(report.federails_actor).to eq actor
    end

    it "uses actor address as reporter address" do
      expect(report.reporter_address).to eq actor.at_address
    end

    it "is associated with a polymorphic object"  do
      expect(report.object).to eq object
    end

    it "has text content"  do
      expect(report.content).to be_present
    end

    it "gives actor address" do
      expect(report.reporter_address).to eq actor.at_address
    end

    it "can be resolved" do
      report.resolve!
      expect(report.resolution).to eq "resolved"
    end

    it "can be ignored" do
      report.ignore!
      expect(report.resolution).to eq "ignored"
    end

    it "stores resolution timestamp when resolved" do
      report.resolve!
      expect(report.resolved_at).to be_present
    end

    it "stores resolution timestamp when ignored" do
      report.ignore!
      expect(report.resolved_at).to be_present
    end
  end

  context "with an anonymous report" do
    let(:object) { create :note }
    let(:report) { create :report, federated_url: "https://example.com/id/1", federails_actor: nil, object: object }

    it "has no associated actor" do
      expect(report.federails_actor).to be_nil
    end

    it "uses ID domain as reporter address" do
      expect(report.reporter_address).to eq "example.com"
    end
  end
end
