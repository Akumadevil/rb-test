require "minitest/autorun"
require 'mocha'
require 'mocha/mini_test'
require "../../../app/models/processor/xml_processor"

class XmlProcessorTest < MiniTest::Test
  INPUT_XML_PATH = "../../../data/works.xml"
  THUMBNAIL_PREFIX = "http://ih1.redbubble.net/work."
  THUMBNAIL_SUFFIX = ".1.flat,135x135,075,f.jpg"

  describe "when extending the Nokogiri Document class" do
    before do
      @doc = Nokogiri::XML(File.open(INPUT_XML_PATH))
      @makes = ["Canon", "FUJI PHOTO FILM CO., LTD.", "FUJIFILM", "LEICA", "NIKON CORPORATION", "Panasonic"]
    end

    it "should filter and return the camera makes" do
      assert_equal @makes, @doc.filter
    end

    it "should get the right number of thumbnails" do
      assert_equal 14, @doc.get_thumbs.size
    end

    it "should get the right thumbnails" do
      assert_equal ["31820", "2041", "240509", "26583", "2729606", "2828069", "3201430", "3502552", "3745978",
                    "3775226", "512919", "4250369", "777577", "867035"],
                   @doc.get_thumbs.collect { |node| node.gsub(THUMBNAIL_PREFIX, "").gsub(THUMBNAIL_SUFFIX, "") }
    end
  end

  describe "when extending the Nokogiri NodeSet class" do
    before do
      @doc = Nokogiri::XML(File.open(INPUT_XML_PATH))
      @makes = ["Canon", "FUJI PHOTO FILM CO., LTD.", "FUJIFILM", "LEICA", "NIKON CORPORATION", "Panasonic"]
      @models = @makes.collect { |node| @doc.search('work:contains("' + node + '")') }
    end

    it "should filter and return the right camera models for the makes" do
      assert_equal [["Canon EOS 20D", "Canon EOS 400D DIGITAL"], ["SLP1000SE"], ["FinePix S6500fd"], ["D-LUX 3"],
                    ["NIKON D80"], ["DMC-FZ30"]], @models.collect { |node| node.filter }
    end

    it "should get the right thumbnails" do
      assert_equal [["2041", "777577"], ["2828069"], ["240509"], ["2729606", "3201430", "3502552", "512919",
                    "4250369"], ["31820"], ["3745978", "3775226"]], @models.collect { |model|
        model.get_thumbs.collect { |node| node.gsub(THUMBNAIL_PREFIX, "").gsub(THUMBNAIL_SUFFIX, "") }}
    end
  end

  describe "when calling class methods" do
    before do
      @mock_renderer = MiniTest::Mock.new
      @xml_processor = XmlProcessor.new
      @xml_processor.renderer = @mock_renderer
    end

    it "should call process method" do
      Settings.stubs(:input_path).returns("input")
      Settings.stubs(:index_title).returns("index_title")

      File.stubs(:open).with("input").returns("bbb")
      #File.stubs(:new).with(is_a(String)).returns("aaa")

      @mock_renderer.expect(:render, nil, ["", "index_title", [], []])
      @xml_processor.process
      @mock_renderer.verify

    end

    it "should set the renderer" do
      #@mock_processor.expect(:renderer=, nil, [TEST_RENDERER_VALUE])
      #@processor_factory.renderer = TEST_RENDERER_VALUE
      #@mock_processor.verify
    end
  end
end