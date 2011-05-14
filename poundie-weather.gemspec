# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{poundie-weather}
  s.version = "0.0.1"
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Pat Nakajima}]
  s.date = %q{2011-05-13}
  s.files = ["lib/poundie-weather.rb"]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.0}
  s.summary = %q{A Poundie plugin to post weather information to campfire}
  s.description = "A Poundie plugin to post weather information to campfire"
  s.add_dependency("poundie")
  s.add_dependency("nokogiri")
end
