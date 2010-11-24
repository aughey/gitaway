class SshKey < ActiveRecord::Base
  belongs_to :user
  def after_create
    SshKey::generate_authorized_keys
  end

  def self.generate_authorized_keys
    File.open("#{ENV['HOME']}/.ssh/authorized_keys","w") do |f|
      auth = Dir.pwd + "/gitaway-serve"
      for k in SshKey.find(:all) do
        f.puts "command=\"#{auth} #{k.user_id}\",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty " + k.key
      end
    end
  end
end
