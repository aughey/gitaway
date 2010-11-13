class RepositoriesController < ApplicationController
  before_filter :authenticate
  def new
  end

  def show
    @r = Repository.find(params[:id])
    raise "Cannot see" unless @r.user == current_user
  end

  def create
    r = Repository.new(params[:repository])
    r.user = current_user

    r.save!

    FileUtils.mkdir_p(r.path)
    system("cd #{r.path} ; git init --bare")

    redirect_to r
  end
end
