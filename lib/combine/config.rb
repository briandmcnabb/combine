require 'active_support/configurable'

module Combine
  def self.configure(&block)
    yield @config ||= Combine::Configuration.new
  end

  def self.config
    @config
  end


  class Configuration #:nodoc:
    include ActiveSupport::Configurable
    config_accessor :html_to_text_cache
    config_accessor :page_guard
    config_accessor :fragment_guard
    config_accessor :max_pages
    config_accessor :max_harvest
  end
end