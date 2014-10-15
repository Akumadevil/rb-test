require 'slim'
require 'stringex'
require_relative 'abstract_renderer'
require_relative '../settings'

class HtmlRenderer
  def render(parent, title, thumbs, links)
    layout = File.open(Settings.template_path, "rb").read
    html = Slim::Template.new { layout }.render(Object.new, HtmlRenderer.build_context(parent, title, thumbs, links))
    File.open(Settings.output_path + HtmlRenderer.to_url(title), 'w') { |file| file.write(html) }
  end

  def self.build_context(parent, title, thumbs, links)
    {:parent => [parent, HtmlRenderer.to_url(parent)], :title => title, :thumbs => thumbs,
               :links => Hash[check_links!(title, links).collect { |v| [v, HtmlRenderer.to_url(v)] }]}
  end

  def self.check_links!(title, links)
    if links.nil? || title.nil? || links.first == title
      links = []
    end

    links
  end

  def self.to_url(input)
    unless input.nil?
      input.to_url + Settings.html_suffix
    end
  end
end