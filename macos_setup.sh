#!/bin/bash

ansible_setup_file="https://raw.githubusercontent.com/Nos43ratu/ansible/main/macos_ansible.yml"

pretty_print() {
  printf "\n%b\n" "$1"
}

install_homebrew() {
  printf "Installing Homebrew..."
  
  if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    pretty_print "Homebrew installed successfully."

    if [ ! -f ~/.zshrc ]; then
      pretty_print "Putting Homebrew location earlier in PATH..."
      touch ~/.zshrc
      echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
  else
    echo "Homebrew is already installed."
  fi

  pretty_print "Updating Homebrew..."

  brew update
  
  pretty_print "Homebrew updated successfully."
}

install_ansible() {
  pretty_print "Installing Ansible..."

  if ! command -v ansible &> /dev/null; then
    brew install ansible
  else
    pretty_print "Ansible is already installed."
  fi

  pretty_print "Ansible installed successfully."
}

run_ansible_playbook() {
  pretty_print "Running Ansible playbook..."

  if [ -z "$1" ]; then
    echo "Please provide the raw URL of the Ansible playbook."
    exit 1
  fi

  pretty_print "Fetching Ansible playbook from: $1"
  curl -sLO "$1"
  playbook_file=$(basename "$1")

  pretty_print "Running Ansible playbook: $playbook_file"
  ansible-playbook "$playbook_file"

  pretty_print "Ansible playbook run successfully."

  pretty_print "Cleaning up..."
  rm "$playbook_file"
}

pretty_print "Setting up your Mac..."

install_homebrew

install_ansible

run_ansible_playbook "$ansible_setup_file"

pretty_print "All done!"
