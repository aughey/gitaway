class User < ActiveRecord::Base
  include Clearance::User
  has_many :repositories
  has_many :ssh_keys
  has_many :git_commands

  def to_s
    email
  end

  def name
    email.gsub(/[^a-zA-Z0-9]/,"")
  end
end
