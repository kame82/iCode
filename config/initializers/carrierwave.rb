require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  # if Rails.env.production? && !ENV["AWS_ACCESS_KEY_ID"].nil?  # 本番環境の場合はS3へアップロード
    config.storage :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory  = 'myicode' # バケット名
    config.fog_public = false
    config.asset_host = "https://s3.ap-northeast-1.amazonaws.com/myicode"
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['aws_access_key_id'], # アクセスキー
      aws_secret_access_key: ENV['aws_secret_access_key'], # シークレットアクセスキー
      region: 'ap-northeast-1', # リージョン
      path_style: true
    }
  # else # 本番環境以外の場合はアプリケーション内にアップロード
  #   config.storage :file
  #   config.enable_processing = false if Rails.env.test? || Rails.env.ci?
  # end
  raise "Missing required arguments: aws_access_key_id, aws_secret_access_key" unless ENV['aws_access_key_id'] && ENV['aws_secret_access_key']
end
