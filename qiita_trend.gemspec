# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'qiita_trend/version'

Gem::Specification.new do |spec|
  spec.name          = 'qiita_trend'
  spec.version       = QiitaTrend::VERSION
  spec.authors       = ['dodonki1223']
  spec.email         = ['make.an.effort.wish.come.true@gmail.com']

  spec.summary       = 'Get Qiita Trend'
  spec.description   = 'Get Qiita Trend'
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
  spec.add_dependency 'mechanize'
  spec.add_dependency 'nokogiri', '~> 1.9'
  # 開発中のみ必要なgem設定
  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec_junit_formatter'
  spec.add_development_dependency 'rubocop', '~> 0.62'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
end
