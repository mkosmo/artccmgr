# frozen_string_literal: true

unless Rails.env.production?

  namespace :spec do
    desc 'Run all specs and generate coverage report'
    task :coverage => :environment do
      ENV['COVERAGE'] = 'true'
      Rake::Task["spec"].execute
    end
  end

end
