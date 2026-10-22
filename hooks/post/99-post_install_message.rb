# Puppet status codes say 0 for unchanged, 2 for changed succesfully
if [0, 2].include? @kafo.exit_code
  success_message

  new_install_message(@kafo) if module_enabled?('install_web') && new_install?

  File.write(success_file, '') if !app_value(:noop) && new_install?
else
  failure_message
end

log_message(@kafo)
