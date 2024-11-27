# frozen_string_literal: true
require 'opentelemetry'
require 'opentracer/railtie' if defined?(Rails)
require 'opentracer/middleware/opentracer_middleware'
require 'opentracer/trace_model'

module Opentracer
  class Error < StandardError; end
  class << self
    def tracer
      name = 'opentracer'
      name = Rails.application.class.module_parent_name if defined?(Rails)
      @tracer ||= OpenTelemetry.tracer_provider.tracer(name)
    end
  end
end
