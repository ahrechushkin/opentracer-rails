# frozen_string_literal: true

require_relative "lib/opentracer/version"

Gem::Specification.new do |spec|
  spec.name = "opentracer-ruby"
  spec.version = Opentracer::VERSION
  spec.authors = ["Aliaksei Hrechushkin"]
  spec.email = ["ahrechushkin@gmail.com"]

  spec.summary = "opentracer-ruby is a Ruby gem that provides a seamless and elegant way to integrate OpenTelemetry into Ruby applications."
  spec.description = "OpenTelemetry is a powerful observability framework designed to provide telemetry data, such as distributed traces and metrics, from applications. While OpenTelemetry has Ruby support, configuring and integrating it can sometimes feel cumbersome. opentracer-ruby was created to streamline this process, allowing you to enhance your Ruby applications with tracing capabilities in an intuitive, Ruby-friendly way."
  spec.homepage = "https://github.com/ahrechushkin/opentracer-ruby"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ahrechushkin/opentracer-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/ahrechushkin/opentracer-ruby/CHANGELOG.md"

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
end
