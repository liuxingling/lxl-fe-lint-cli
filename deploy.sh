#!/usr/bin/env sh

# 构建生成的静态文件推送到 GitHub Pages 的 gh-pages 分支

# 确保脚本在遇到任何错误时立即退出
set -e

# 获取远程仓库的推送地址
push_addr=`git remote get-url --push origin`
# 获取当前提交的描述信息
commit_info=`git describe --all --always --long`
# 指定构建生成的静态文件所在的目录
dist_path=docs/.vuepress/dist
# 指定要将文件推送到的远程分支名称
push_branch=gh-pages

# 生成静态文件
npm run docs:build

# 进入生成的文件夹
cd $dist_path
# 初始化 Git 仓库并推送文件
git init
git add -A
# 创建一个新的提交，消息包含当前的提交信息
git commit -m "deploy, $commit_info"
# 强制推送当前分支到指定的远程分支
git push -f $push_addr HEAD:$push_branch

# 返回上级目录并删除生成的文件夹
cd -
rm -rf $dist_path
