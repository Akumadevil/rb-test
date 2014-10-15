require_relative 'html_renderer'
require_relative '../settings'

# Factory pattern class returns corresponding concrete implementation class
class RendererFactory
  attr_accessor :renderer

  def initialize(renderer)
    case renderer
      when :html
        @renderer = HtmlRenderer.new
      else
        raise Settings.msg.error.renderer_factory_missing
    end
  end

  def render(output_path, parent, title, thumbs, links)
    @renderer.render(output_path, parent, title, thumbs, links)
  end
end