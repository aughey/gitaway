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
    if @head
      @commit = @head.commit
      @tree = @commit.tree
    end
    if params[:path]
      @tree = @tree / params[:path]
    end
    @path = params[:path] ? "/" + params[:path] : ""
    render :action => 'show'
  end

  def blob
    @r ||= Repository.find(params[:id])
    raise "Cannot see" unless @r.user == current_user
    @branch ||= params[:branch]
    @grit = @r.grit
    @head = @grit.get_head(@branch)
    @commit = @head.commit
    @tree = @commit.tree
    if params[:path]
      @path = params[:path]
      @blob = @tree / params[:path]
    else
      @path = ""
    end
    raise "not a blob" unless @blob.is_a?(Grit::Blob)
  end

  def commits
    @r ||= Repository.find(params[:id])
    raise "Cannot see" unless @r.user == current_user
    @branch ||= params[:branch]
    @grit = @r.grit
    @commits = @grit.commits
  end

  def commit
    @r ||= Repository.find(params[:id])
    raise "Cannot see" unless @r.user == current_user
    @grit = @r.grit
    @commit = @grit.commit(params[:commit])
  end

  def create
    r = Repository.new(params[:repository])
    r.user = current_user

    r.save!

    redirect_to r
  end
end
