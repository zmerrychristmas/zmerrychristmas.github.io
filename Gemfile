# frozen_string_literal: true
source "http://rubygems.org"
ruby "2.7.2"
gemspec
group :test do
  gem "html-proofer", "~> 4.4"
end
gem 'jekyll-multiple-languages-plugin'

# Windows and JRuby does not include zoneinfo files, so bundle the tzinfo-data gem
# and associated library.
platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
end

# Performance-booster for watching directories on Windows
group :jekyll_plugins do
  gem "jekyll-feed", "~> 0.12"
  gem 'jekyll-admin'
end
gem "nokogiri", "~> 1.13"
# Jekyll <= 4.2.0 compatibility with Ruby 3.0
gem "webrick", "~> 1.7"
gem "wdm", "~> 0.1.1", :platforms => [:mingw, :x64_mingw, :mswin]

# Lock `http_parser.rb` gem to `v0.6.x` on JRuby builds since newer versions of the gem
# do not have a Java counterpart.
gem "http_parser.rb", "~> 0.6.0", :platforms => [:jruby]
