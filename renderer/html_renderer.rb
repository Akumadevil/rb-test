require 'slim'
require 'stringex'
require './renderer/abstract_renderer'
require './app/models/settings'

class HtmlRenderer
  def render(parent, title, thumbs, links)
    if links.first == title
      links = []
    end

    context = {:parent => [parent, parent.to_url + Settings.html_suffix], :title => title, :thumbs => thumbs,
               :links => Hash[links.collect { |v| [v, v.to_url + Settings.html_suffix] }]}

    layout = File.open(Settings.template_path, "rb").read
    l = Slim::Template.new { layout }
    html = l.render(Object.new, context)
    File.open(Settings.output_path + title.to_url + Settings.html_suffix, 'w') { |file| file.write(html) }
  end
end