require 'java'

class org::bukkit::command::Command
  # Tests the given _CommandSender_ to see if they can perform this command.
  # If they do not have permission, they will be informed that they cannot do this.
  # Note: this deviates from default behavior of test_permission since it will not
  # check perms if you are an operator  
  def permitted?(sender)
    sender.op? || test_permission(sender)
  end
end
