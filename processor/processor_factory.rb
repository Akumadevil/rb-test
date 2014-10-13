require './processor/xml_processor'
require './app/models/settings'

class ProcessorFactory
  def initialize(processor)
    case processor
      when :xml
        @processor = XmlProcessor.new
      else
        raise Settings.msg.error.processor_factory_missing
    end
  end

  def process
    @processor.process
  end

  def renderer=(renderer)
    @processor.renderer = renderer
  end
end