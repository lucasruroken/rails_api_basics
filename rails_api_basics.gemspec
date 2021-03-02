Gem::Specification.new do |s|
  s.name = 'rails_api_basics'
  s.version     = '1.0.0'
  s.summary     = 'Basics for setting up a Rails API'
  s.description = 'Basics for setting up a Rails API'
  s.author      = "Lucas Javier Juarez"
  s.files       = `git ls-files -- {app,config,lib,test,spec,features}/*`.split("\n")
  s.homepage    = 'https://github.com/lucasruroken/rails_api_basics'
  s.email       = 'lucasjavierjuarez@hotmail.com'
  s.license     = 'MIT'

  s.add_dependency "actionpack", "~> 5.2"
  s.add_dependency "activemodel", "~> 5.2"
  s.add_dependency "activerecord", ">= 5.2", "< 7.0"
  s.add_dependency "jwt"
  s.add_dependency "fast_jsonapi"
  s.add_dependency "kaminari"
  s.add_dependency "basic-scopes-rails", '~> 0.1'

  s.test_files = Dir["spec/**/*"]
end

