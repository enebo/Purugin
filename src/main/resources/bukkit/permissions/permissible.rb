require 'java'

# Something which can have permissions associated with it.
module org::bukkit::permissions::Permissible
  # Does the user have permission for the specified permission
  def permission?(value)
    has_permission value
  end

  # permission_set? (isPermissionSet) done automatically by JI
  # permission_set? tells whether any permission has been explicitly set or not
end

