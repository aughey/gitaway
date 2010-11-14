class Repository < ActiveRecord::Base
  belongs_to :user

  def to_s
    name
  end

  def path
    "/repositories/#{id}"
  end

  def grit
    @grit ||= Grit::Repo.new(git_path)
  end

  def after_create
    FileUtils.mkdir_p(git_path)
    system("cd #{git_path} ; git init --bare")
  end

  protected

  def git_path
    "./REPOS/#{id}.git"
  end
end
