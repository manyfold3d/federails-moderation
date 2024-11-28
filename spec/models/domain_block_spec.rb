RSpec.describe Federails::Moderation::DomainBlock do
  [
    "example.com",
    "my.website.co.uk",
    "Bücher.de",
    "кц.рф",
    "互联网中心.中国",
    "☃.com"
  ].each do |test|
    it "is valid if domain name is #{test.inspect}" do
      block = described_class.new(domain: test)
      expect(block).to be_valid
    end
  end

  [
    nil,
    "",
    "example.invalid",
    ".example.com"
  ].each do |test|
    it "is invalid if domain name is #{test.inspect}" do
      block = described_class.new(domain: test)
      expect(block).not_to be_valid
    end
  end

  context "with a blocked domain" do
    before do
      described_class.create(domain: "blocked.com")
    end

    it "blocks the domain" do
      expect(described_class.blocked?("blocked.com")).to be true
    end

    it "blocks subdomains" do
      expect(described_class.blocked?("www.blocked.com")).to be true
    end

    it "allows other domains" do
      expect(described_class.blocked?("example.com")).to be false
    end
  end
end
