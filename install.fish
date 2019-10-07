set fish_config $HOME/.config/fish/config.fish

if ! test -f $fish_config
  echo '
set sugar_install_directory $HOME/.config/fish/sugar

source $sugar_install_directory/sugar.fish

set modules \
  sugar-core:developer \
  sugar-core:prompt \
  sugar-core:git \
  sugar-core:ssh \
  sugar-core:tmux

for module in $modules
  sugar-load $module
end
' > $fish_config
  exec fish
end
