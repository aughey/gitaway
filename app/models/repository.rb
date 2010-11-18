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
    set_alternate_directory
  end

  def fork_from(other,branch = 'master')
    # FileUtils.mkdir_p(git_path)
    system("git clone --bare --shared -b #{branch} #{other.git_path} #{git_path}")
    set_alternate_directory
  end

  def set_alternate_directory
    begin
      File.open(alternates_file,"r") do |f|
        f.each_line do |line|
          if line.chomp == Repository::global_objects_directory
            return
          end
        end
      end
    rescue
    end

    File.open(alternates_file,"a+") do |f|
      f.puts Repository::global_objects_directory
    end
  end

  def consolidate_objects
    Dir.foreach(git_path + '/objects') do |f|
      next unless f.size == 2
      next if f == '..'
      globalpath = Repository::global_objects_directory + "/#{f}"
      Dir.mkdir(globalpath) unless File.directory?(globalpath)
      dir = git_path + '/objects/' + f
      Dir.foreach(dir) do |f2|
        next if f2 == '..' || f2 == '.'
        newpath = Repository::global_objects_directory + "/#{f}/#{f2}" 
        oldpath = dir + "/#{f2}"
        if  File.exists?(newpath)
          File.unlink(oldpath)
        else
          puts "Moving #{oldpath} to #{newpath}"
          File.rename(oldpath,newpath)
        end
      end
      Dir.rmdir dir
    end
  end

  def alternates_file
    git_path + '/objects/info/alternates'
  end

  def self.global_objects_directory
    Dir.pwd + "/OBJECTS"
  end

  def git_path
    Dir.pwd + "/REPOS/#{id}.git"
  end

  def url
    "ssh://#{ENV['USER']}@localhost#{git_path}"
  end
end
