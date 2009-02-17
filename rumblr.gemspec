# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rumblr}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brent Hargrave"]
  s.date = %q{2009-02-17}
  s.description = %q{Ruby client for the Tumblr API}
  s.email = %q{brent.hargrave@gmail.com}
  s.files = ["LICENSE.rdoc", "README.rdoc", "VERSION.yml", "lib/rumblr.rb", "spec/rumblr_spec.rb", "spec/spec_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/jamescallmebrent/rumblr}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Ruby client for the Tumblr API}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<libxml-ruby>, [">= 0.8.3"])
    else
      s.add_dependency(%q<libxml-ruby>, [">= 0.8.3"])
    end
  else
    s.add_dependency(%q<libxml-ruby>, [">= 0.8.3"])
  end
end
