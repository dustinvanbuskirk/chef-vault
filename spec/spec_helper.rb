require 'chefspec'
require 'chefspec/berkshelf'
require 'allure-rspec'

RSpec.configure do |config|
    config.include AllureRSpec::Adaptor # Export Allure Reports
end

AllureRSpec.configure do |c|
    c.output_dir = "/codefresh/volume/allure-results"
    c.clean_dir = false
end

at_exit { ChefSpec::Coverage.report! }
