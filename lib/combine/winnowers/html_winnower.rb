require 'crazy_harry'
require 'loofah'

module Combine
  class HtmlWinnower
    def initialize(nodes)
      @doc = CrazyHarry::Base.new
      @doc.fragment = Loofah.fragment(nil)
      @doc.fragment.children = nodes
      @doc.no_blanks!
      @doc.convert_br_to_p!
      @doc.dedupe!
    end

    def to_text
      text = @doc.fragment.to_text # TODO: `to_text' doesn't seem to work very well. This should probably just be `text'

      unless text.nil?
        text = text.gsub(/\s*\n/, " \n")
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





# ##### Monkey Patches #####
#
# # Monkey-patch to overcome this bug: https://github.com/flavorjones/loofah/issues/38
# class Nokogiri::XML::Text
#   include Loofah::ScrubBehavior::Node
# end
# class Nokogiri::XML::Comment
#   include Loofah::ScrubBehavior::Node
# end
# class Nokogiri::XML::NodeSet
#   include Loofah::ScrubBehavior::NodeSet
# end
#
# # Monkey-patching bug with add_next_sibling in scrubber
# class Loofah::Scrubbers::NewlineBlockElements
#   def scrub(node)
#     return CONTINUE unless Loofah::Elements::BLOCK_LEVEL.include?(node.name) or node.name == 'br'   # BRs need linebreaks too
#     node.replace Nokogiri::XML::Text.new("\n#{node.content}\n", node.document)
#
#     # NOTE: This code doesn't seem to work in the JRuby version of Loofah
#     # node.add_next_sibling Nokogiri::XML::Text.new("\n#{node.content}\n", node.document)
#     # node.remove
#   end
# end
#
#
# # Allow open-uri to follow unsafe redirects (i.e. https to http).
# # Relevant issue:
# # http://redmine.ruby-lang.org/issues/3719
# # Source here:
# # https://github.com/ruby/ruby/blob/trunk/lib/open-uri.rb
# module OpenURI
#   # this is taken from the original ruby open-uri class,
#   # fixed this to support secure socket http redirects:
#   def OpenURI.redirectable?(uri1, uri2) # :nodoc:
#     # This test is intended to forbid a redirection from http://... to
#     # file:///etc/passwd, file:///dev/zero, etc.  CVE-2011-1521
#     # https to http redirect is also forbidden intentionally.
#     # It avoids sending secure cookie or referer by non-secure HTTP protocol.
#     # (RFC 2109 4.3.1, RFC 2965 3.3, RFC 2616 15.1.3)
#     # However this is ad hoc.  It should be extensible/configurable.
#     uri1.scheme.downcase == uri2.scheme.downcase || (/\A(?:http|https|ftp)\z/i =~ uri1.scheme && /\A(?:http|https|ftp)\z/i =~ uri2.scheme)
#   end
# end