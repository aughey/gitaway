class RepositoriesController < ApplicationController
  before_filter :authenticate
  def new
  end

  def show
    @r ||= Repository.find(params[:id])
    raise "Cannot see" unless @r.user == current_user
    @branch = params[:branch]
    @branch ||= 'master'
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
  end

  def tree
    @r ||= Repository.find(params[:id])
    raise "Cannot see" unless @r.user == current_user
    @grit = @r.grit
    @tree = @grit.tree(params[:treeid])
  end

  def blob
    @r ||= Repository.find(params[:id])
    raise "Cannot see" unless @r.user == current_user
    @branch ||= params[:branch]
    @grit = @r.grit
    @blob = @grit.blob(params[:blobid])
    raise "not a blob" unless @blob.is_a?(Grit::Blob)
  end

  def commits
    @r ||= Repository.find(params[:id])
    raise "Cannot see" unless @r.user == current_user
    @branch = params[:branch]
    @grit = @r.grit
    @commits = @grit.commits(@branch)
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
