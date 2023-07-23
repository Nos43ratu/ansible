# macos

- packages
    - telegram: `brew install --cask telegram`
    - slack: `brew install --cask slack`
    - spotifu: `brew install --cask spotify`
    - discord: `brew install --cask discord`
    - zoom: `brew install --cask zoom`
    - jetbrains: `brew install --cask jetbrains-toolbox`
    - docker: `brew install --cask docker`
    - iterm2: `brew install --cask iterm2`
    - visual-studio-code: `brew install --cask visual-studio-code`
    - google-chrome: `brew install --cask google-chrome`
    - firefox: `brew install --cask firefox`
    - sound-source: `brew install --cask soundsource` ??
    - oh-my-zsh: `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

- mkdir Projects forlder
- mkdir Projects/personal
- mkdir Projects/work
- add github configs
- nvm 
```yml
- name: Install nvm
    ansible.builtin.shell: >
      curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
      args:
    creates: "{{ ansible_env.HOME }}/.nvm/nvm.sh"

- name: Install correct version of Node
    shell: nvm install --lts

- name: Install pnpm
    ansible.builtin.shell: >
      curl -fsSL https://get.pnpm.io/install.sh | sh -
    args:
    creates: /usr/local/bin/pnpm

- name: Add pnpm to .zshrc
    ansible.builtin.shell: >
      echo 'export PATH="$HOME/.pnpm-global/bin:$PATH"' >> ~/.zshrc
    args:
    creates: ~/.zshrc
- name: Add pnpm alias p
    ansible.builtin.shell: >
      echo 'alias p="pnpm"' >> ~/.zshrc
    args:
    creates: ~/.zshrc
```

- yarn ansible corepack ?????
    - corepack enable
    - corepack prepare yarn@stable --activate

- zsh plugins

```yml
- name: zsh-autosuggestions
  ansible.builtin.git:
    repo: "https://github.com/zsh-users/zsh-autosuggestions.git"
    dest: "~/.oh-my-zsh/plugins/zsh-autosuggestions"

- name: zsh-syntax-highlighting
  ansible.builtin.git:
    repo: "https://github.com/zsh-users/zsh-syntax-highlighting.git"
    dest: "~/.oh-my-zsh/plugins/zsh-syntax-highlighting"

- name: zsh-completions
  ansible.builtin.git:
    repo: "https://github.com/zsh-users/zsh-completions"
    dest: "~/.oh-my-zsh/plugins/zsh-completions"

- name: zsh-history-substring-search
  ansible.builtin.git:
    repo: "https://github.com/zsh-users/zsh-history-substring-search"
    dest: "~/.oh-my-zsh/plugins/zsh-history-substring-search"

- name: enable plugins
  ansible.builtin.lineinfile:
    path: ~/.zshrc
    regexp: "^plugins="
    line: "plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions zsh-history-substring-search)"
```