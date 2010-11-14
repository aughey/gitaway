require './config/environment.rb'

u = User.find(:first)

for d in ARGV
  if File.exists?("#{d}/.git")
    puts "Importting git from #{d}"
    r = u.repositories.create(:name => File::basename(d))
    system("cd #{d} ; git push /home/jha/src/current/mygithub/REPOS/#{r.id}.git master")
  end
end
