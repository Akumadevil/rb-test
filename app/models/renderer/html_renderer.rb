require 'slim'
require 'stringex'
require_relative 'abstract_renderer'
require_relative '../settings'

class HtmlRenderer
  def render(parent, title, thumbs, links)
    if links.first == title
      links = []
    end

    context = {:parent => [parent, url(parent)], :title => title, :thumbs => thumbs,
               :links => Hash[links.collect { |v| [v, url(v)] }]}

    layout = File.open(Settings.template_path, "rb").read
    l = Slim::Template.new { layout }
    html = l.render(Object.new, context)
    File.open(Settings.output_path + url(title), 'w') { |file| file.write(html) }
  end

  def url(input)
    input.to_url + Settings.html_suffix
  end
end