require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.production? && !ENV["AWS_ACCESS_KEY_ID"].nil?  # 本番環境の場合はS3へアップロード
    Rails.logger.info "Using AWS S3 for storage"


    config.storage = :aws
    config.aws_bucket = 'myicode' # バケット名
    # config.aws_acl    = 'public-read'
    # The maximum period for authenticated_urls is only 7 days.
    config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7
    # Set custom options such agit s cache control to leverage browser caching
    config.aws_attributes = {
        expires: 1.week.from_now.httpdate,
        cache_control: 'max-age=604800'
    }
    config.aws_credentials = {
      access_key_id: ENV['S3_ACCESS_KEY_ID'], # アクセスキー
      secret_access_key: ENV['S3_SECRET_ACCESS_KEY'], # シークレットアクセスキー
      region: 'ap-northeast-1', # リージョン
  }


    # config.storage :fog
    # config.fog_provider = 'fog/aws'
    # config.fog_directory  = 'myicode' # バケット名
    # config.fog_public = false
    # config.asset_host = "https://s3.ap-northeast-1.amazonaws.com/myicode"
    # # config.asset_host = "https://myicode.s3.amazonaws.com"
    # config.fog_credentials = {
    #   provider: 'AWS',
    #   aws_access_key_id: ENV['S3_ACCESS_KEY_ID'], # アクセスキー
    #   aws_secret_access_key: ENV['S3_SECRET_ACCESS_KEY'], # シークレットアクセスキー
    #   region: 'ap-northeast-1', # リージョン
    #   path_style: true
    # }
  else # 本番環境以外の場合はアプリケーション内にアップロード
    config.storage :file
    config.enable_processing = false if Rails.env.test? || Rails.env.ci?
  end
end
