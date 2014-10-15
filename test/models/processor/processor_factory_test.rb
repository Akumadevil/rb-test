require "minitest/autorun"
require_relative "../../../app/models/processor/processor_factory"

class ProcessorFactoryTest < MiniTest::Test
  TEST_PROCESSOR_INVALID = :foo
  TEST_PROCESSOR_VALID = :xml
  TEST_RENDERER_VALUE = "test-renderer";

  describe "when initialising the object from the factory" do
    it "should throw an error if the processor does not exist" do
      assert_raises RuntimeError do
        ProcessorFactory.new(TEST_PROCESSOR_INVALID)
      end
    end

    it "should display the correct error message if the processor does not exist" do
      err = ->{ ProcessorFactory.new(TEST_PROCESSOR_INVALID) }.must_raise RuntimeError
      err.message.must_match Settings.msg.error.processor_factory_missing
    end

    it "should return a ProcessorFactory object if valid" do
      assert_instance_of ProcessorFactory, ProcessorFactory.new(TEST_PROCESSOR_VALID)
    end
  end

  describe "when calling class methods" do
    before do
      @mock_processor = MiniTest::Mock.new
      @processor_factory = ProcessorFactory.new(TEST_PROCESSOR_VALID)
      @processor_factory.processor = @mock_processor
    end

    it "should call process method" do
      @mock_processor.expect(:process, nil)
      @processor_factory.process
      @mock_processor.verify
    end

    it "should set the renderer" do
      @mock_processor.expect(:renderer=, nil, [TEST_RENDERER_VALUE])
      @processor_factory.renderer = TEST_RENDERER_VALUE
      @mock_processor.verify
    end
  end
end