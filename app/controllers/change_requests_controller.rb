class ChangeRequestsController < ApplicationController

  layout "default"

  before_action :set_service

  respond_to :html, only: %i{ index contributions }

  def index
    @change_requests = @service.find_by_user(current_user)
    respond_with(@change_requests)
  end

  def new
    # no params
  end

  def edit
    # no params
  end

  def add_existing
    # no params
  end

  def contributions
    @contributions = @service.contributions_for(
      specification: params[:id]
    )
    respond_with(@contributions)
  end

  private

  def set_service
    @service = ChangeRequestService.new
  end

end
