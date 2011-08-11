namespace :db do
  namespace :test do
    task :prepare => :environment do
      puts "Running db:seed"
      Rake::Task["db:seed"].invoke
    end
  end
end
