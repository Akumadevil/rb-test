#require 'nokogiri'
require 'rubygems'
require 'bundler/setup'
require_relative 'abstract_processor'
require_relative '../settings'

Bundler.require

# Extend with methods to allow functional programming
class Nokogiri::XML::Document
  # Returns the <exif><make> elements from this document -- sorted and without duplicates
  def filter
    self.xpath("//exif//make").collect { |node| node.text }.sort.uniq
  end

  # Returns the <url type="small"> elements from this document
  def get_thumbs
    self.xpath("//url[@type='" + Settings.thumbnail_size + "']").collect { |node| node.text }
  end
end

# Extend with methods to allow functional programming
class Nokogiri::XML::NodeSet
  # Returns the <exif><model> elements from this NodeSet -- sorted and without duplicates
  def filter
    self.xpath("exif//model").collect { |node| node.text }.sort.uniq
  end

  # Returns the <url type="small"> elements from this NodeSet
  def get_thumbs
    self.xpath("urls//url[@type='" + Settings.thumbnail_size + "']").collect { |node| node.text }
  end
end

# Concrete implementation of an XML processor that renders through the concrete AbstractRenderer.renderer property
class XmlProcessor < AbstractProcessor
  def process(input_path, output_path)
    doc = Nokogiri::XML(File.open(input_path))
    render_recursively(output_path, Settings.index_title, doc)
  end

  # Starting with the top-level recursively render the index, make and make/model pages
  def render_recursively(output_path, title, obj, parent = '')
    renderer.render(output_path, parent, title, obj.get_thumbs, obj.filter)

    # For Doc object, returns a list of makes. For the NodeSet object, returns a list of models.
    obj.filter.each do |key|
      # Only recurse if not the same as the parent to avoid an infinite loop
      if title != key
        nodes = obj.search('work:contains("' + key + '")')
        render_recursively(output_path, key, nodes, title)
      end
    end
  end
end

