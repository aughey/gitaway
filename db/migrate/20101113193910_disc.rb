class Disc < ActiveRecord::Migration
  def self.up
    add_column :repositories,:description,:text
  end

  def self.down
  end
end
