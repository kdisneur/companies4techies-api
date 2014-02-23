require 'ostruct'

class DeepStruct < OpenStruct
  def initialize(hash=nil)
    @table      = {}
    @hash_table = {}

    if hash
      hash.each do |key, value|
        @table[key.to_sym] = (value.is_a?(Hash) ? DeepStruct.new(value) : value)
        @hash_table[key.to_sym] = value

        new_ostruct_member(key)
      end
    end
  end

  def to_hash
    @hash_table
  end
end
