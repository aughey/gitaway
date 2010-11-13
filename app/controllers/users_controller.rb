class UsersController < ApplicationController
  before_filter :authenticate
  def index
  end
end
