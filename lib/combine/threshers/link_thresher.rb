# TODO: Expand functionality to accept a wide array of different input options (a tag w/ href, uri string, js)

module Combine
  class LinkThresher
    include ProtoConfig

    def start
      href = nodes.map {|node| node['href']}.compact.first
      URINormalizer.build(@fragment.base_uri, href).to_s unless href.nil?
    end
  end
end