require 'helpers/module_constants'

class Issue
  include ActiveModel::Model

  attr_accessor *%i{
    id
    ticket_id
    specification
    branch
    summary
    associated_contributions
    status
  }

  module Status
    extend Helpers::ModuleConstants

    define %i{
      assigned
      monitored
      new
      workspace
    }
  end

end
