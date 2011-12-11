class HelloWorldPlugin
  include Purugin::Plugin
  description 'HelloWorld', 0.4
  
  def on_enable
    puts "hello world"
  end

  def on_disable
    puts "goodbye world"
  end
end
