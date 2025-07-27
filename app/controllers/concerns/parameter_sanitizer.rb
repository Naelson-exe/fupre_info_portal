module ParameterSanitizer
  extend ActiveSupport::Concern

  included do
    before_action :sanitize_parameters
  end

  private

  def sanitize_parameters
    traverse = ->(hash) do
      hash.each do |key, value|
        if value.is_a?(String)
          hash[key] = Sanitize.fragment(value)
        elsif value.is_a?(Hash)
          traverse.call(value)
        elsif value.is_a?(Array)
          value.each do |item|
            if item.is_a?(Hash)
              traverse.call(item)
            end
          end
        end
      end
    end
    traverse.call(params)
  end
end
