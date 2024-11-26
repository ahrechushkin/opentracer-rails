require "rails/railtie"

module Opentracer
  class Railtie < Rails::Railtie
    initializer "opentracer.run_generator" do
      Opentracer::Generators::InstallGenerator.prepare_config
    end

    initializer "opentracer.insert_middleware" do |app|
      app.middleware.use Opentracer::OpentracerMiddleware
    end

    initializer "opentracer.include_trace_model" do
      ActiveSupport.on_load(:active_record) do
        include Opentracer::TraceModel
      end
    end
  end
end
