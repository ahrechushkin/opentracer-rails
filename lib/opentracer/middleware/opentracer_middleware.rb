require 'action_dispatch'
module Opentracer
  class OpentracerMiddleware
    def initialize(app)
      @app = app
      @tracer = Opentracer.tracer
    end

    def call(env)
      request = ActionDispatch::Request.new(env)
      trace_name = "HTTP #{request.method} #{request.path}"

      @tracer.in_span(trace_name, attributes: span_attributes(request)) do |span|
        status, headers, response = @app.call(env)
        span.set_attribute('http.status_code', status)
        [status, headers, response]
      end
    end

    private

    def span_attributes(request)
      {
        'component' => 'rails',
        'method' => request.method,
        'path' => request.path
      }
    end

  end
end
