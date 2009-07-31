require 'rubygems'
require 'rake/gempackagetask'
require 'rake/testtask'

require 'lib/mongolytics/version'

task :default => :test

spec = Gem::Specification.new do |s|
  s.name             = 'mongolytics'
  s.version          = Mongolytics::Version.to_s
  s.has_rdoc         = true
  s.extra_rdoc_files = %w(README.rdoc)
  s.rdoc_options     = %w(--main README.rdoc)
  s.summary          = "Provide basic analytics tracking, server-side, using mongodb"
  s.author           = 'Tony Pitale'
  s.email            = 'tpitale@gmail.com'
  s.homepage         = 'http://t.pitale.com'
  s.files            = %w(README.rdoc Rakefile) + Dir.glob("{lib,test}/**/*")

  s.add_dependency('mongomapper', '>= 0.3.1')
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
end

desc 'Generate the gemspec to serve this Gem from Github'
task :github do
  file = File.dirname(__FILE__) + "/#{spec.name}.gemspec"
  File.open(file, 'w') {|f| f << spec.to_ruby }
  puts "Created gemspec: #{file}"
end

begin
  require 'rcov/rcovtask'
  
  desc "Generate RCov coverage report"
  Rcov::RcovTask.new(:rcov) do |t|
    t.test_files = FileList['test/**/*_test.rb']
    t.rcov_opts << "-x lib/mongolytics/version.rb"
  end
rescue LoadError
  nil
end
