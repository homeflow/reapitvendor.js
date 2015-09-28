require 'rubygems'
require 'bundler/setup'
Bundler.setup
require 'sinatra'
require 'rack/cors'
require 'rack/reverse_proxy'


#use Rack::Cors do
#  allow do
#     origins '*'
#     resource '/reapit/*', :headers => :any, :methods => :post
#   end
#end
use Rack::ReverseProxy do
  # Set :preserve_host to true globally (default is true already)
  reverse_proxy_options preserve_host: false


  # Forward the path /test* to http://example.com/test*
  reverse_proxy /reapit\/(.*)/, 'http://karltatler.reapitcloud.com/webservice/index.php/$1'
end
