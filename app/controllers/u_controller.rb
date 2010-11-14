class UController < ApplicationController
  before_filter :authenticate
  def index
  end

  def show
    @user = User.find(params[:id])
  end
end
