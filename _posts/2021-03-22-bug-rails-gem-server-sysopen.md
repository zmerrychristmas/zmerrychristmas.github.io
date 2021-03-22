---
title: Bug thần thánh permission denied @ rb_sysopen
categories:
- Framework
- Rails
- Bug
tags:
- rails
- bug
- rvm
---

# Bug rack/server.rb:362:in `initialize`: Permission denied @ rb_sysopen  (Errno::EACCES)
phiên bản sử dụng là rvm 
## Update permission 
```sh 
rvmsudo rvm get stable --auto-dotfiles
rvm fix-permissions system
```
## update user in group rvm
```sh
rvm group add rvm $USER
```
## Ìf not work try update Gem 
```sh
gem update 
gem cleanup
```
