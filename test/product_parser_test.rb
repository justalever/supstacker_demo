require "test_helper"

class ProductParserTest < ActiveSupport::TestCase
  include ProductParser
  include Devise::Test::IntegrationHelpers

  def setup
    sign_in(:one)
    @amazon_url = "https://www.amazon.com/BSN-XPLODE-Pre-Workout-Supplement-Beta-Alanine/dp/B007XRVL2Y/"
  end

  def test_parse_doc
    doc = ProductParser.parse_doc(@amazon_url)
    assert_instance_of Nokogiri::HTML::Document, doc
  end

  def test_amazon_get_attributes
    attributes = ProductParser::Amazon.get_attributes(@amazon_url)

    assert_not_nil attributes[:title]
    assert_not_nil attributes[:description]
    assert_not_nil attributes[:price]
    assert_not_nil attributes[:brand]
    assert_not_nil attributes[:thumbnail]
    assert_not_nil attributes[:asin]
  end
end
