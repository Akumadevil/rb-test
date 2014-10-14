require_relative '../settings'

# No reason to stop somebody from instantiating the abstract class because they can add methods to it on the fly.
# Abstract design pattern out of habit -- smells like Java!
class AbstractProcessor
  attr_accessor :renderer

  def process
    raise Settings.msg.error.abstract_method_access
  end
end