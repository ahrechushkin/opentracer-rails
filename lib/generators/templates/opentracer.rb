require 'opentelemetry/sdk'
require 'opentelemetry/instrumentation/all'
require 'opentelemetry-exporter-otlp'

OpenTelemetry::SDK.configure do |c|
  <% unless @exporter_endpoint.empty? %>
    c.service_name = '<%= @service_name %>'
  <% end %>

  <% if @instrumentation.any? %>
    <% @instrumentation.each do |i| %>
      <% transformed = (i == 'net/http' ? 'Net::HTTP' : i.camelcase) %>
      c.use 'OpenTelemetry::Instrumentation::<%= transformed %>'
    <% end %>
  <% else %>
    c.use_all
  <% end %>

  <% unless @exporter_endpoint.empty? %>
    ENV['OTEL_EXPORTER_OTLP_ENDPOINT'] = '<%= @exporter_endpoint %>'
  <% end %>
end
