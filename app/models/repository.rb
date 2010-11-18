class Repository < ActiveRecord::Base
  belongs_to :user
  has_many :git_commands

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

  def init_bare
    FileUtils.mkdir_p(git_path)
    system("cd #{git_path} ; git init --bare")
  end

  def fork_from(other)
    # FileUtils.mkdir_p(git_path)
    system("git clone --bare --shared #{other.git_path} #{git_path}")
  end

  def git_path
    Dir.pwd + "/REPOS/#{id}.git"
  end

  def url
    "ssh://#{ENV['USER']}@localhost#{git_path}"
  end
end
