RSpec.describe "Reports" do
  let(:actor) { Federails::Actor.create }
  let(:report_body) {
    <<-EOF
      {
      "@context":"https://www.w3.org/ns/activitystreams",
        "id":"https://mastodon.me.uk/d977f377-214b-4efd-8a47-70a37fb7ea20",
        "type":"Flag",
        "actor":"https://mastodon.me.uk/actor",
        "content":"Test, please ignore",
        "object":[
          "https://example.com/models/abc123"
        ]
      }
    EOF
  }

  it "should call registered Report handler when a flag is received by Federails" do
    expect(Federails::Moderation::Report).to receive(:handle_flag).once.and_call_original
    post actor.inbox_url, params: report_body, headers: { content_type: "application/activity" }
  end
end
