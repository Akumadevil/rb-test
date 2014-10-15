require_relative '../settings'

# Futile attempt at abstract factory pattern in a duck-typing language! Smells like Java...
class AbstractProcessor
  attr_accessor :renderer

  # Abstract method requiring concrete implementation by subclass
  def process(input_path, export_path)
    raise Settings.msg.error.abstract_method_access
  end
end