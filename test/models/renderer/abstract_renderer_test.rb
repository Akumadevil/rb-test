require "minitest/autorun"
require_relative "../../../app/models/renderer/abstract_renderer"

class AbstractRendererTest < MiniTest::Test
  describe "when calling the render method of the abstract class" do
    before do
      @abstract_renderer  = AbstractRenderer.new
    end

    it "should throw an error" do
      assert_raises RuntimeError do
        @abstract_renderer.render(nil, nil, nil, nil)
      end
    end

    it "should display the correct error message" do
      err = ->{ @abstract_renderer.render(nil, nil, nil, nil) }.must_raise RuntimeError
      err.message.must_match Settings.msg.error.abstract_method_access
    end
  end
end