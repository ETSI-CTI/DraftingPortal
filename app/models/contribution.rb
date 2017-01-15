class Contribution
  include ActiveModel::Model

  attr_accessor *%i{
    change_request_id
    status
    author
    name
    specification
    date
    up_votes
    down_votes
    comment
  }

  def friendly_id
    specification.gsub(" ", "-")
  end

  def status_icon
    case status
    when :accepted then "fa-check-circle"
    when :not_accepted then "fa-times-circle"
    else ""
    end
  end

end
