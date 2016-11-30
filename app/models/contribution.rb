class Contribution
  include ActiveModel::Model

  attr_accessor *%i{
    status
    author
    specification
    date
    up_votes
    down_votes
    checked
  }

  def friendly_id
    specification.gsub(" ", "-")
  end

  def status_icon
    case status
    when :accepted then "fa-check-circle"
    when :noted then "fa-times-circle"
    else ""
    end
  end

  alias_method :checked?, :checked

end
