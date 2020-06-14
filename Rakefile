require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task :test => [:lint, :spec]

task :lint do
  sh 'rubocop -l'
end

namespace :db do
  desc "Run migrations"
  task :migrate, [:version] do |_, args|
    require "sequel/core"
    Sequel.extension :migration
    version = args[:version].to_i if args[:version]
    Sequel.connect('sqlite://db/q16.db') do |db|
      Sequel::Migrator.run(db, "db/migrations", target: version)
    end
  end
end
