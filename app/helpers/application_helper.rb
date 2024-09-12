module ApplicationHelper
  def flash_background_color(type)
    case type.to_sym
    when :notice then 'bg-teal-100 border-teal-500 text-teal-900'
    when :alert then 'bg-red-100 border-red-400 text-red-700'
    when :error then 'bg-orange-100 border-orange-500 text-orange-700'
    else 'bg-gray-500'
    end
  end

  def user_favorite_code_present?(code)
    user_signed_in? && current_user.favorites.find_by(code_id: code.id).present?
  end

  def user_favorite_code_nil?(code)
    user_signed_in? && current_user.favorites.find_by(code_id: code.id).nil?
  end

  def default_meta_tags
    {
      site: 'icode',
      title: 'コードストックアプリ iCode',
      # reverse: true,
      separator: '|',   #Webサイト名とページタイトルを区切るために使用されるテキスト
      description: 'iCodeでは、あなたのコードを簡単に保存、管理、共有できます。',
      keywords: 'icode,codestock',   #キーワードを「,」区切りで設定する
      canonical: request.original_url,   #優先するurlを指定する
      noindex: ! Rails.env.production?,
      icon: [                    #favicon、apple用アイコンを指定する
        { href: image_url('favicon.ico') },
        # { href: image_url('icon.jpg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
      ],
      og: {
        site_name: 'icode',
        title: 'コードストックアプリ iCode',
        description: 'iCodeでは、あなたのコードを簡単に保存、管理、共有できます。',
        type: 'website',
        url: request.original_url,
        image: image_url('icodeOgp.webp'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary',
        # site: '@ツイッターのアカウント名',
      }
      # fb: {
        # app_id: '自身のfacebookのapplication ID'
      # }
    }
  end
end
