class User
  include ActiveModel::Model

  attr_accessor *%i{
    id
    first_name
    last_name
  }

  def full_name
    "#{first_name} #{last_name}"
  end

end
