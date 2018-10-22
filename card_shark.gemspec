$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "card_shark/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "card_shark"
  s.version     = CardShark::VERSION
  s.authors     = ["Abel Avila"]
  s.email       = ["abelavila@sycamoreleaf.com"]
  s.summary     = "Trello / Clubhouse Integration"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.1"
end
