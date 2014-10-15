#require 'settingslogic'
require 'rubygems'
require 'bundler/setup'

Bundler.require

# Configuration for global singleton settings (i.e. properties)
class Settings < Settingslogic
  source "../config/application.yml"
  # Matches the YAML file
  namespace 'development'
end