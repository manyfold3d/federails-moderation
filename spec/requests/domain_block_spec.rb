RSpec.describe Federails::Moderation::DomainBlock do
  let(:actor) { FactoryBot.create(:user).federails_actor }

  context 'with a blocked domain' do
    before do
      described_class.create(domain: "blocked.com")
    end

    it 'allows non-matching activities' do
      payload = { "id" => "https://allowed.com/abc1234" }
      expect(Fediverse::Inbox).to receive(:filtered_dispatch_request).with(payload)
      Fediverse::Inbox.dispatch_request(payload)
    end

    it 'rejects activities with matching IDs' do
      payload = { "id" => "https://blocked.com/abc1234" }
      expect(Fediverse::Inbox).not_to receive(:filtered_dispatch_request)
      Fediverse::Inbox.dispatch_request(payload)
    end

    it 'rejects activities with subdomain-matching IDs' do
      payload = { "id" => "https://www.blocked.com/abc1234" }
      expect(Fediverse::Inbox).not_to receive(:filtered_dispatch_request)
      Fediverse::Inbox.dispatch_request(payload)
    end

    it 'rejects activities with matching actors' do
      payload = { "actor" => "https://blocked.com/users/abc1234" }
      expect(Fediverse::Inbox).not_to receive(:filtered_dispatch_request)
      Fediverse::Inbox.dispatch_request(payload)
    end
  end

  context "when delivering" do
    FakeActivity = Struct.new :id, :actor, :recipients, :action, :entity, keyword_init: true

    let(:local_actor) { FactoryBot.create(:user).federails_actor }
    let(:distant_target_actor) { FactoryBot.create :distant_actor }
    let(:activity) { FakeActivity.new(actor: local_actor, recipients: [ distant_target_actor ]) }

    before do
      allow(Fediverse::Notifier).to receive(:payload).and_return("message")
    end

    it 'allows delivery to non-blocked domains' do
      expect(Fediverse::Notifier).to receive(:filtered_post_to_inbox).
        with(to: distant_target_actor, message: "message", from: local_actor).once
      Fediverse::Notifier.post_to_inboxes(activity)
    end

    it 'blocks delivery to blocked domains' do
      described_class.create(domain: distant_target_actor.server)
      expect(Fediverse::Notifier).not_to receive(:filtered_post_to_inbox)
      Fediverse::Notifier.post_to_inboxes(activity)
    end
  end
end
