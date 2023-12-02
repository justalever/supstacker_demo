include ActionView::Helpers::SanitizeHelper

module ProductParser
  require 'open-uri'

  COMMON_USER_AGENTS = ['Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.71 Safari/537.36','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.71 Safari/537.36','Mozilla/5.0 (Windows NT 10.0; WOW64; rv:49.0) Gecko/20100101 Firefox/49.0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.71 Safari/537.36']

  def self.parse_doc(url)
    URI.open(url, 'User-Agent' => COMMON_USER_AGENTS.sample) { |f| Nokogiri::HTML.parse(f) }
  end

  module Amazon
    def self.get_attributes(url)
      attributes = {}
      doc = ProductParser.parse_doc(url)

      # title
      title_element = doc.at('#productTitle')

      if title_element
        title_string = title_element.inner_html.strip
        attributes[:title] = title_string
      end

      # description
      description_element = doc.at('#productDescription')

      if description_element
        dirty_description = description_element.inner_html
        clean_description = sanitize(dirty_description, tags: %w[h3 span p])

        if clean_description.blank?
          attributes[:description] = "N/A"
        else
          attributes[:description] = clean_description
        end
      end

      # price
      price_1_element = doc.at('#corePrice_feature_div .a-offscreen')
      price_2_element = doc.at('.header-price span')

      if price_1_element
        price_1_string = price_1_element.inner_html
        price_1_decimal = price_1_string.gsub(/[^0-9.]/, '').to_d
        attributes[:price] = price_1_decimal
      elsif price_2_element
        price_2_string = price_2_element.inner_html
        price_2_decimal = price_2_string.gsub(/[^0-9.]/, '').to_d
        attributes[:price] = price_2_decimal
      else
        attributes[:price] = nil
      end

      # brand
      brand_element = doc.at('.po-brand .a-span9 span')

      if brand_element
        brand_string = brand_element.inner_html
        brand_name = brand_string.strip
        brand = Brand.find_or_create_by!(name: brand_name)
        attributes[:brand] = brand
      end

      # thumbnail
      thumbail_element = doc.at('#landingImage')
      thumbnail_url = thumbail_element['src'] if thumbail_element

      if thumbnail_url
        thumbnail = URI.open(thumbnail_url)
        attributes[:thumbnail] = ActiveStorage::Blob.create_and_upload!(io: thumbnail, filename: "thumbnail_#{Time.now.to_i}")
      end

      # asin
      asin = url.match(%r{dp/([^/]+)/})&.captures&.first
      attributes[:asin] = asin

      return attributes
    end

    def self.save_to_product(url, product)
      begin
        attributes = get_attributes(url)
        product.update(attributes)
      rescue StandardError => e
        Rails.logger.error("Error in save_to_product: #{e.message}")
        Rails.logger.error(e.backtrace.join("\n"))
      end
    end
  end
end
