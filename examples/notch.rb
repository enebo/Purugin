class NotchPlugin
  include Purugin::Plugin, Purugin::Colors
  description 'Notch', 0.1
#  gem 'multi_json'
#  gem 'faraday'
  gem 'twitter'

  def on_enable
    public_command('notch', 'tweets', '/notch') do |me, *|
      require 'twitter'
      Twitter.user_timeline("notch")[0..4].each do |t|
        me.msg colorize("{green}@notch {white}#{t.text}")
      end
    end
  end
end
