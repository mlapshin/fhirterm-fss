require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require_relative 'fss'
use FhirServerStub
run Sinatra::Application
