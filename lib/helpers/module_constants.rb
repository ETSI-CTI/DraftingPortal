module Helpers
  module ModuleConstants

    def all
      @_module_constants_hash ||= compute_hash
    end

    def define(symbols)
      symbols.each do |sym|
        const_set(
          sym.to_s.upcase,
          sym
        )
      end
    end

    def include?(symbol)
      to_set.include?(symbol.to_sym)
    end

    private

    def compute_hash
      {}.tap do |h|
        constants.each do |c|
          value = const_get(c)
          h[c] = value unless value.class == Module
        end
      end
    end

    def to_set
      @_module_constants_set ||= all.values.to_set
    end

  end
end
