module Combine
  class PagePattern

    def initialize(pattern_hash, parent=OpenStruct.new(materialized_path: nil))
      @page_title, @value = *pattern_hash.first
      @parent = parent
    end

    attr_reader :page_title, :parent

    def sub_pages
      @sub_pages ||= @value['sub_pages'].map { |kv| build_sub_page(Hash[*kv]) }
    end

    def wrapper
      @value['wrapper']
    end

    def fields
      @fields ||= @value.fetch('fields'){ Hash.new }.inject({}) { |m,(k,v)| m[k] = FieldPattern.new(v); m }
    end

    def uri_selector
      @value['uri_selector']
    end

    def materialized_path
      @materialized_path ||= [parent.materialized_path, @page_title].compact.join('|')
    end

    def next_page_link
      @value['next_page_link']
    end



  private

    def build_sub_page(pattern_hash)
      self.class.new(pattern_hash, self)
    end
  end
end