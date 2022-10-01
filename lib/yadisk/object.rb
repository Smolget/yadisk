# frozen_string_literal: true

require "ostruct"

module Yadisk
  class Object < OpenStruct
    def initialize(attributes)
      super to_ostruct(attributes)
    end

    # Convert Array or Hash to OpenStruct
    def to_ostruct(obj)
      case obj
      when Hash
        # rubocop:disable Style/HashTransformValues
        OpenStruct.new(obj.map {|key, val| [key, to_ostruct(val)] }.to_h)
        # rubocop:enable Style/HashTransformValues
      when Array
        obj.map {|o| to_ostruct(o) }
      else
        obj
      end
    end
  end
end
