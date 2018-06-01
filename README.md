# Dotfiles

Installation:

```
git clone https://github.com/duckinator/dotfiles.git ~/dotfiles && \
pushd ~/dotfiles && \
gem install effuse && \
effuse && \
popd
```

Update, if no files have been added or removed:

```
pushd ~/dotfiles && git pull && popd
```

Update, if files _have_ been added or removed:

```
pushd ~/dotfiles && effuse -c && git pull && effuse && popd
```
