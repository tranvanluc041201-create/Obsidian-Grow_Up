# Git 代理配置脚本（端口 7891）
# 在 PowerShell 中以管理员身份运行

# 配置 Git 使用代理
git config --global http.proxy http://127.0.0.1:7891
git config --global https.proxy https://127.0.0.1:7891

# 验证配置
git config --global http.proxy
git config --global https.proxy

# 测试推送到 GitHub
cd "D:\obsidian\Eenlish learning"
git push -u origin main

# 如果成功，可以取消代理设置：
# git config --global --unset http.proxy
# git config --global --unset https.proxy
