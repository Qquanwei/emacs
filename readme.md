[![Build Status](https://travis-ci.org/Qquanwei/emacs.svg?branch=master)](https://travis-ci.org/Qquanwei/emacs)

# emacs 最佳实践
 很喜欢在cli中使用Emacs, 下面是使用过程中的一些实践记录下。

 安装本配置过程很简单

```
git clone https://github.com/Qquanwei/emacs.git ~/.emacs.d/
cd ~/.emacs.d/
make install
```

然后启动emacs会自动安装所需要的插件。

* if startup failed, using `M-x package-install ret use-package`

## 一些说明

配置文件中开启了`global-auto-revert-mode`自动载入磁盘上发生变更的文件

配置文件使用了`editorconfig`来控制不同mode下插入tab和缩进的问题,可以更加友好地在不同项目之间进行切换。

如果需要一个默认的配置，可以参考我的editorconfig配置 https://drive.google.com/open?id=0B5HTbldQqN-KUUNlMGpyUkxQUkU

快捷键: 一般情况下`C-c`开头的快捷键都是用户态的快捷键，意味让使用者自己绑定，其他的类似`C-x`或`M-`可由外部插件自己定义。ref: https://www.gnu.org/software/emacs/manual/html_node/elisp/Key-Binding-Conventions.html


## 基础快捷键

* C-t 交换当前位置与前一个位置的字符
* C-x C-t 交换当前行与上一行
* C-c C-h C-n 打开hacknews
* C-x C-l 快速打开init.el
* S-up 选择上面的窗口
* S-down 选择下面的窗口
* S-right 选择右边的窗口
* S-left 选择左边的窗口

## 在任何地方都可以进行计算

当我们在编码或者工作的时候，突然有个简单的计算任务需要我们去完成。
我们看着电脑屏幕发呆，(No, 我真的不想去傻傻的找计算机上的计算器应用然
后完成一个简单的计算后就关掉)。 当然，emacs会帮我们，随时随地进行计算。

想完成刚刚这个功能需要做的仅仅是`C-x * q`然后再底部弹出的输入框内输入
我们的表达式就ok了. 而且还支持`sqrt` `pi` `sin` `cos`等常见函数

* C-x * q 启动快速计算
* C-x * c 在窗口底部打开计算器
* C-x * x 关闭打开的计算器
* C-x * k 打开一个图形计算器在emacs中，试一下

## 文件管理

* C-x d 打开dired

### dired

* d 标记一个项以待删除
* x 执行标记 action
* `+` 创建一个目录
* R 移动一个文件(或重命名)

## 高效的移动

* M-1 当前window快速定位一个字符
* M-2 当前window快速定位两个字符
* M-l 当前window快速定位某一行
* M-g g 跳转到行号

### smartparens 工作方式:

不得不说，smartparens 是需要我们不断使用用熟的一个插件， 带来的收益也是相当巨大，自从在youtube上看了某位大神的smartparens之后
便开始重新认识了这个插件。

关于实际效果和用法可以参考这篇文章: http://ebzzry.io/en/emacs-pairs/

* `C-M-f` 跳转到表达式开始
* `C-M-b` 跳转到表达式末尾
* `C-M-n` 跳转到下一个表达式
* `C-M-p` 跳转到前一个表达式 （与dump-jump冲突 :( ）
* `C-M-k` 将表达式删除并加入到kill-ring中
* `M-[` 删掉当前表达式的包裹符号， 也就是删除 " " , [ ], 而保留中间的内容.

## 使用magit-git的工作方式
 magit可以和emacs非常好的结和，可以在编码过程中非常方便地add-commit-push, 也是一个重量级插件,需要一定的适应成本。
 本配置文件中配置了几个快捷键

*  C-c p v  :在当前git项目里执行 git status。实际上执行后会打开一个新的buffer进入magit-mode , 在此mode中可以进行各种action，详情看magit-popup文档. 一般我都会在此进行add-commit,reset操作. 该快捷键是由配置文件的另一个插件`projectile.el`提供，用来查看当前项目状态.
*  C-c g c  :执行magit-checkout , 快速切换分支
*  C-c g f c:执行magit-file-checkout 快速从一个分支检出文件

一般情况下，写完代码之后我会`C-c g s`一下看一下项目的状态，对个别相关的修改分别提交。 在magit里你可以`C-<space>`来选择一块代码，以行为单位，
在有选中的情况下下按下`s`会将当前选中的几行代码加入到暂存区内，当所有本次提交相关的代码提交完后按两下`c`开始提交。当提交后按下`P p`进行`push`
操作。拉取代码用`F p`. 整个过程可以很流畅地快速完成，提高编码的快感。

如果拉去后出现冲突，emacs会给冲突的文件应用`smerge-mode`,在该模式下可以很好的进行merge操作。

### smerge-mode

快捷键

* C-c ^ RET  保留当前区域的版本,如果在HEAD上就保留HEAD，如果在远程提交上就保留远程提交
* C-c ^ a 保留两份(keep-all)
* C-c ^ n 跳转到下一个冲突
* C-c ^ p 跳转到上一个冲突
* C-c ^ m 保留我的本地版本(keep-mine)
* C-c ^ o 保留非我的本地的另外一个版本(keep-other)

当修改完后`smerge-mode`会自动取消绑定到当前buffer

## counsel-dash
  遇到问题时需要查询标准文档，我们需要一个能够快速离线查询文档的工具。counsel-dash就是看文档用的

  文档流地址到这个项目中去找: https://github.com/Kapeli/feeds, 也可以自动在线安装`counsel-dash-install-docset` 不过速度略慢，推荐用迅雷手动下载安装。

  下载好后，使用`M-x counsel-dash-install-docset-from-file`安装docset到~/.docsets中

  在本配置文件中配置了下面两个快捷键

* C-c C-v a 将磁盘中的docsets设为活动的，意思是搜索的时候讲会去搜索这个docset
* C-c C-v q 从活动的docsets中查询一个api

## 项目内导航
 项目内导航是以git项目作为一个项目基础，使用`projectile`这个插件可以自动识别这个项目。自动以git项目为搜索基准和自动匹配.gitignore的rule,使用起来很方便，例如搜索文件，全文搜搜(依赖ag命令)等功能.

* C-c p v  执行projectile-vc, 即是打开项目的版本管理, 对于git项目会优先使用magit-status-internal (git status)
* C-c p k  杀掉所有当前project的buffer
* C-c p D  打开项目的root目录，使用`dired`
* C-c p i  清除当前项目缓存，如果外部修改了项目内文件名时可以刷新当前
  项目文件结构
* C-c p f  项目内搜索文件,模糊识别
* C-c p p  切换项目
* C-c p s s 项目内全文搜索,模糊识别

* C-c p c  对当前项目执行标准编译命令，不同项目有不同配置
* C-c p P  对当前项目执行标准测试命令，依赖项目类型执行不同命令
* C-c p x s 在当前目录打开shell

下面是的Projectile项目相关配置， 例如对于识别根目录下有`package.json`,就会将当前项目类型设置为`npm`型，名字只是个标识无实际意义。然后该项目的标准编译为`npm build`，标准测试为`npm test`. 在该项目下面`C-c p c RET`就可以快速执行`npm build`.

下面是部分项目类型推断条件以及相应的指令

```
| identify file               | project type | stander compile            | stander test          | stander start |
| Cask                        | emacs-cask   | cask install               | nil                   | nil           |
| Gemfile&app&lib&config&test | rails-rspec  | bundle exec rails server   | bundle exec rspec     | nil           |
| Gemfile&lib&test            | ruby-rspec   | app/console server:run     | phpunit -c app        | nil           |
| manage.py                   | django       | python manage.py runserver | bundle exec rake test | nil           |
| gulpfile.js                 | gulp         | gulp                       | gulp test             | nil           |
| package.json                | npm          | npm build                  | npm test              | npm start     |
```
## 阅读翻译
  同样的，我们常常在emacs中阅读英文文档或者查看代码，因为语言的差异导致只能不断的学习，有些场景会用到。所以在本配置文件中定义了有关翻译相关的配置，使用的是`youdao-dictionary`

* C-c y 翻译光标所在位置的单词
* C-c C-y 读出光标所在位置的单词

注:  发音依赖外部命令`mplayer` or `mpg123`

## 代码阅读
  使用的是`dumb-jump`这个插件，支持多种语言的跳转功能。
  默认配置如下

* C-M g 跳转到函数定义
* C-M h 跳回选来的位置
* C-M q 查看函数的定义位置而不跳转

C-M g 在iterm2下发现C-M g总是被判定为C-g, 所以如果在iterm2中使用emacs-cli的话会发现存在问题。


## web-mode

下面两个快捷键绑定在web-mode上方便开发使用，有个前提条件是emacs的环境中能找到`npm`, 可以使用`nvm.el`来在emacs中指定`node`版本，不过`nvm.el`项目目前存在一些缺陷所以我本地用的是修改后的版本。

因为使用web-mode开发时常常会使用外部命令来执行、测试当前项目，这部分功能由`projectile.el`来实现,可以参考[项目内导航]一节的内容。

* C-c p c 执行npm build
* C-c p P 执行npm test

## lisp-mode

* C-c C-c 执行当前buffer

## Markdown Mode
当然，对于markdown的基础支持也是要有的(其实很晚才加上)

`markdown-mode`使用`markdown-preview-mode`作为实时preview的次模式,
快捷键:

* `C-c C-c` 启动`markdown-preview-mode`, 会在新浏览器中打开一个窗口，通过socket.io通信,能够实时看到结果。

## Org-Mode

这个重量级生活方式将非常影响一个人的思维方式，下面是我的一些个人体会。

使用`org-refile` `org-capture`  [可以参考这个链接](http://sachachua.com/blog/2015/02/learn-take-notes-efficiently-org-mode/)

* C-c c t 快速创建任务使用`org-capture template`. 在此可以使用org-refile移动到指定的headline上 (全局)
* C-c c n 快速创建note,使用`org-capture template` (全局)
* C-u C-c C-w 快速跳转到某个tag上 (在org-mode内 下用inline代替)
* C-c C-w 将本tag插入到指定的headline上 (inline)
* C-c C-d 设置deadline (inline)
* C-c C-s schedule (inline)
* C-c C-a 添加attachment (nline)
* C-c C-x C-a 设置某个任务为完成态，将这个headline移出本文件放入完成态文件中. (inline)
* C-c a 打开org agenda命令界面

我的org-capture templates

```
 '(org-capture-templates
   (quote
    (("n" "Notes And Text" entry
      (file+datetree "~/org/notes.org")
      "* TODO %?
%i  create:%T
at: %a")
     ("t" "New Task" entry
      (file+headline "~/org/task.org" "task")
      "* TODO %?
%i  SCHEDULED: %(org-insert-time-stamp (org-read-date nil t))
%i  at: %a"))))

```

关于schedule和deadline, schedule为任务的开始时间，deadline为任务的结束时间. 在看每周安排时如果设置为deadline的任务没有设为`DONE`将会有一个警告显示. 设置为schedule的任务将会在当天进行提醒,并且显示在每周安排内.

如果一个schedule被delay了，可以设置delay日期延长该任务的起始时间。例如schedule时间设置为`<2017-04-13 五 -3d>`意味延长任务时长.

### org-agenda

org-agenda界面是org-mode统计结果展示页，可以快速查找/查看我们创建的任务。

* C-c a a 打开周任务列表 (常用，添加了schedule或deadline的任务才会在这上面显示)   (全局)
* C-c a s 搜索任务(全局)
* C-c a t 显示所有的非DONE状态的标签
* C-c a L 显示timeline

### org-babel

这个功能真的是我最喜欢的org特性了，录了一段视频放在B站:
https://www.bilibili.com/video/av9936508/index_1.html


## 密码管理

经常会有各种网站需要不同的用户名&密码，人脑记起来真的很烦，所以给emacs
加上了密码管理功能。使用的是`pass.el`这个包，后台命令是gnu的`gpg`与
`pass`两个命令。

首先在命令行中初始化gpg公钥 `gpg --gen-key` , 然后按照提示设置基础信息以及主密
码。

上述命令执行成功之后复制输出的公钥，或者(`gpg --list-key`)查看

然后执行`pass init ${公钥}`, 基于此我们的钥匙仓库初始化便完成了。

在emacs中执行`M-x pass`进入pass管理, 进入`pass-store`模式后，快捷键如
下

* i  插入一个钥匙项, 可以使用分隔符`/`来归档不同的项, 例如`web/google`
* I  (大写的i) 插入一个自动生成密码的钥匙项，输入名称后会自动生成一个
  hash密码
* w 拷贝一个钥匙的密码到emacs的剪贴板中(without system)，会保留30秒，
  之后会清除。
