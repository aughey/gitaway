class Repo < ActiveRecord::Migration
  def self.up
    add_column :repositories, :name, :text
    add_column :repositories, :user_id, :integer
  end

  def self.down
  end
end
