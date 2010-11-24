class CreateGitCommands < ActiveRecord::Migration
  def self.up
    create_table :git_commands do |t|
      t.string 'in_command'
      t.string 'out_command'
      t.integer 'user_id'
      t.integer 'repository_id'
      t.timestamps
    end
  end

  def self.down
    drop_table :git_commands
  end
end
