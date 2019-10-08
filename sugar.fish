set sugar_github_url 'https://github.com'
set sugar_on_load

function @sugar-load -d 'Run a function when the shell is loaded.'
  set -a sugar_on_load $argv[1]
end

function sugar-on-load -d 'Run functions in the sugar_on_load array.'
  for item in $sugar_on_load
    set item_split (string split ' ' $item)
    $item_split[1] $item_split[2..-1]
  end
end

function sugar-install -d 'Install a module.'
  set -l module_info (string split ':' $argv[1])
  set -l module_repository $module_info[1]
  set -l module_name $module_info[2]
  set -l module_path $sugar_install_directory/modules/$module_repository/$module_name

  sugar-message title "Installing $argv[1] from GitHub."

  git clone $sugar_github_url/$module_repository/$module_name.git $module_path

  if ! test $status -eq 0
    sugar-message error "Install failed."
  end
end

function sugar-load -d 'Load a module.'
  set -l module_info (string split ':' $argv[1])
  set -l module_repository $module_info[1]
  set -l module_name $module_info[2]
  set -l module_path \
    $sugar_install_directory/modules/$module_repository/$module_name

  source $module_path/*.fish $module_path
end

function sugar-message -d 'Print a formatted message.'
  set -l options $argv[1]
  set -l message $argv[2]

  set -l options_split (string split ':' $options)
  set -l options_type $options_split[1]
  set -l options_operation $options_split[2]

  if test -n "$options_operation"
    switch $options_operation
    case reprint
      printf '\e[2K\r'
    case '*'
      sugar-message 'error' "invalid message option: $options_operation"
      return
    end
  end

  switch $options_type
  case title
    set_color -o green
    echo -n '--> '
  case bold
    set_color -o magenta
    echo -n '==> '
  case error
    set_color -o red
    echo -n '--> '
  case info
    set_color normal
    echo -n '--> '
  case '*'
    sugar-message 'error' "invalid message type: $options_type"
    return
  end

  if test -n "$options_operation"
    switch $options_operation
    case reprint
      echo -n $message
      set_color normal
    end
  else
    echo $message
    set_color normal
  end
end

function sugar-reload -d 'Reload Fish.'
  exec fish
end

function reload -d 'Reload Fish.'
  exec fish
end
