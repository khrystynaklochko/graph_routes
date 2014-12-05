require "rake/testtask"


task :run do
  system("ruby init.rb")
end

task :test do
  Rake::TestTask.new do |t|
    t.libs    << "spec"
    t.pattern =  "spec/*_spec.rb"
    t.warning =  true
    t.verbose =  true
  end
end


