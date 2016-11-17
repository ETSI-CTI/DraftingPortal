class Contribution
  include ActiveModel::Model

  attr_accessor *%i{
    status
    author
    specification
    date
    up_votes
    down_votes
  }

  def friendly_id
    specification.gsub(" ", "-")
  end

end
