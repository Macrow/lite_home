# LiteHOME

LiteHOME is a simple user center, it's a mountable engine.

## Installation and usage

### Add this to your Gemfile

```ruby
  gem 'lite_home', :git => 'git://github.com/Macrow/lite_home.git'
```

### Run "bundle" command.

```bash
  bundle
```

### Run LiteHOME's install command.

```bash
  rails g lite_home:install
```

### Migrate you database:

```bash
  rake db:migrate
```

By default, LiteHOME will be mounted at '/home' in your rails application.

## Configuration

```ruby
LiteHome.config do |home|
  home.site_name = 'Lite'
  home.site_domain = 'www.yourdomain.com'
  home.admin_email = 'notifications@example.com'
  home.layout_name = 'lite_layout'
  home.display_flash_message = true
  home.users_per_page = 10
  home.users_avatar_max_size = 300
  home.users_avatar_middle_size = 100
  home.users_avatar_min_size = 50
end
```

## Administration

You can access '/home/admin' for LiteHOME's administration if the user is administrator.
The initial account is (name: admin, password: admin).

## License

This project rocks and uses MIT-LICENSE.


# LiteHOME中文文档

LiteHOME是一个简单的用户中心程序，它提供注册、登陆、用户管理等功能，它是一个Mountable Engine。

## 安装和使用

### 将下列代码加入到你的Gemfile中

```ruby
  gem 'lite_home', :git => 'git://github.com/Macrow/lite_home.git'
```

### 运行"bundle"命令

```bash
  bundle
```

### 运行LiteHOME的安装命令

```bash
  rails g lite_home:install
```

### 更新你的数据库

```bash
  rake db:migrate
```

默认情况下，LiteHOME会挂载到'/home'目录下

## 配置

```ruby
LiteHome.config do |home|
  home.site_name = 'Lite'
  home.site_domain = 'www.yourdomain.com'
  home.admin_email = 'notifications@example.com'
  home.layout_name = 'lite_layout'
  home.display_flash_message = true
  home.users_per_page = 10
  home.users_avatar_max_size = 300
  home.users_avatar_middle_size = 100
  home.users_avatar_min_size = 50
end
```

## 后台管理

你可以通过'/home/admin'访问后台管理，当然，你必须是管理员才行。
管理员初始账号和密码：(名称: admin, 密码: admin)

## 许可

MIT-LICENSE.