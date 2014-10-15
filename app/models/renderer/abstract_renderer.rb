require_relative '../settings'

# Futile attempt at abstract factory pattern in a duck-typing language! Smells like Java...
class AbstractRenderer
  # Abstract method requiring concrete implementation by subclass
  def render(output_path, title, thumbs, links)
    raise Settings.msg.error.abstract_method_access
  end
end