# Install jruby-openssl, bouncy-castle-java, and twitter in mc gems dir
require 'rubygems'
gem 'jruby-openssl'
require 'twitter'

class NotchPlugin
  include Purugin::Plugin, Purugin::Colors
  description 'Notch', 0.1

  def on_enable
    public_command('notch', 'tweets', '/notch') do |me, *|
      Twitter.user_timeline("notch")[0..4].each do |t|
        me.msg colorize("{green}@notch {white}#{t.text}")
      end
    end
  end
end
