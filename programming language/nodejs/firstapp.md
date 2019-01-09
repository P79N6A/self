```bash
npm install -g express
npm install -g express-generator

# 采用淘宝镜像
npm install -g express --registry=https://registry.npm.taobao.org
npm install -g express-generator --registry=https://registry.npm.taobao.org
```

```bash
appName=first-app

# 生成模板
express $appName --view=pug

cd $appName

# 根据 package.json 安装模块，模块存储路径为 node_modules
npm install
# 指定镜像来安装模块
npm install --registry=https://registry.npm.taobao.org

# 启动
node app.js
# or
npm start

# 以 debug 模式启动
DEBUG=$appName:* npm start
```
