require 'java'

module org::bukkit::command::CommandSender
  def msg(message) # WTF why doesn't alias work
    send_message(message)
  end
end
