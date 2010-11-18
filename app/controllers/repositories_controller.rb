class RepositoriesController < ApplicationController
  before_filter :authenticate
  def new
  end

  def show
    getr
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

  def fork
    getr
    r = Repository.create(:name => @r.name, :fork_id => @r.id, :user => current_user)

    r.fork_from(@r)
    
    redirect_to r
  end

  def tree
    getr
    @grit = @r.grit
    @tree = @grit.tree(params[:treeid])
  end

  def blob
    getr
    @branch ||= params[:branch]
    @grit = @r.grit
    @blob = @grit.blob(params[:blobid])
    raise "not a blob" unless @blob.is_a?(Grit::Blob)
  end

  def commits
    getr
    @branch = params[:branch]
    @grit = @r.grit
    @commits = @grit.commits(@branch)
  end

  def commit
    getr
    @grit = @r.grit
    @commit = @grit.commit(params[:commit])
  end

  def create
    r = Repository.new(params[:repository])
    r.user = current_user

    r.save!
    r.init_bare

    redirect_to r
  end

  protected
  def getr
    @r ||= Repository.find(params[:id])
    raise "Cannot see" unless @r.is_viewable_by?(current_user)
    if @r.user != current_user
      @contentclass = "notmine"
    end
    @r
  end
end
