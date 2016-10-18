class ChangeRequest
  include ActiveModel::Model

  attr_accessor *%i{
    id
    user
    author
    specification
    title
    status
    updated_at
    contributed_at
  }

end
