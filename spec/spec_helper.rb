require 'capybara/rspec'
require 'rack'
require 'rack/weinre'

module RackWeinreHelpers
  def rackup(*args)
    app, options =
      case args.first
      when Hash then [stub_app,   args.first]
      when nil  then [stub_app,   {}]
      else           [args.first, args.last || {}]
      end

    Capybara.app = Rack::Builder.app do
      use Rack::Lint
      use Rack::Weinre, options
      run app
    end
  end

  def stub_app(options = {})
    lambda do |env|
      [
        options[:status] || 200,
        {'Content-Type' => 'text/html'}.merge(options[:headers] || {}),
        options[:body] || ['<html><head></head></html>']
      ]
    end
  end
end

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include RackWeinreHelpers
end
