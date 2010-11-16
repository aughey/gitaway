class Publicrepo < ActiveRecord::Migration
  def self.up
    add_column :repositories, :public, :boolean, :default => true
  end

  def self.down
  end
end
