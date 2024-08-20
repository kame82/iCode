require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.production? && !ENV["S3_ACCESS_KEY_ID"].nil?  # 本番環境の場合はS3へアップロード
    config.storage :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory = 'myicode'
    config.fog_public = false
    config.asset_host = "https://s3.ap-northeast-1.amazonaws.com/myicode"
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: 'ap-northeast-1',
      path_style: true
    }
  else # 本番環境以外の場合はアプリケーション内にアップロード
    config.storage :file
    config.enable_processing = false if Rails.env.test? || Rails.env.ci?
  end
end
