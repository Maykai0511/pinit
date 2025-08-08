# pinit
Init a C project,include dir: bin,  include, src, obj. And Makefile

## How to use

```bash
# 如果使用的是 bash
vim ~/.bashrc

# 如果用的是 zsh
vim ~/.zshrc
```

在文件最后加入

这里的路径是指 project_init.sh 的文件路径

```
# pinit
alias pinit="路径/project_init.sh"
```

然后重新加载资源

```bash
# bash
suorce ~/.bashrc

# zsh
suorce ~/.zshrc
```

然后使用命令就可以初始化了

会创建一个 XXX 的文件夹，里面包含初始化的内容

```bash
pinit XXX
```

