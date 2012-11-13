# encoding: utf-8
module LiteHome
  module ApplicationHelper
    def title(title)
      content_for :title do
        "#{LiteHome.site_name} - " + title
      end
    end
    
    def display_flash
      result = ''
      if LiteHome.display_flash_message
        flash.each do |key, msg|
          result << content_tag(:div, (link_to('×', '#', class: 'close', 'data-dismiss' => 'alert') + content_tag(:strong, t("flash.#{key}")) + ' : ' + msg), class: "alert alert-#{key}")
        end
      end
      result.html_safe
    end

    def display_icon(icon)
      content_tag(:i, '', class: "icon-#{icon}")
    end
    
    def display_label(text, css = '')
      content_tag(:span, text, class: "label #{css}")
    end
    
    def display_badge(count, *args)
      options = args.extract_options!
      options[:min] ||= 15
      options[:max] ||= 30
      badge_class = '' if count == 0
      badge_class = 'badge-info' if count > 0 && count <= options[:min]
      badge_class = 'badge-warning' if count > options[:min] && count <= options[:max]
      badge_class = 'badge-important' if count > options[:max]
      content_tag(:span, count, class: "badge #{badge_class}")
    end    
    
    def display_breadcrumb
      path = display_icon('home')
      path << content_tag(:li, link_to(LiteHome.site_name, '/'))
      case controller_name
      when 'sessions'
        case action_name
        when 'index' then path << divider << t('lite_home.common.online_users')
        when 'new' then path << divider << t('lite_home.actions.login')
        end
      when 'registers'
        path << divider << t('lite_home.actions.register')
      when 'password_resets'
        case action_name
        when 'new','create' then path << divider << t('lite_home.actions.forgot_password')
        when 'edit','update' then path << divider << t('lite_home.actions.reset_password')
        end
      when 'profile'
        path << divider << t('lite_home.common.my_profile')
      end
      result = content_tag(:ul, class: 'breadcrumb') do
        content_tag(:li) do
          path
        end
      end
      result.html_safe
    end
    
    def divider
      content_tag(:span, '/', class: 'divider')
    end
    
    def display_user_avatar(user, type = 'min')
      image = user.avatar.url(type) || "lite_home/#{type}_avatar.gif"
      image_tag(image)
    end
    
    def display_user_image(user, size = '48x48')
      image = user.image || 'lite_home/user.gif'
      image_tag(image, size: size)
    end
  end
end
