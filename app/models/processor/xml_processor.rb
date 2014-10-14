require 'nokogiri'
require_relative 'abstract_processor'
require_relative '../settings'

class Nokogiri::XML::Document
  def filter
    self.xpath("//exif//make").collect { |node| node.text }.sort.uniq
  end

  def get_thumbs
    self.xpath("//url[@type='" + Settings.thumbnail_size + "']").collect { |node| node.text }
  end
end

class Nokogiri::XML::NodeSet
  def filter
    self.xpath("exif//model").collect { |node| node.text }.sort.uniq
  end

  def get_thumbs
    self.xpath("urls//url[@type='" + Settings.thumbnail_size + "']").collect { |node| node.text }
  end
end

class XmlProcessor < AbstractProcessor
  def process
    doc = Nokogiri::XML(File.open(Settings.input_path))
    render_recursively(Settings.index_title, doc)
  end

  def render_recursively(title, obj, parent = '')
    renderer.render(parent, title, obj.get_thumbs, obj.filter)

    # For Doc object, returns a list of makes. For the NodeSet object, returns a list of models.
    obj.filter.each do |key|
      # Only recurse if not the same as the parent to avoid an infinite loop
      if title != key
        nodes = obj.search('work:contains("' + key + '")')
        render_recursively(key, nodes, title)
      end
    end
  end
end

