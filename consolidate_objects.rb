require './config/environment.rb'

for r in Repository.find(:all)
  r.set_alternate_directory
  r.consolidate_objects
end
