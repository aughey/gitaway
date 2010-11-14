class Publicrepo < ActiveRecord::Migration
  def self.up
    add_column :repositories, :public, :bool, :default => true
  end

  def self.down
  end
end
