if defined?(PryByebug)
  # Shortcuts for debugging
  Pry.commands.alias_command 's', 'step'       # step into
  Pry.commands.alias_command 'n', 'next'       # next line
  Pry.commands.alias_command 'f', 'finish'     # finish current frame
  Pry.commands.alias_command 'c', 'continue'   # continue until next breakpoint
end