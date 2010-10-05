Gem::Specification.new do |s|
  s.name = 'peons'
  s.version = "0.0.5"
  s.summary = %{Hard working queues on top of Redis}
  s.date = "2010-10-05"
  s.author = "Cyril David"
  s.email = "cyx.ucron@gmail.com"
  s.homepage = "http://github.com/cyx/peons"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.files = ["lib/peons.rb", "README.markdown", "LICENSE", "Rakefile", "test/helper.rb", "test/peons_test.rb"]

  s.require_paths = ['lib']

  s.add_dependency "redis"
  s.add_dependency "nest"
  s.add_development_dependency "cutest"
  s.has_rdoc = false
  s.executables.push "peons"
end

