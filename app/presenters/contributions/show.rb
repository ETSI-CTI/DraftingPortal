require 'helpers/model_decorator'

module Contributions
  class Show < Helpers::ModelDecorator

    attr_reader :checked

    def initialize(contribution, checked: false)
      super(contribution)
      @checked = checked
    end

    alias_method :checked?, :checked

  end
end
