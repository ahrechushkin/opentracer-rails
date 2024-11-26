module Opentracer
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a Opentracer initializer."
      class_option :instrumentation,
                    type: :array,
                    default: [],
                    desc: "Specify instrumentation libraries (e.g., --instrumentation active_record http)"

      def prepare_config
        @instrumentation = options[:instrumentation]
        template "opentracer.rb", "config/initializers/opentracer.rb"
      end

      def show_readme
        readme "README" if behavior == :invoke
      end
    end
  end
end
