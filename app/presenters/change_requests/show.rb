require 'helpers/model_decorator'

module ChangeRequests
  class Show < Helpers::ModelDecorator

    attr_reader :permissions

    def initialize(change_request:, permissions:)
      super(change_request)
      @permissions = permissions
    end

    def editable?
      permissions.include?(:edit)
    end

    def mergeable?
      permissions.include?(:merge)
    end

    def contributable?
      permissions.include?(:contribute)
    end

    def recontributable?
      permissions.include?(:recontribute)
    end

    def deleteable?
      permissions.include?(:delete)
    end

    def hideable?
      permissions.include?(:hide)
    end

    def applicable?
      permissions.include?(:apply)
    end

  end
end
