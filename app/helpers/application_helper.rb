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

  def show_meta_tags
    assign_meta_tags if display_meta_tags.blank?
    display_meta_tags
  end

  def assign_meta_tags(options = {})
  defaults = t('meta_tags.defaults')
  options.reverse_merge!(defaults)

    site = options[:site]
    title = options[:title]
    description = options[:description]
    keywords = options[:keywords]
    image = options[:image].presence || image_url('icodeOgp.webp')

    configs = {
      separator: '|',
      reverse: true,
      site: site,
      titile: title,
      description: description,
      keywords: keywords,
      canonical: request.original_url,
      favicon: image_url('favicon.ico'),
      og: {
        type: 'website',
        title: title,
        url: request.original_url,
        image:,
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary',
        # site: '@ツイッターのアカウント名',
      }
    }
    set_meta_tags(configs)
  end
end
