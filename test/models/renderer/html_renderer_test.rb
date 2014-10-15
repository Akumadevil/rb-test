require "minitest/autorun"
require 'mocha'
require 'mocha/mini_test'
require "../../../app/models/renderer/html_renderer"

class HtmlRendererTest < MiniTest::Test
  TEST_TEMPLATE_PATH = "template-path"
  TEST_OUTPUT_PATH = "output-path"
  TEST_CONTEXT = ({"a"=>"b"})
  TEST_URL = "a.htm"

  describe "when calling the process method" do
    before do
      # Stub config settings
      Settings.stubs(:template_path).returns(TEST_TEMPLATE_PATH)
      Settings.stubs(:output_path).returns(TEST_OUTPUT_PATH)

      @html_renderer = HtmlRenderer.new
      @mock_file = MiniTest::Mock.new
      @slim_template = Object.new

      # Need any_instance because a singleton method (not current object instance)
      HtmlRenderer.any_instance.stubs(:build_context).returns(TEST_CONTEXT)
      HtmlRenderer.any_instance.stubs(:to_url).returns(TEST_URL)
    end

    it "should open the template file, render the template and output to a file" do
      @mock_file.expect(:read, false, [])

      # Stub file reading input and writing output
      File.stubs(:open).with(TEST_TEMPLATE_PATH, "rb").returns(@mock_file)
      File.stubs(:open).with(TEST_OUTPUT_PATH + TEST_URL, "w").returns(@mock_file)

      Slim::Template.stubs(:new).returns(@slim_template)
      @slim_template.stubs(:render).returns(nil)

      @html_renderer.render("a", "b", "c", "d")
    end
  end

  describe "when converting a string to a URL" do
    it "should replace non-alphanumeric characters and append .htm" do
      assert_equal "a-2-b-c~de-dot-fg-h8.htm", HtmlRenderer.to_url("  A 2_b-C~dE.Fg,h8")
    end

    it "should return nil on nil input" do
      assert_nil HtmlRenderer.to_url(nil)
    end

    it "should return nil on nil input" do
      assert_nil HtmlRenderer.to_url(nil)
    end
  end

  describe "when checking the links to make sure there are no links to self" do
    it "should return an empty array if reference to self " do
      assert_equal [], HtmlRenderer.check_links!("a", ["a", "b"])
    end

    it "should return an unmodified array if no reference to self " do
      assert_equal ["a", "b"], HtmlRenderer.check_links!("c", ["a", "b"])
    end

    it "should return an empty array if arguments are nil " do
      assert_equal [], HtmlRenderer.check_links!(nil, nil)
    end
  end

  describe "when building the context" do
    before do
      @context  = HtmlRenderer.build_context("a", "b", ["c", "d"], ["e", "f"])
    end

    it "should split the parent into display name and URL" do
      assert_equal ["a", "a.htm"], @context[:parent]
    end

    it "should set the title" do
      assert_equal "b", @context[:title]
    end

    it "should set the thumbnails" do
      assert_equal ["c", "d"], @context[:thumbs]
    end

    it "should split the links into a hash with key/value of display name then URL" do
      assert_equal ({"e"=>"e.htm", "f"=>"f.htm"}), @context[:links]
    end
  end
end