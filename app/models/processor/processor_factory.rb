require_relative 'xml_processor'
require_relative '../settings'

# Factory pattern class returns corresponding concrete implementation class
class ProcessorFactory
  attr_accessor :processor

  def initialize(processor)
    case processor
      when :xml
        @processor = XmlProcessor.new
      else
        raise Settings.msg.error.processor_factory_missing
    end
  end

  def process(input_path, export_path)
    @processor.process(input_path, export_path)
  end

  def renderer=(renderer)
    @processor.renderer = renderer
  end
end