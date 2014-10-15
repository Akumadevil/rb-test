require 'minitest/autorun'
require 'mocha'
require 'mocha/mini_test'
require_relative '../../../app/models/controller/batch_processor_controller'

class BatchProcessorControllerTest < MiniTest::Test
  describe "when running the batch processor" do
    it "should instantiate the XML processor" do
      ProcessorFactory.any_instance.stubs(:initialize).with(:xml).once
      RendererFactory.any_instance.stubs(:initialize).with(:html).once
      ProcessorFactory.any_instance.stubs(:renderer=).with(instance_of(RendererFactory)).once
      ProcessorFactory.any_instance.stubs(:process).with("a", "b").once

      # Can't split this test up because have to mock everything to avoid a mock exception
      BatchProcessorController.run("a", "b")
    end
  end
end