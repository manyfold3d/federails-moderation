RSpec.describe Federails::Moderation::Report do
  let(:actor) { create :distant_actor }
  let(:object) { create :note }
  let(:report) { create :report, federails_actor: actor, object: object }

  it "is reported by an actor" do
    expect(report.federails_actor).to eq actor
  end

  it "is associated with a polymorphic object"  do
    expect(report.object).to eq object
  end

  it "has text content"  do
    expect(report.content).to be_present
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
