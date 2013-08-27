# TODO: `to_text' doesn't seem to work very well or consistently.
#       Need to do some testing to see if and when `text' would
#       be a better option.

require 'crazy_harry'
require 'loofah'

module Combine
  class HtmlWinnower
    def initialize(nodes, opts={})
      @nodes = nodes
      set_cache opts.delete(:cache){ false }
    end

    def start
      @cache.fetch(@nodes.map(&:to_s).join) do
        normalize_nodes!
        text = @nodes.to_text

        unless text.nil?
          text = text.gsub(/\s*\n/, " \n")
          CGI.unescapeHTML(text).strip
        end
      end
    end


  private

    def set_cache(boolean)
      @cache = boolean ? Cache.new(Combine.config.html_to_text_cache) : Cache.new
    end

    def normalize_nodes!
      doc = CrazyHarry::Base.new
      doc.fragment = Loofah.fragment(nil)
      doc.fragment.children = @nodes
      doc.no_blanks!
      doc.convert_br_to_p!
      doc.dedupe!
      @nodes = doc.fragment
    end
  end
end