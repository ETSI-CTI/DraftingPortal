class IssuesController < ApplicationController
  layout "default"

  before_action :set_service

  respond_to :html

  def index
    @issues = @service.all
    respond_with(@issues)
  end

  private

  def set_service
    @service = IssueService.new
  end

end
