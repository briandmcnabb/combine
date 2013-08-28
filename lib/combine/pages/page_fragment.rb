require 'delegate'

module Combine
  class PageFragment < SimpleDelegator

    def initialize(node, base_uri)
      @delegate_sd_obj = node
      @base_uri = base_uri
    end

    attr_reader :base_uri

    def checksum
      @checksum ||= Digest::MD5.hexdigest(self.to_html)
    end

    def select(selector)
      case selector
      when nil
        []
      when 'SELF'
        convert_to_node_set
      else
        search(selector)
      end
    end


  private

    def convert_to_node_set
      Nokogiri::XML::NodeSet.new(self.document, [@delegate_sd_obj])
    end
  end
end