# frozen_string_literal: true
source "http://rubygems.org"
ruby "2.5.1"
gemspec
group :test do
  gem "html-proofer", "~> 3.18"
end
gem 'jekyll-multiple-languages-plugin'

# Windows and JRuby does not include zoneinfo files, so bundle the tzinfo-data gem
# and associated library.
install_if -> { RUBY_PLATFORM =~ %r!mingw|mswin|java! } do
  gem "tzinfo", "~> 1.2"
  gem "tzinfo-data"
end

# Performance-booster for watching directories on Windows
gem "wdm", "~> 0.1.1", :install_if => Gem.win_platform?
group :jekyll_plugins do
  gem "jekyll-feed", "~> 0.12"
  gem 'jekyll-admin'
end
gem "nokogiri", "~> 1.10.10"
# Jekyll <= 4.2.0 compatibility with Ruby 3.0
gem "webrick", "~> 1.7"
