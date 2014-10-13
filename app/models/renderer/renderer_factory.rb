require './app/models/renderer/html_renderer'
require './app/models/settings'

class RendererFactory
  def initialize(renderer)
    case renderer
      when :html
        @renderer = HtmlRenderer.new
      else
        raise Settings.msg.error.renderer_factory_missing
    end
  end

  def render(parent, title, thumbs, links)
    @renderer.render(parent, title, thumbs, links)
  end
end