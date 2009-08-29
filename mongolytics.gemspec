# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{mongolytics}
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tony Pitale"]
  s.date = %q{2009-08-29}
  s.email = %q{tpitale@gmail.com}
  s.files = ["README.md", "Rakefile", "lib/mongolytics", "lib/mongolytics/param.rb", "lib/mongolytics/session.rb", "lib/mongolytics/statistic.rb", "lib/mongolytics/tracker.rb", "lib/mongolytics/version.rb", "lib/mongolytics.rb", "test/test_helper.rb", "test/unit", "test/unit/mongolytics", "test/unit/mongolytics/statistic_test.rb", "test/unit/mongolytics/tracker_test.rb", "test/unit/mongolytics_test.rb"]
  s.homepage = %q{http://t.pitale.com}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Provide basic analytics tracking, server-side, using mongodb}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mongomapper>, [">= 0.3.1"])
    else
      s.add_dependency(%q<mongomapper>, [">= 0.3.1"])
    end
  else
    s.add_dependency(%q<mongomapper>, [">= 0.3.1"])
  end
end
