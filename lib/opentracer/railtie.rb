require "rails/railtie"

module Opentracer
  class Railtie < Rails::Railtie
    initializer "opentracer.run_generator" do |app|
      unless File.exist?(Rails.root.join("config/initializers/opentracer.rb"))
        Rails.logger.info("[Opentracer] Running install generator to prepare configuration...")
        Opentracer::Generators::InstallGenerator.start
      end
    end

    initializer "opentracer.insert_middleware" do |app|
      Rails.logger.info("[Opentracer] including middleware Opentracer::OpentracerMiddleware")
      app.middleware.use Opentracer::OpentracerMiddleware
    end

    initializer "opentracer.include_trace_model" do
      ActiveSupport.on_load(:active_record) do
        Rails.logger.info("[Opentracer] including automatically TraceModel Opentracer::OpentracerMiddleware")
        include Opentracer::TraceModel
      end
    end
  end
end
