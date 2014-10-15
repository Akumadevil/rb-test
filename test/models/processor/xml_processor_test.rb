require "minitest/autorun"
require 'mocha'
require 'mocha/mini_test'
require_relative "../../../app/models/processor/xml_processor"

# Relative path to works.xml from the test_suite.rb with cause a 'No such file or directory' error when running
# just this class as a test
class XmlProcessorTest < MiniTest::Test
  INPUT_XML_PATH = "../data/works.xml"
  THUMBNAIL_PREFIX = "http://ih1.redbubble.net/work."
  THUMBNAIL_SUFFIX = ".1.flat,135x135,075,f.jpg"
  TEST_INPUT_PATH = "input-path"
  TEST_OUTPUT_PATH = "output-path"
  TEST_INDEX_TITLE = "index-title"

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

  describe "when calling the process method" do
    before do
      @mock_renderer = MiniTest::Mock.new
      @xml_processor = XmlProcessor.new
      @xml_processor.renderer = @mock_renderer
    end

    it "should open and parse the input then render" do
      Settings.stubs(:index_title).returns(TEST_INDEX_TITLE)
      File.stubs(:open).with(TEST_INPUT_PATH).returns("")

      @mock_renderer.expect(:render, false, [TEST_OUTPUT_PATH, "", TEST_INDEX_TITLE, [], []])
      @xml_processor.process(TEST_INPUT_PATH, TEST_OUTPUT_PATH)
      @mock_renderer.verify
    end
  end

  describe "when calling the recursive render" do
    before do
      @mock_renderer = MiniTest::Mock.new
      @xml_processor = XmlProcessor.new
      @xml_processor.renderer = @mock_renderer
    end

    it "should call render with correct arguments" do
      mock_doc = Nokogiri::XML::Document.new
      mock_doc.expects(:get_thumbs).returns([])
      mock_doc.expects(:filter).returns([]).twice
      @mock_renderer.expect(:render, false, ["", "", TEST_INDEX_TITLE, [], []])
      @xml_processor.render_recursively("", TEST_INDEX_TITLE, mock_doc)
      @mock_renderer.verify
    end

    it "should call itself recursively" do
      doc = Nokogiri::XML(File.open(INPUT_XML_PATH))
      mock_renderer = Object.new
      mock_renderer.expects(:render).times(14)
      @xml_processor.renderer = mock_renderer
      @xml_processor.render_recursively("", "", doc)
    end
  end
end