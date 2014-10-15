#require 'slim'
#require 'stringex'
require 'rubygems'
require 'bundler/setup'
require_relative 'abstract_renderer'
require_relative '../settings'

Bundler.require

# Concrete implementation of a HTML renderer that creates static HTML files
class HtmlRenderer
  # Opens the template, renders the HTML then creates and writes to a file in the output directory
  def render(output_path, parent, title, thumbs, links)
    layout = File.open(Settings.template_path, "rb").read
    html = Slim::Template.new { layout }.render(Object.new, HtmlRenderer.build_context(parent, title, thumbs, links))
    File.open(output_path + HtmlRenderer.to_url(title), 'w') { |file| file.write(html) }
  end

  # Context variables used by the HTML template. Contains the current page title, parent title/link, thumbnails,
  # and navigation title/links.
  def self.build_context(parent, title, thumbs, links)
    {:parent => [parent, HtmlRenderer.to_url(parent)], :title => title, :thumbs => thumbs,
               :links => Hash[check_links!(title, links).collect { |v| [v, HtmlRenderer.to_url(v)] }]}
  end

  # If navigation links contain the current page title, modify and empty the links
  def self.check_links!(title, links)
    if links.nil? || title.nil? || links.first == title
      links = []
    end

    links
  end

  # Takes a string and returns a URL-friendly version with extension
  def self.to_url(input)
    unless input.nil?
      input.to_url + Settings.html_suffix
    end
  end
end