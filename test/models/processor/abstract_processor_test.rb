require "minitest/autorun"
require_relative "../../../app/models/processor/abstract_processor"

class AbstractProcessorTest < MiniTest::Test
  TEST_RENDERER_VALUE = "test-renderer";

  describe "when setting and getting the renderer property" do
    it "should return the same value" do
      test_processor = AbstractProcessor.new
      test_processor.renderer = TEST_RENDERER_VALUE
      assert_equal TEST_RENDERER_VALUE, test_processor.renderer
    end
  end

  describe "when calling the process method of the abstract class" do
    before do
      @abstract_processor  = AbstractProcessor.new
    end

    it "should throw an error" do
      assert_raises RuntimeError do
        @abstract_processor.process
      end
    end

    it "should display the correct error message" do
      err = ->{ @abstract_processor.process }.must_raise RuntimeError
      err.message.must_match Settings.msg.error.abstract_method_access
    end
  end
end