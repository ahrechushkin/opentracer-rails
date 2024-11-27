require 'active_support/concern'
module Opentracer
  module Model
    extend ActiveSupport::Concern

    included do
      around_save    :trace_method
      around_update  :trace_method
      around_create  :trace_method
      around_destroy :trace_method
    end

    private

    def trace_method(method_name)
      span_name = "#{self.class.name}##{method_name}"
      Opentracer.tracer.in_span(span_name) do |span|
        span.set_attribute('model', self.class.name)
        span.set_attribute('method', method_name)

        yield
      end
    end
  end
end
