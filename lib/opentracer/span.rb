module Opentracer
  module Span
    def start(span_name, attributes = {}, &block)
      Opentracer.tracer.in_span(span_name, attributes: attributes) do |span|
        block.call(span) if block_given?
        span
      end
    end

    def add_attributes(attributes)
      current_span = OpenTelemetry::Trace.current_span
      current_span.set_attributes(attributes) if current_span
    end
  end
end
