# emacs 最佳实践
 很喜欢在cli中使用Emacs, 下面是使用过程中的一些实践记录下。

## 使用magit-git的工作方式
 magit可以和emacs非常好的结和，可以在编码过程中非常方便地add-commit-push, 也是一个重量级插件,需要一定的适应成本。
 本配置文件中配置了几个快捷键
 
 ```
   C-c g s  : 相当于在当前git项目里 git status。实际上执行后会打开一个新的buffer进入magit-mode , 再次mode中可以进行各种action，详情看magit-popup文档. 一般我都会在此进行add-commit,reset操作
   C-c g p u: 当前分支: git push
   C-c g p l: 当前分支: git pull
 ```


