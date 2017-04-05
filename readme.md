# emacs 最佳实践
 很喜欢在cli中使用Emacs, 下面是使用过程中的一些实践记录下。

 安装本配置过程很简单

`git clone https://github.com/Qquanwei/emacs.git ~/.emacs.d/`

然后启动emacs会自动安装所需要的插件。(有些命令依赖命令行，需要手动安装)

## 基础快捷键

* C-t 交换当前位置与前一个位置的字符
* C-x C-t 交换当前行与上一行
* M-g 跳转到行号
* M-1 当前window快速定位一个字符
* M-2 当前window快速定位两个字符
* M-l 当前window快速定位某一行
* C-c C-h C-n 打开hacknews

## 使用magit-git的工作方式
 magit可以和emacs非常好的结和，可以在编码过程中非常方便地add-commit-push, 也是一个重量级插件,需要一定的适应成本。
 本配置文件中配置了几个快捷键

*  C-c g s  :相当于在当前git项目里 git status。实际上执行后会打开一个新的buffer进入magit-mode , 在此mode中可以进行各种action，详情看magit-popup文档. 一般我都会在此进行add-commit,reset操作
*  C-c g p u: 当前分支: git push
*  C-c g p l: 当前分支: git pull

## helm-dash
  遇到问题时需要查询标准文档，我们需要一个能够快速离线查询文档的工具。helm-dash就是看文档用的

  文档流地址到这个项目中去找: https://github.com/Kapeli/feeds

  下载好后，使用`M-x helm-dash-install-docset-from-file`安装docset到~/.docsets中

  在本配置文件中配置了下面两个快捷键

* C-c C-v a 将磁盘中的docsets设为活动的，意思是搜索的时候讲会去搜索这个docset
* C-c C-v q 从活动的docsets中查询一个api

## 项目内导航
 项目内导航是以git项目作为一个项目基础，使用`projectile`这个插件可以自动识别这个项目。自动以git项目为搜索基准和自动匹配.gitignore的rule,使用起来很方便，例如搜索文件，全文搜搜(依赖ag命令,需要`brew install ag` or `sudo apt-get install ag`)等功能.

* C-c p f  项目内搜索文件,模糊识别
* C-c p s s 项目内全文搜索,模糊识别

## 阅读翻译
  同样的，我们常常在emacs中阅读英文文档或者查看代码，因为语言的差异导致只能不断的学习，有些场景会用到。所以在本配置文件中定义了有关翻译相关的配置，使用的是`youdao-dictionary`

* C-c y 翻译光标所在位置的单词
* C-c C-y 读出光标所在位置的单词

注:  发音依赖外部命令`mplayer` or `mpg123`

## 代码阅读
  使用的是`dumb-jump`这个插件，支持多种语言的跳转功能。
  默认配置如下

* C-M h 跳转到函数定义

跳转到函数定义默认为C-M g ， 但是尝试在osx下发现C-M g总是被判定为C-g, 所以就重新绑定了一个手指比较习惯的位置。
* C-M q 跳回原来的位置
* C-M q 显示定义的上下文


## lisp-mode

* C-c C-c 执行当前buffer

## Markdown Mode
当然，对于markdown的基础支持也是要有的(其实很晚才加上)

`markdown-mode`使用`markdown-preview-mode`作为实时preview的次模式,
快捷键:

* `C-c C-c` 启动`markdown-preview-mode`, 会在新浏览器中打开一个窗口，通过socket.io通信,能够实时看到结果。
