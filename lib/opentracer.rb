# frozen_string_literal: true

require 'opentracer/railtie' if defined?(Rails)
require 'opentracer/middleware/opentracer_middleware'
require 'opentracer/trace_model'
module Opentracer
  class Error < StandardError; end
  class << self
    def tracer
      @tracer ||= OpenTelemetry.tracer_provider.tracer(Rails.application.name)
    end
  end
end
