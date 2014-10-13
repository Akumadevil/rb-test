require './app/models/settings'

class AbstractRenderer
  def render(title, thumbs, links)
    raise Settings.msg.error.abstract_method_access
  end
end