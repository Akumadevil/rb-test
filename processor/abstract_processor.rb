require './app/models/settings'

class AbstractProcessor
  attr_accessor :renderer

  def process
    raise Settings.msg.error.abstract_method_access
  end
end