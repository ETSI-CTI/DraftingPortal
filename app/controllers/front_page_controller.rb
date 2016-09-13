class FrontPageController < ApplicationController

  respond_to :html, only: :index

  def index; end

  def sidebar
    render layout: "sidebar"
  end

end
