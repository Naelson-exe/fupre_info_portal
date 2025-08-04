require "yaml"

module YAML
  class << self
    alias_method :original_load, :load
    alias_method :original_load_file, :load_file

    def load(yaml, **kwargs)
      original_load(yaml, aliases: true, **kwargs)
    end

    def load_file(path, **kwargs)
      original_load_file(path, aliases: true, **kwargs)
    end
  end
end

ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup" # Set up gems listed in the Gemfile.
require "bootsnap/setup" # Speed up boot time by caching expensive operations.
