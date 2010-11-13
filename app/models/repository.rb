class Repository < ActiveRecord::Base
  belongs_to :user

  def path
    "./REPOS/#{id}.git"
  end
end
