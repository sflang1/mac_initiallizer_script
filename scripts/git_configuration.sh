#!/usr/bin/env bash
main(){
  echo 'Git configuration in this device'
  while [ -z $name ]
  do
    read -p "Introduce your name. This is mandatory. " name
  done
  git config --global user.name "$name"
  while [ -z $email ]
  do
    read -p "Introduce your email. This is mandatory. " email
  done
  git config --global user.email "$email"
}
main "$@"
