# TODO ###########################################################
#  1.) `to_text' doesn't seem to work very well or consistently.
#       Need to do some testing to see if and when `text' would
#       be a better option.
#  2.)  Set the default cache object in the config instead of here.
#       Replace `Hash.new' with `Combine.config.html_winnower_cache'
#       Create a NullCache (blackbox) to be the default.

require 'crazy_harry'

module Combine
  class HTMLWinnower
    include ProtoConfig

    def initialize(nodes)
      @nodes = nodes
    end

    def start
      cache.fetch(key){ cache[key] = winnow(@nodes) }
    end


  private

    def cache
      @cache ||= config.fetch(:cache) { Hash.new }
    end

    def winnow
      normalize_nodes!
      text  = @nodes.to_text

      unless text.nil?
        text = text.gsub(/\s*\n/, " \n")
        CGI.unescapeHTML(text).strip
      end
    end

    def normalize!
      @nodes ||= begin
        doc = CrazyHarry::Base.new
        doc.fragment = Loofah.fragment(nil)
        doc.fragment.children = nodes
        doc.no_blanks!
        doc.convert_br_to_p!
        doc.dedupe!
        doc.fragment
      end
    end

    def key
      @key ||= Digest::MD5.hexdigest(@nodes.map(&:to_s).join)
    end
  end
end