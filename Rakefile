desc "Run"
task :run do
  sh "bundle exec rackup -p 3000 -o 0.0.0.0"
end

desc "Run (dev)"
task :dev do
  sh "rerun -s KILL -p \"**/*.{rb}\" -- bundle exec rackup -p 3000"
end

SASS_OPTS = "--sourcemap=none public/sass/style.sass:public/css/style.css"

desc "Setup"
task :setup do
  sh "sass #{SASS_OPTS}"
end

desc "Watch"
task :watch do
  sh "sass --watch #{SASS_OPTS}"
end


task default: :run
