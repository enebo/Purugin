require 'java'

module org::bukkit::command::CommandSender
  def msg(*messages) # WTF why doesn't alias work
    messages.each do |message|
      send_message(message)
    end
  end
end
