require_relative "lib/federails/moderation/version"

Gem::Specification.new do |spec|
  spec.required_ruby_version = '~> 3.3'
  spec.name        = "federails-moderation"
  spec.version     = Federails::Moderation::VERSION
  spec.authors     = [ "James Smith" ]
  spec.email       = [ "james@floppy.org.uk" ]
  spec.homepage    = "https://github.com/manyfold3d/federails-moderation"
  spec.summary     = "Moderation additions for Federails."
  spec.description = "Moderation additions for Federails; reporting, limit/suspend, server blocking, etc"
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/manyfold3d/federails-moderation"
  spec.metadata["changelog_uri"] = "https://github.com/manyfold3d/federails-moderation/releases"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end
  spec.add_dependency "rails", ">= 7.2.2"
  spec.add_dependency "federails", "~> 0.4"
  spec.add_dependency "public_suffix", "~> 6.0"
end
