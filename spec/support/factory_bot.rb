
require "factory_bot"

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  FactoryBot.definition_file_paths = [ Federails::Moderation::Engine.root.join("spec/factories") ]
  config.before(:suite) do
    FactoryBot.find_definitions
  end
end
