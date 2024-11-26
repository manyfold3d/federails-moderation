require_relative "lib/federails/moderation/version"

Gem::Specification.new do |spec|
  spec.name        = "federails-moderation"
  spec.version     = Federails::Moderation::VERSION
  spec.authors     = [ "James Smith" ]
  spec.email       = [ "james@floppy.org.uk" ]
  spec.homepage    = "https://github.com/manyfold3d/federails-moderation"
  spec.summary     = "Moderation additions for Federails."
  spec.description = "Moderation additions for Federails; reporting, limit/suspend, server blocking, etc"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/manyfold3d/federails-moderation"
  spec.metadata["changelog_uri"] = "https://github.com/manyfold3d/federails-moderation/releases"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end
  spec.add_dependency "rails", ">= 7.2.2"
  spec.add_dependency "federails", "~> 0.3"
end
