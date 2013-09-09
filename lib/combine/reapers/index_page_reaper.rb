# TODO:
#  1.)  Need to figure out a way to output to an array in the event that a configurable
#       proc isnt provided.  Perhaps it can be passed in with the harvest object?
#  2.)  Look into the viability of the following.
#       def initialize(args={})
#         @uri = args.fetch(:uri){ raise Error.new('A uri must be provided') }
#         @pattern = args.fetch(:pattern){ raise Error.new('A uri must be provided') }
#       end
#  3.)  Write a macro for creating the dynamic object fetchers
#       (max_pages, _yield, fragment_reaper, link_thresher)

module Combine
  class IndexPageReaper
    include ProtoConfig
    proto_collaborators :_yield, :fragment_reaper, :link_thresher

    def initialize(uri, pattern)
      @uri     = uri
      @pattern = pattern
    end


    def start
      @current_page = Page.fetch(@uri)

      paginate do |page|
        page.fragments_matching(@pattern.wrapper).each do |fragment|
          Elevator << fragment_reaper.new(fragment, @pattern, _yield.new).start
        end
      end
    end


  private

    def paginate(&block)
      count = 0

      while (count += 1) <= @max_pages do
        block.call(@current_page)
        get_next_page or break
      end
    end

    def get_next_page
      uri = link_thresher.new(@current_page.to_fragment, @pattern.next_page_url).start

      unless uri.nil?
        @current_page = Page.fetch(uri)
      end
    end

    def max_pages
      @max_pages ||= config.fetch(:max_pages){ Combine.config.max_pages }
    end
  end
end