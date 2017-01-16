require 'helpers/module_constants'

class ChangeRequest
  include ActiveModel::Model

  attr_accessor *%i{
    id
    name
    author
    specification
    title
    status
    last_edited_by
    comment
    updated_at
    contributed_at
  }

  module Status
    extend Helpers::ModuleConstants

    define %i{
      drafting
      contributed
      accepted
      not_accepted
      implemented
    }
  end

  def friendly_id
    specification.gsub(" ", "-")
  end

end
