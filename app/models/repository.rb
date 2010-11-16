class Repository < ActiveRecord::Base
  belongs_to :user

  def to_s
    name
  end

  def is_viewable_by?(user)
    self.public || user == self.user
  end

  def forked?
    fork_id
  end

  def fork
    @fork ||= Repository.find(fork_id)
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

  def git_path
    "/home/jha/src/current/gitaway/REPOS/#{id}.git"
  end
end
