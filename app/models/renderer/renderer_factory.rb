require_relative 'html_renderer'
require_relative '../settings'

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