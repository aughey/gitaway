class Forkid < ActiveRecord::Migration
  def self.up
    add_column :repositories,:fork_id,:integer,:default => nil
  end

  def self.down
  end
end
