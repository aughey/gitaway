require './config/environment.rb'

Repository.destroy_all
system("rm -rf ./REPOS/*.git")

u = User.find(:first)

for d in ARGV
  if File.exists?("#{d}/.git")
    puts "Importting git from #{d}"
    r = u.repositories.create(:name => File::basename(d))
    g = Grit::Repo.new(d)
    for b in g.branches
      system("cd #{d} ; git push /home/jha/src/current/mygithub/REPOS/#{r.id}.git #{b.name}")
    end
  end
end
