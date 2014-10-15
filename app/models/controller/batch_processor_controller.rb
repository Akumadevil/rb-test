require_relative '../processor/processor_factory'
require_relative '../renderer/renderer_factory'
require_relative '../settings'

# Initialise an XML processor and attach a HTML renderer, then process the batch
module BatchProcessorController
  def self.run(input_path, output_path)
    processor = ProcessorFactory.new(:xml)
    processor.renderer = RendererFactory.new(:html)
    processor.process(input_path, output_path)
  end
end