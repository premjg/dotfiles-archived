dep 'fish-main' do
  requires 'fish.managed'
  requires 'oh-my-fish'
  requires 'fish-config.rcfile'

  username = shell('whoami')

  met? do
   `sudo su - '#{username}' -c 'echo $SHELL'`.match(/fish/)
  end

  meet do
    shell "sudo chsh -s '#{which('fish')}' #{username}"
  end
end

dep 'fish.managed' do provides []; end

dep 'oh-my-fish' do
  met? do
    "~/.oh-my-fish".p.exists?
  end

  meet do
    shell "git clone https://github.com/premjg/oh-my-fish.git ~/.oh-my-fish"
  end
end

dep 'fish-config.rcfile' do
  def sym_file
    shell "mkdir -p ~/.config/fish/"
    "~/.config/fish/config.fish"
  end

  def real_file
    "~/.dotfiles/templates/rc-files/.fishrc"
  end
end
