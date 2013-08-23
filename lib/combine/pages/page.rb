require 'loofah'

module Combine
  class Page
    Error = Class.new(StandardError)

    def self.fetch(uri)
      if uri.nil?
        NullPage.new
      else
        uri = URINormalizer.normalize(uri)
        req = open(uri)
        res = req.read
        self.new(uri, res)
      end
    end

    def initialize(uri, response)
      @uri      = uri
      @response = response
    end

    attr_reader :uri, :response


    def hexdigest
      @hexdigest ||= Digest::MD5.hexdigest(response)
    end


    def fragments_matching(selector)
      return [] if selector.blank?

      document.search(selector).map do |node|
        build_fragment(node, base_uri)
      end
    end

    def fragment_matching(selector)
      return NullPageFragment.new if selector.blank?
      node = document.search(selector).first
      build_fragment(node, base_uri)
    end

    def to_fragment
      build_fragment(document, base_uri)
    end


  private

    def base_uri
      @base_uri ||= document.search('base/@href').first || uri
    end

    def tidy_response
      @tidy_response ||= response.mb_chars.tidy_bytes.gsub(/<br\s*>/i, '<br/>').to_s
    end

    def document
      @document ||= begin
        document = Loofah.document(tidy_response)

        document.css('script, style').remove
        document.xpath('//comment()').remove
        document
      end
    end

    def build_fragment(node, base_uri)
      if node.nil?
        NullPageFragment.new
      else
        PageFragment.new(node, base_uri)
      end
    end
  end
end