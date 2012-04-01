rack-weinre
========
rack-weinre is a rack middleware, which inserts a script tag that loads [weinre](http://phonegap.github.com/weinre/) target script file into your text/html pages.

Setup
--------
First, add to your Gemfile:

    gem 'rack-weinre'

then <code>bundle</code> as usual.

### with Rails

in <code>config/environments/development.rb</code>:

    MyApp::Application.configure do
      ...
      config.middleware.use 'Rack::Weinre'
    end

### with config.ru

    use Rack::Weinre

How it works
------------------
Once enabled (see below), it inserts a <code>script</code> tag just before the closing <code>head</code> tag of your html pages. the tag is something like:

    <script src="http://localhost:8080/target/target-script-min.js#anonymous"></script>

but the host name depends on to which host the request was made.

Options
-----------
### port
you may use a port number other than 8080, say, 9090. <code>:port</code> option will come in handy then.

    use Rack::Weinre, :port => 9090

### Toggle tag

if you give a <code>:switch</code> option, it is considered as a file name in a relative path from the working rack application. in that case, rake-weinre is active only when the file exists at the exact path.

    use Rack::Weinre, :switch => 'file'  # inserts tag if the file exists (relative)

it is always active when no <code>:switch</code> option is given.

Copyright
--------------
Copyright &copy; 2012 Hiroki Yoshioka. See MIT-LICENSE for further details.
