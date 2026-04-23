local platform = require('utils.platform')

local options = {
   default_prog = {},
   launch_menu = {},
}

if platform.is_win then
   local nu_integration_fix_cmd =
      '$env.config = ($env.config | upsert shell_integration.osc133 false)'
   local windows_powershell = { 'pwsh', '-NoLogo', '-NoProfile' }
   local fallback_powershell = { 'powershell.exe', '-NoLogo', '-NoProfile' }

   options.default_prog = windows_powershell
   options.launch_menu = {
      { label = 'Windows PowerShell', args = windows_powershell },
      { label = 'Windows PowerShell 5.1', args = fallback_powershell },
      { label = 'Command Prompt', args = { 'cmd.exe' } },
      { label = 'Fish', args = { 'fish', '-l' } },
      { label = 'Nushell', args = { 'nu', '-l', '-e', nu_integration_fix_cmd } },
      { label = 'Msys2', args = { 'ucrt64.cmd' } },
      { label = 'Git Bash', args = { 'bash' } },
   }
elseif platform.is_mac then
   options.default_prog = { '/opt/homebrew/bin/fish', '-l' }
   options.launch_menu = {
      { label = 'Bash', args = { 'bash', '-l' } },
      { label = 'Fish', args = { '/opt/homebrew/bin/fish', '-l' } },
      { label = 'Nushell', args = { '/opt/homebrew/bin/nu', '-l' } },
      { label = 'Zsh', args = { 'zsh', '-l' } },
   }
elseif platform.is_linux then
   options.default_prog = { 'fish', '-l' }
   options.launch_menu = {
      { label = 'Bash', args = { 'bash', '-l' } },
      { label = 'Fish', args = { 'fish', '-l' } },
      { label = 'Zsh', args = { 'zsh', '-l' } },
   }
end

return options
