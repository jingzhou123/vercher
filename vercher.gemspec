# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','vercher','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'vercher'
  s.version = Vercher::VERSION
  s.author = 'Jing Zhou'
  s.email = '546623542@qq.com'
  #s.homepage = 'http://your.website.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'refresh files of assets like js or css for vm or html file'
  s.files = `git ls-files`.split("
")
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','vercher.rdoc']
  s.rdoc_options << '--title' << 'vercher' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'vercher'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_development_dependency('rspec')
  s.add_runtime_dependency('gli','2.13.1')
end
