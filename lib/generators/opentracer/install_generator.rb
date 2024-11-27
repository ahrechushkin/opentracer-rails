require "rails/generators"

module Opentracer
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __dir__)

      desc "Creates an Opentracer initializer."

      class_option :instrumentation,
                   type: :array,
                   default: [],
                   desc: "Specify instrumentation libraries (e.g., --instrumentation active_record http)"

      class_option :exporter_endpoint,
                   type: :string,
                   default: "http://localhost:4318/v1/traces",
                   desc: "Specify OTEL exporter endpoint, or use the environment variable OTEL_EXPORTER_OTLP_ENDPOINT."

      class_option :service_name,
                   type: :string,
                   default: "rails",
                   desc: "Specify OTEL service name."

      def prepare_config
        @instrumentation = options[:instrumentation]
        @exporter_endpoint = options[:exporter_endpoint]
        @service_name = options[:service_name]

        template "opentracer.rb", "config/initializers/opentracer.rb"
      end

      def show_readme
        readme "README" if behavior == :invoke
      end
    end
  end
end
