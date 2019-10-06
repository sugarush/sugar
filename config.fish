set sugar_install_directory /Users/six/.sugar

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
