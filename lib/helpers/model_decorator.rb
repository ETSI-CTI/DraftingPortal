require_relative 'decorator'

module Helpers
  class ModelDecorator
    include Decorator

    def initialize(model)
      @object = model
    end

    def errors
      object.errors
    end

    def valid?(*args)
      object.valid? && super
    end

    def save(*args)
      return false unless valid?
      object.save(*args)
    end

  end
end
