class RepositoriesController < ApplicationController
  before_filter :authenticate
  def new
  end

  def show
    @branch = 'master'
    show_tree
  end

  def show_tree
    @r ||= Repository.find(params[:id])
    raise "Cannot see" unless @r.user == current_user
    @branch ||= params[:branch]
    @grit = @r.grit
    @head = @grit.get_head(@branch)
    @commit = @head.commit
    @tree = @commit.tree
    if params[:path]
      @tree = @tree / params[:path]
    end
    @path = params[:path] ? "/" + params[:path] : ""
    render :action => 'show'
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
