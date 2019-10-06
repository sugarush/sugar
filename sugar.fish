set github_url 'https://github.com'

function sugar-install -d 'Install a module from GitHub.'
  set -l module_info (string split ':' $argv[1])
  set -l module_repository $module_info[1]
  set -l module_name $module_info[2]
  set -l module_path $sugar_install_directory/modules/$module_repository/$module_name

  sugar-message title "Installing $argv[1] from GitHub."

  git clone $github_url/$module_repository/$module_name.git $module_path

  if ! test $status -eq 0
    sugar-message error "Install failed."
  end
end

function sugar-load -d 'Load a module from disk or install from GitHub then load from disk.'
  set -l module_info (string split ':' $argv[1])
  set -l module_repository $module_info[1]
  set -l module_name $module_info[2]
  set -l module_path \
    $sugar_install_directory/modules/$module_repository/$module_name

  if ! test -d $module_path
    sugar-install $argv
  end

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
