class UController < ApplicationController
  before_filter :authenticate
  def index
    @users = User.find(:all)
  end

  def show
    @user = User.find(params[:id])
  end
end
