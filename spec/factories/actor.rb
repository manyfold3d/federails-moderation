FactoryBot.define do
  factory :actor, class: 'Federails::Actor' do
    username { Faker::Internet.username separators: [ '-', '_' ] }
  end
end
