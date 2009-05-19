namespace :db do
  desc 'Load the seed data from db/seeds.rb'
  task :seed => :environment do
    Dir["#{Rails.root}{/vendor/plugins/*/,}/db/seeds/*.rb"].each do |seed_file|
      if File.exist?(seed_file)
        seed_file[/\/db\/seeds\/(.+).rb/]
        puts "[seeding] #{$1.humanize}"
        load(seed_file)
      end
    end
  end
end
