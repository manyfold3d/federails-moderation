RSpec.describe Federails::Moderation::DomainBlock do
  let(:actor) { FactoryBot.create(:user).federails_actor }

  describe 'with a blocked domain' do
    before do
      described_class.create(domain: "example.com")
    end

    it 'allows non-matching activities' do
      payload = { "id" => "https://test.com/abc1234" }
      expect(Fediverse::Inbox).to receive(:filtered_dispatch_request).with(payload)
      Fediverse::Inbox.dispatch_request(payload)
    end

    it 'rejects activities with matching IDs' do
      payload = { "id" => "https://example.com/abc1234" }
      expect(Fediverse::Inbox).not_to receive(:filtered_dispatch_request)
      Fediverse::Inbox.dispatch_request(payload)
    end

    it 'rejects activities with subdomain-matching IDs' do
      payload = { "id" => "https://www.example.com/abc1234" }
      expect(Fediverse::Inbox).not_to receive(:filtered_dispatch_request)
      Fediverse::Inbox.dispatch_request(payload)
    end

    it 'rejects activities with matching actors' do
      payload = { "actor" => "https://example.com/users/abc1234" }
      expect(Fediverse::Inbox).not_to receive(:filtered_dispatch_request)
      Fediverse::Inbox.dispatch_request(payload)
    end
  end
end
