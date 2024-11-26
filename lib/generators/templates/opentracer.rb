require 'opentelemetry/sdk'
require 'opentelemetry/instrumentation/all'

OpenTelemetry::SDK.configure do |c|
  <% if @instrumentation.any? %>
    <% @instrumentation.each do |i| %>
      <% transformed = (i == 'net/http' ? 'Net::HTTP' : i.camelcase) %>
      c.use 'OpenTelemetry::Instrumentation::<%= transformed %>'
    <% end %>
  <% else %>
    c.use_all
  <% end %>
end
