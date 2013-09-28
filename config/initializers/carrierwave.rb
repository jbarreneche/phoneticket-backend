CarrierWave.configure do |config|
  if ENV['LOCAL_STORAGE']
    config.storage = :file
    config.asset_host = ActionController::Base.asset_host
  end
end
