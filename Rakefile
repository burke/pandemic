# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rcov/rcovtask' 
require 'metric_fu'
require 'rcov'
require 'rcov/rcovtask' 

Rcov::RcovTask.new do |t| 
  t.libs << "test" 
  t.test_files = FileList['test/*_test.rb'] 
  t.verbose = true 
end
 
namespace :test do 
  namespace :coverage do 
    desc "Delete aggregate coverage data." 
    task(:clean) { rm_f "coverage.data" } 
  end 

  desc 'Aggregate code coverage for unit, functional and integration tests' 
  task :coverage => "test:coverage:clean" 
  #%w[unit functional integration].each do |target| 

  %w[unit functional].each do |target| 
   namespace :coverage do 
      Rcov::RcovTask.new(target) do |t| 
        t.libs << "test" 
        t.test_files = FileList["test/#{target}/*_test.rb"] 
        t.output_dir = "test/coverage/#{target}" 
        t.verbose = true 
        t.rcov_opts << '--rails --aggregate coverage.data'
      end 
    end 
    task :coverage => "test:coverage:#{target}" 
  end 
end 

namespace :cache do
  desc 'Sweep Static Page Cache'
  task :sweep => :environment do
    puts "Sweeping Cache..."
    StaticSweeper.sweep
  end
end

require 'tasks/rails'


