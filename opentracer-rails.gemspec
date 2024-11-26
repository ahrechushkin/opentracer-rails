# frozen_string_literal: true

require_relative "lib/opentracer/version"

Gem::Specification.new do |spec|
  spec.name = "opentracer-rails"
  spec.version = Opentracer::VERSION
  spec.authors = ["Aliaksei Hrechushkin"]
  spec.email = ["ahrechushkin@gmail.com"]

  spec.summary = "opentracer-rails is a Ruby gem that provides a seamless and elegant way to integrate OpenTelemetry into Ruby applications."
  spec.description = "Opentracer is a Ruby gem that integrates OpenTelemetry with Ruby on Rails to provide automatic tracing for HTTP requests and ActiveRecord model operations. It supports dynamic span names, easy integration, and custom span creation for better observability in your Rails application."
  spec.homepage = "https://github.com/ahrechushkin/opentracer-rails"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ahrechushkin/opentracer-rails"
  spec.metadata["changelog_uri"] = "https://github.com/ahrechushkin/opentracer-rails/CHANGELOG.md"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "opentelemetry-instrumentation-all", "~> 0.68.0"
  spec.add_runtime_dependency "opentelemetry-sdk", "~> 1.5"
end
