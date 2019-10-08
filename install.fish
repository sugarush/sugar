set fish_config $HOME/.config/fish/config.fish

if ! test -d $HOME/.config/fish/sugar/modules
  mkdir -p $HOME/.config/fish/sugar/modules
end

if ! test -d $HOME/.config/fish/sugar/config
  mkdir -p $HOME/.config/fish/sugar/config
end

if ! test -f $fish_config
  echo '
set sugar_install_directory $HOME/.config/fish/sugar

source $sugar_install_directory/sugar.fish

set modules \
  sugar-core:developer \
  sugar-core:prompt \
  sugar-core:cd \
  sugar-core:git \
  sugar-core:ssh \
  sugar-core:tmux

for module in $modules
  sugar-load $module
end

sugar-on-load
' > $fish_config

  exec fish
end
