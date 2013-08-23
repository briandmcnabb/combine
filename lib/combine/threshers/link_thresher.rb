module Combine
  class LinkThresher < AbstractThresher

    def start
      href = nodes.map {|node| node['href']}.compact.first
      build_uri(href)
    end


  private

    def build_uri(href)
      return  if href.nil?

      uri = href.strip
      uri = URI.encode(uri) unless uri.include?('%')
      uri = URI.join(@fragment.base_uri, uri).to_s
    end
  end
end