# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'qiita_trend/version'

Gem::Specification.new do |spec|
  spec.name          = 'qiita_trend'
  spec.version       = QiitaTrend::VERSION
  spec.authors       = ['dodonki1223']
  spec.email         = ['make.an.effort.wish.come.true@gmail.com']
  spec.required_ruby_version = '>= 3.1.0'

  spec.summary       = 'Easy to get trend for Qiita in 10 seconds'
  spec.description   = 'Easy to get trend for Qiita in 10 seconds'
  spec.homepage      = 'https://github.com/dodonki1223/qiita_trend'
  spec.license       = 'MIT'

  # # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  #   spec.metadata["homepage_uri"] = spec.homepage
  #   spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  #   spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # qiita_trendに必要な依存gem設定（ここは最小限にすること）
  spec.add_dependency 'mechanize', '~> 2.7'
  spec.add_dependency 'nokogiri', '~> 1.11'
  # 開発中のみ必要なgem設定
  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'pry', '~> 0.13'
  spec.add_development_dependency 'pry-byebug', '~> 3.9'
  spec.add_development_dependency 'pry-doc', '~> 1.1'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec_junit_formatter', '~> 0.4'
  spec.add_development_dependency 'rubocop', '~> 1.41.0'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.25.0'
  spec.add_development_dependency 'simplecov', '~> 0.18'
  spec.add_development_dependency 'vcr', '~> 6.2.0'
  spec.add_development_dependency 'webmock', '~> 3.8'
  spec.add_development_dependency 'yard', '~> 0.9'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
