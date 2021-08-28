require_relative "lib/vocab/version"

Gem::Specification.new do |spec|
  spec.name        = "vocab"
  spec.version     = Vocab::VERSION
  spec.authors     = ["Pradyumna Shembekar"]
  spec.email       = ["pradyumna@hey.com"]
  spec.homepage    = "https://github.com/pradyumna2905/todoist-automations"
  spec.summary     = "Summary of Vocab."
  spec.description = "Description of Vocab."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/pradyumna2905/todoist-automations"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.1.4", ">= 6.1.4.1"
  spec.add_dependency "pg"
end
