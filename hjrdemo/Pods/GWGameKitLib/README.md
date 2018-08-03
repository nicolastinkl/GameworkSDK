# GWGameKitLib

forgame工场公共组件类

- 提供数据支持
- 提供快速搭建支持
- 提交规范：

一般情况下，提交 GIT 时的注释可以分成几类，可以用几个动词开始：

- Added ( 新加入的需求 )
- Fixed ( 修复 bug )
- Changed ( 完成的任务 )
- Updated ( 完成的任务，或者由于第三方模块变化而做的变化 )

尽量将注释缩减为一句话，不要包含详细的内容。 假如有 Issues 系统，其中可以包含 Issue 的 ID。比如：

```
Issue #123456 包含作者的信息。

比如 by Bruce 完整例子：
 git commit -m 'Issue #[issue number] by [username]: [Short summary of the change].' Related articles

```

#  How to use

1. 需要在[bitbucket.org](bitbucket.org)添加个人本地rsa_key密钥信息，在 
	https://bitbucket.org/account/user/*****/ssh-keys/ 处加入你本地的rsa key
	![](http://tinkl.qiniudn.com/tinkl2HJKDJSF*KDJKJSDKF8907230194.jpg)

2. `pod repo add gameworksLibSpec git@bitbucket.org:tinkl/podspec.git`


3. 在项目Podfile文件里

```
     # 私有库
     pod "GWGameKitLib",:head                #image基本工具类和部分全局函数
     	
```

 4.   `pod install --verbose` and `pod update`

     
