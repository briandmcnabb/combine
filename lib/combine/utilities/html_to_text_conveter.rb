# TODO: Could we possibly pass in the node directly rather than the text, simply to only re-parse it?

require 'crazy_harry'
require 'loofah'

module Combine
  class HtmlToTextConveter
    Error = Class.new(StandardError)

    def initialize(html)
      raise Error.new("Cannot intialize with `nil'") unless @html = html
    end

    def to_text
      # Crazy Harry closes unclosed BRs and does some general cleanup of weak html
      @html = @html.gsub("<hr/>", '<br />')  # change HRs to BRs because crazy harry just gets rid of hrs
      @html = @html.gsub(/<br\s*\/?\s*>/i, ' <p>')

      # TODO: This line is responsible for the following exception:
      #       NoMethodError: undefined method `scrub!' for []:Nokogiri::XML::NodeSet
      @html = CrazyHarry.fragment(@html) rescue ""
      @html = @html.to_s.gsub(/<p>/i, ' <p>')
      @html = @html.gsub(/<br\s*>/i, ' <br/>')

      # Loofah doesn't handle unclosed BRs well.
      # NOTE: Keep one space at end of line because date extractor likes spaces.
      unless @html.nil?
        document = Loofah.fragment(@html)
        # TODO: This line is responsible for the following exception:
        #       NoMethodError: undefined method `scrub!' for []:Nokogiri::XML::NodeSet
        text = document.to_text.gsub(/\s*\n/, " \n") rescue ""
        CGI.unescapeHTML(text).strip
      end
    end

    def to_text_cached
      text = cache.fetch(@html)

      if text.nil?
        text = to_text
        cache.write(@html, text)
      end

      text
    end


  private

    def cache
      Combine.config.html_to_text_cache
    end
  end
end