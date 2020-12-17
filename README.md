# 1.vim自定义快捷键
几种模式,normal visual insert select command-line/ex mode

普通模式输入`:`进入command-line，输入各种命令

命令组合,命令名字也有好几个段。map有这几种前缀:

* nore:表示递归。键a->键b,键c->键a，递归则c->b
* n:普通模式生效
* v:可是模式生效
* i:插入模式生效
* c:表示命令行模式生效

## 1.1 键表

* `<k0>-<k9>`小键盘0到9
* `<S-...>` shift+键
* `<C-...>`  control+键
* `<M-...>`或者`<A-...>` Alt+键或meta + 键
* `<Esc>`Escape键
* `<Up>` 光标上移动
* `<Space>` 插入空格
* `<Tab>` 插入Tab
* `<CR>` 等于`<Enter>`

## 1.2 普通映射命令

`:help map` 启用帮助信息

* 1.`map`:格式`:map {lhs} {rhs}`,将`{lhs}->{rhs}`,也可以递归
    * `:map td :tabnew .<cr>`n,v,i模式输入tb等价于`:tabnew . <cr>`,即打开当前目录
    * `nmap`普通模式
* 2.`noremap`:与map相对，不允许再对`{rhs}`进行映射扫描,不会对`{rhs}`进行递归分析。建议使用noremap
    * `nnoremap`nmap非递归
* 3.`unmap`取消`{lhs}`绑定
    * `numap`和`nmapclear`
* 4.`mapclear` 取消所有绑定

## 1.3 特殊参数
有些特殊参数必须映射命令的后边，在其他任何参数的前面。

* `<buffer>`局限于当前缓冲
* `<silent>`指执行绑定键不在命令行回显
* `<speclial>`特殊怕有副作用`:map <special> <F12> /Header<CR>`
* `<expr>`如果定义新映射的第一个参数是`<expr>`，那么参数会作为表达式来进行计算，结果使用实际使用的`<rhs>`
* `<unique>`一般用于定义新的键映射或者缩写命令的同时检查是否该键已经被映射，如果该映射或者缩写已经存在，则该命令会失败
* `<Leader>`和`mapleader`变量mapleader变量对所有map映射命令起效，它的作用是将参数<leader>替换成mapleader变量的值

# My vim config
YouCompelteMe

vim配置

```
./configure --prefix=~/.usr/  --enable-multibyte --enable-pythoninterp=yes
# 指定share 目录
# 可能需要指定make VIMRUNTIMEDIR=/usr/share/vim/vim74
make
make install
```

You配置

```
cp ~/.vim/bundle/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_config.py ~/.vim

#vimrc 中添加配置
let g:ycm_server_python_interpreter = '/usr/bin/python'
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
```

ycm配置文件，可导入多个头文件信息


# bin
bin 文件
# share
share 文件

# 安装

```
./install.sh
```

# `./vim/session`
这个目录会存储vim的一些信息，如果打开直接之前拷贝的项目，可能会导致进入的还是原来的目录(Nerdtree)，而不是新的路径(cdpath)

# Linux ctags

1.查看支持

```
$ls script/tags.sh
$make ARCH=arm tags
$make ARCH=arm cscope
```
