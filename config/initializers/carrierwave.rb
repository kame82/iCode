require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

if Rails.env.production? || Rails.env.staging?
  unless ENV['RAILS_GROUPS'] == 'assets'
    CarrierWave.configure do |config|
      if Rails.env.production? && !ENV["S3_ACCESS_KEY_ID"].nil?  # 本番環境の場合はS3へアップロード
        config.storage :fog
        config.fog_provider = 'fog/aws'
        config.fog_directory  = 'myicode' # バケット名
        config.fog_public = false
        config.asset_host = "https://s3.ap-northeast-1.amazonaws.com/myicode"
        config.fog_credentials = {
          provider: 'AWS',
          aws_access_key_id: ENV['S3_ACCESS_KEY_ID'], # アクセスキー
          aws_secret_access_key: ENV['S3_SECRET_ACCESS_KEY'], # シークレットアクセスキー
          region: 'ap-northeast-1', # リージョン
          path_style: true
        }
      else # 本番環境以外の場合はアプリケーション内にアップロード
        config.storage :file
        config.enable_processing = false if Rails.env.test? || Rails.env.ci?
      end
    end
    raise "Missing required arguments: S3_ACCESS_KEY_ID, S3_SECRET_ACCESS_KEY" unless ENV['S3_ACCESS_KEY_ID'] && ENV['S3_SECRET_ACCESS_KEY']
  end
end
