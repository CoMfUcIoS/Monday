# Run and use ai models locally Free and without internet

## In your terminal

### Install

#### Install zsh_local_ai plugin

```bash
cp -r zsh-local-ai ~/.oh-my-zsh/custom/plugins/
```

#### Using oh-my-zsh edit ~/.zshrc

Where plugins=() add zsh-local-ai to the list
Add a key binding to create_completion function

```bash
......
plugins=(....... zsh-local-ai .......)

bindkey '^X' create_completion
```

#### Reload zsh

```bash
source ~/.zshrc
```

#### Run local api in docker
Wont demonize the process, so you can see the logs (Also debug mode is on)

```bash
make start
```

#### Fetch the models
This will take a while to download the models for the first time

```bash
make get_models
```

### Make your first request
That will take a while to load the model for the first time

```bash
make test
```
