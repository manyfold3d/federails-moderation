FactoryBot.define do
  factory :report, class: 'Federails::Moderation::Report' do
    federated_url { Faker::Internet.url }
    federails_actor { create :distant_actor }
    object { create :user }
    content { Faker::Lorem.sentence }
  end
end
