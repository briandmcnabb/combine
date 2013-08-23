Combine.configure do |config|
  config.html_to_text_cache  = ActiveSupport::Cache::MemoryStore.new(size: 4.megabytes, :expires_in => 1.hour)
end