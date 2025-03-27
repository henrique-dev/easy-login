RSpec.configure do |config|
  config.after(:suite) do
    FileUtils.rm_rf("#{Rails.root}/tmp/storage")
  end
end
