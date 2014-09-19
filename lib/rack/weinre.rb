module Rack
  class Weinre
    def initialize(app, options = {})
      @app, @options = app, options
    end

    def call(env)
      res = @app.call(env)
      if res[1]['Content-Type'] =~ /text\/html/ && enabled
        res.tap do |res|
          orig = res[2]
          res[2] = [].tap do |body|
            orig.each do |line|
              body << line.sub(/(?=<\/head>)/, tag(env))
            end
            orig.close if orig.respond_to?(:close)

            res[1]['Content-Length'] = body.join.bytesize.to_s if res[1]['Content-Length']
          end
        end
      else
        res
      end
    end

    def enabled
      @options[:switch].nil? || ::File.exist?(Pathname.pwd + @options[:switch])
    end

    def port
      @options[:port] || 8080
    end

    def tag(env)
      %{<script src="http://#{env['SERVER_NAME']}:#{port}/target/target-script-min.js#anonymous"></script>\n}
    end
  end
end
