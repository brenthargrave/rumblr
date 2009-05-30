# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rumblr}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brent Hargrave", "Benny Wong"]
  s.date = %q{2009-05-30}
  s.description = %q{Ruby client for the Tumblr API}
  s.email = %q{brent.hargrave@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE.rdoc",
     "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "LICENSE.rdoc",
     "README.rdoc",
     "Rakefile",
     "VERSION.yml",
     "lib/rumblr.rb",
     "lib/rumblr/client.rb",
     "lib/rumblr/post.rb",
     "lib/rumblr/resource.rb",
     "lib/rumblr/tumblelog.rb",
     "lib/rumblr/user.rb",
     "rumblr.gemspec",
     "spec/rumblr/client_spec.rb",
     "spec/rumblr/post_spec.rb",
     "spec/rumblr/tumblelog_spec.rb",
     "spec/rumblr/user_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/jamescallmebrent/rumblr}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{Ruby client for the Tumblr API}
  s.test_files = [
    "spec/rumblr/client_spec.rb",
     "spec/rumblr/post_spec.rb",
     "spec/rumblr/tumblelog_spec.rb",
     "spec/rumblr/user_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<libxml-ruby>, [">= 0.8.3"])
    else
      s.add_dependency(%q<libxml-ruby>, [">= 0.8.3"])
    end
  else
    s.add_dependency(%q<libxml-ruby>, [">= 0.8.3"])
  end
end
