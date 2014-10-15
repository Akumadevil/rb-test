require "minitest/autorun"
require "../../../app/models/renderer/renderer_factory"

class RendererFactoryTest < MiniTest::Test
  TEST_RENDERER_INVALID = :foo
  TEST_RENDERER_VALID = :html

  describe "when initialising the object from the factory" do
    it "should throw an error if the renderer does not exist" do
      assert_raises RuntimeError do
        RendererFactory.new(TEST_RENDERER_INVALID)
      end
    end

    it "should display the correct error message if the processor does not exist" do
      err = ->{ RendererFactory.new(TEST_RENDERER_INVALID) }.must_raise RuntimeError
      err.message.must_match Settings.msg.error.renderer_factory_missing
    end

    it "should return a ProcessorFactory object if valid" do
      assert_instance_of RendererFactory, RendererFactory.new(TEST_RENDERER_VALID)
    end
  end

  describe "when calling class methods" do
    before do
      @mock_renderer = MiniTest::Mock.new
      @renderer_factory = RendererFactory.new(TEST_RENDERER_VALID)
      @renderer_factory.renderer = @mock_renderer
    end

    it "should call render method" do
      @mock_renderer.expect(:render, nil, ["1", "2", "3", "4"])
      @renderer_factory.render("1", "2", "3", "4")
      @mock_renderer.verify
    end
  end
end