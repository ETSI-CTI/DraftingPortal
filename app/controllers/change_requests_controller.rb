class ChangeRequestsController < ApplicationController

  layout "default"

  before_action :set_service

  respond_to :html, only: %i{ index contributions }

  def index
    @change_requests = @service.find_by_user(current_user)
  end

  def show
    render text: params[:id]
  end

  def edit
    # no params
  end

  def contributions
    @contributions = @service.contributions_for(
      specification: params[:id]
    )
  end

  private

  def set_service
    @service = ChangeRequestService.new
  end

end
