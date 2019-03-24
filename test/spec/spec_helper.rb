require 'chefspec'
require 'chefspec/berkshelf'
require 'chefspec/cacher'
require 'allure-rspec'

RSpec.configure do |config|
  config.platform = 'ubuntu'
  config.version = '14.04'

  config.include AllureRSpec::Adaptor # Export Allure Reports

  config.color = true
  config.alias_example_group_to :describe_recipe, type: :recipe

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  Kernel.srand config.seed
  config.order = :random

  config.default_formatter = 'doc' if config.files_to_run.one?

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end
end

AllureRSpec.configure do |c|
    c.output_dir = "/codefresh/volume/allure-results"
    c.clean_dir = false
end

at_exit { ChefSpec::Coverage.report! }
