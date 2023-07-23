#!/bin/bash

ansible_config="https://github.com/Nos43ratu/ansible"

pretty_print() {
  get_color() {
    case "$1" in
      error)   echo -e "\033[0;31m" ;;
      success) echo -e "\033[0;32m" ;;
      info)    echo -e "\033[0;33m" ;;
      *)       echo -e "\033[0m"    ;;
    esac
  }

  get_icon() {
    case "$1" in
      error)   echo -e "✖" ;;
      success) echo -e "✔" ;;
      info)    echo -e "➜" ;;
      *)       echo -e "?" ;;
    esac
  }

  local color=$(get_color "$1")
  local icon=$(get_icon "$1")
  local message="${2:-$1}"
  local timestamp=$(date +"%H:%M:%S")

  echo -e "$color[$timestamp] $icon $message"

  [ "$1" = "error" ] && return 1 || return 0
}

install_brew() {
  pretty_print "info" "Installing Homebrew..."

  if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    pretty_print "success" "Homebrew installed successfully!"

    if [ ! -f ~/.zshrc ]; then
      pretty_print "info" "Adding Homebrew to PATH..."
      
      touch ~/.zshrc
      echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
  else
    pretty_print "success" "Homebrew already installed!"
  fi
}

install_ansible() {
  pretty_print "info" "Installing Ansible..."

  if ! command -v ansible &> /dev/null; then
    brew install ansible

    pretty_print "success" "Ansible installed successfully!"
  else
    pretty_print "success" "Ansible already installed!"
  fi
}

clone_repo() {
  pretty_print "info" "Cloning Ansible repository..."

  if [ ! -d ~/ansible ]; then
    git clone $ansible_config ~/ansible

    pretty_print "success" "Ansible repository cloned successfully!"
  else
    pretty_print "success" "Ansible repository already cloned!"
  fi
}

run_playbook() {
  pretty_print "info" "Running Ansible playbook..."

  ansible-playbook ~/ansible/playbook.yml

  pretty_print "success" "Ansible playbook ran successfully!"
}

clean_up() {
  pretty_print "info" "Cleaning up..."

  rm -rf ~/ansible
  rm -rf ~/macos_setup.sh

  pretty_print "success" "Clean up completed!"
}

install_brew
install_ansible
clone_repo
run_playbook
clean_up

exit 0