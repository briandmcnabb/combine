module Combine
  class LinkThresher < AbstractThresher
    def start
      href = nodes.map {|node| node['href']}.compact.first
      URINormalizer.build(@fragment.base_uri, href).to_s unless href.nil?
    end
  end
end