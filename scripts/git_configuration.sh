#!/usr/bin/env bash
main(){
  echo 'Git configuration in this device'
  echo 'Setting the user name and email'
  name=''
  email=''
  current_username_key_value=$(git config --list | grep user.name)  # Getting the list of the current
  current_email_key_value=$(git config --list | grep user.email)
  if [[ ! -z $current_username_key_value ]]; then
    equal_position=$(echo $current_username_key_value | sed -n "s/[=].*//p" | wc -c)
    current_user_name=${current_username_key_value:equal_position}
    equal_position=$(echo $current_email_key_value | sed -n "s/[=].*//p" | wc -c)
    current_email=${current_email_key_value:equal_position}
    echo "This is the set user name: $current_user_name"
    echo "This is the set user email: $current_email"
    read -p "Do you want to change them? " confirmation
    case $confirmation in
      [Nn]* )
        echo "The configuration will remain as it is."
        return
        ;;
    esac
  fi
  while [[ -z $name ]]
  do
    read -p "Introduce your name. This is mandatory. " name
  done
  git config --global --replace-all user.name "$name"
  while [[ -z $email ]]
  do
    read -p "Introduce your email. This is mandatory. " email
  done
  git config --global user.email "$email"

  # Configure the CRLF and LF automatically.
  # First of all, a little explanation. Windows (DOS systems) and Unix systems manage
  # the line endings in a different way. DOS uses a Carriage Return and Line Feed (CLRF),
  # while Unix uses just Line Feed (LF). Whenever someone alternates between a project in
  # DOS and Unix, the text editors change the line endings. Git offers a global configuration
  # for avoiding this issue. You can also use a .gitattributes file in the repo you're
  # creating with the appropiate configuration.
  # The options for the global configuration are
  # true - If you want that your line endings are automatically translated from LF to CLRF (specially for Windows)
  # input - If you want that your line endings are translated from CLRF to LF, but not the other way (specially for Mac)
  # false - If you don't want that any line endings are translated.
  git config --global core.autocrlf input
}
main "$@"
