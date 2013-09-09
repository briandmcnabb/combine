require "combine/version"

require "combine/config"
require "combine/factory"
require "combine/elevator"
require "combine/harvest"
require "combine/yield"
require "combine/uri_normalizer"

require "combine/reapers/reaper_factory"
require "combine/reapers/index_page_reaper"
require "combine/reapers/page_reaper"
require "combine/reapers/fragment_reaper"

require "combine/threshers/abstract_thresher"
require "combine/threshers/field_thresher"
require "combine/threshers/link_thresher"

require "combine/winnowers/html_winnower"

require "combine/pages/page"
require "combine/pages/null_page"
require "combine/pages/page_fragment"
require "combine/pages/null_page_fragment"

require "combine/patterns/page_pattern"
require "combine/patterns/field_pattern"
require "combine/patterns/selector_pattern"

module Combine
end