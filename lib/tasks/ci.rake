# task to quickly run the ci checks
# rake ci
# rake ci:lint
# rake ci:test
namespace :ci do

  # run the faster lint checks
  task :lint do
    sh 'bundle exec rubocop'
    sh 'bundle exec scss-lint'
    sh 'bundle exec brakeman'
    sh 'bundle exec bundle-audit'
  end

  # run the lint checks and tests
  task :test do
    Rake::Task['ci:lint'].invoke
    sh 'bundle exec rake parallel:spec'
  end
end

# default command
task :ci => ['ci:lint']
