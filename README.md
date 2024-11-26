# opentracer-rails gem

Opentracer is a Ruby gem that integrates OpenTelemetry with Ruby on Rails to provide automatic tracing for HTTP requests and ActiveRecord model operations. It supports dynamic span names, easy integration, and custom span creation for better observability in your Rails application.

## Features

- Automatic tracing of HTTP requests.
- Automatic tracing of ActiveRecord model operations (`create`, `update`, `save`).
- Custom span creation for controllers, models, and background jobs.
- Flexible configuration and attributes assignment.

## Installation

Add the `opentracer` gem to your `Gemfile`:

```ruby
gem 'opentracer'
```

## Usage

1. Run the Generator
Generate the configuration initializer with:

```bash
rails generate opentracer:install --instrumentation active_support net/http ...
```
This will create config/initializers/opentracer.rb.

2. Configure OpenTelemetry

In config/initializers/opentracer.rb, customize the instrumentation:

```ruby
OpenTelemetry::SDK.configure do |c|
  c.use_all # Enable all default instrumentations, or specify individual ones
end

Rails.logger.info("OpenTelemetry configured successfully")
```

3. Tracing HTTP Requests
The gem automatically traces HTTP requests. Each HTTP request will be captured as a span with the following attributes:
	•	method: HTTP method (e.g., GET, POST)
	•	path: URL path
	•	user_agent: User agent string
	•	remote_addr: Client IP address
	•	http.status_code: Response status code

4. Tracing ActiveRecord Model Methods
5. Manually Creating Spans

You can create custom spans in your controllers, models, and background jobs using the helper methods provided by the gem.
**Example: In a Controller**
```ruby
class UsersController < ApplicationController
  include Opentracer::SpanHelper

  def create
    start_span('UsersController#create', { 'action' => 'create' }) do |span|
      span.set_attribute('user_id', current_user.id)

      user = User.new(user_params)
      if user.save
        span.set_attribute('user_created', true)
        render json: user, status: :created
      else
        span.set_attribute('user_created', false)
        render json: user.errors, status: :unprocessable_entity
      end
    end
  end
end
```
**Example: In a Model**
```ruby
class User < ApplicationRecord
  include Opentracer::SpanHelper

  def process_order(order)
    start_span('User#process_order', { 'order_id' => order.id }) do |span|
      span.set_attribute('order_status', order.status)
      add_span_attributes('order_amount' => order.amount)

      order.process!
      span.set_attribute('order_processed', true)
    end
  end
end
```
**Example: In a Job**
```ruby
class ProcessUserJob < ApplicationJob
  include Opentracer::SpanHelper

  queue_as :default

  def perform(user_id)
    user = User.find(user_id)

    start_span('ProcessUserJob#perform', { 'user_id' => user.id }) do |span|
      span.set_attribute('job_start_time', Time.now.to_i)

      user.process_order(some_order)

      span.set_attribute('job_end_time', Time.now.to_i)
    end
  end
end
```
6. Adding Custom Attributes to Spans
Use the add_span_attributes method to dynamically add attributes to the current span:
```ruby
add_span_attributes('custom_attribute' => 'value')
```
7. Background Jobs
Spans can also be created for background jobs, and the gem automatically tracks execution time, job status, and more.
Configuration
The gem uses OpenTelemetry SDK, and you can configure it as needed. By default, c.use_all is enabled to automatically trace all instrumentations. To customize, modify config/initializers/opentracer.rb:
```ruby
OpenTelemetry::SDK.configure do |c|
  c.use 'OpenTelemetry::Instrumentation::Rails'
  # Add more specific instrumentations as needed
end
```