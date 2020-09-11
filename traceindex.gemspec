$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "traceindex"
  s.version     = '0.0.1'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Akira Kusumoto']
  s.email       = ['akirakusumo10@gmail.com']
  s.homepage    = 'https://github.com/bluerabbit/traceindex'
  s.summary     = 'A Rake task that helps you find the missing indexes for your Rails app'
  s.description =  "This Rake task investigates the application's tables definition, then tells you missing indexes"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.licenses = ['MIT']

  s.add_dependency 'rails', ['>= 4.0.0']
end
