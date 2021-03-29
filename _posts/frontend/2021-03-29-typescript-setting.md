---
layout: post
title: "Typescript + WebGL (1) | gts, webpack으로 vanilla Typescript 세팅하기"
description: "gts, webpack으로 Typescript 세팅하기"
comments: true
category: frontend
---

# Typescript + WebGL (1) 

## gts, webpack으로 vanilla Typescript 세팅하기

<br/>

### gts로 프로젝트 생성하기

우선 Typescript 프로젝트를 생성한다

```bash
mkdir WebGL     # 프로젝트 폴더 생성
cd WebGL

npx gts init    # gts를 이용하여 typescript 프로젝트 생성

# 생성 이후 vscode로 프로젝트 오픈
code .
```

<br />

`vscode`로 오픈한 경우, 다음과 같은 폴더 구조를 띈다.
(필자는 `.gitignore`에 `node_modules`과 `package-lock.json`을 추가하였다)

<img width="200px" src="https://user-images.githubusercontent.com/49581472/112814101-e3323500-90b9-11eb-8fc6-6f0f55d17d4d.png" alt="프로젝트 생성 후 폴더 구조"/>


`tsconfig.json`의 파일을 수정하여 내 설정을 추가하였다.

```json
{
  "extends": "./node_modules/gts/tsconfig-google.json",
  "compilerOptions": {
    "lib": ["es5", "es6", "dom"],
    "rootDir": ".",
    "outDir": "build",  // tsc를 이용할 경우, root/build 폴더에 컴파일된 항목들이 존재한다
    "target": "es6",
    "module": "commonjs",
    "strict": true,
    "removeComments": true,
    "esModuleInterop": true,
    "baseUrl": ".",
    "paths": {  
      "@src/*": [       // 파일 import시 절대경로 사용하기 위함
        "src/*"         // import '../../../assets/style.css' 과 같은 기존의 방법을
      ]                 // import '@src/assets/style.css' 와 같이 사용 가능
    }
  },
  "include": [
    "src/**/*.ts"
  ],
  "exclude": ["node_modules"]
}
```

<br/>

위 세팅을 바탕으로 src를 작성하면, `Uncaught ReferenceError: require is not defined at index.ts:1` 에러를 겪었었다.

`import ... from`이 `require`로 컴파일 되지만, 브라우저에는 `reqiure`이 없어 `browserify`를 사용하라는 솔루션을 찾았다.

`browserify`와 `rollup`을 연동하여 사용하려고 했지만, `webpack`이 좀 더 적적해보여 `webpack`을 사용한다.

<br/>

### 웹팩 설정하기

우선 웹팩 설치를 진행한다.

```bash
npm i -D webpack webpack-cli
npm i -D css-loader file-loader node-sass sass-loader style-loader ts-loader
npm i -D html-webpack-plugin webpack-dev-server
```

필자는 css대신 scss를 사용하기 위해 `node-sass sass-loader`를 추가로 설치하였고, `ts-loader` 또한 추가로 설치하였다.

html파일 또한 웹팩에 추가하기 위해 `html-webpack-plugin` 플러그인을 추가하였다.

```javascript
// root/webpack.config.js

const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  mode: 'development',
  entry: {
    main: './src/index.ts',
  },
  module: {                         // 파일 확장자에 대한 loader 설정
    rules: [
      {
        test: /\.tsx?$/,
        use: 'ts-loader',
        exclude: /node_modules/,
      },
      {
        test: /\.scss$/,
        use: ['style-loader', 'css-loader', 'sass-loader'],
      },
      {
        test: /\.(png|jpe?g|gif|jp2|webp)$/,
        loader: 'file-loader',
        options: {
          name: 'images/[name].[ext]',
          publicPath: 'public/',
        },
      },
    ],
  },
  resolve: {
    extensions: ['.tsx', '.ts', '.js'],
    alias: {
      '@src': path.resolve(__dirname, 'src'),
    },
  },
  output: {                         // 웹팩 컴파일 결과물의 위치
    publicPath: '/public/',
    path: path.resolve('./public/'),
    filename: '[name].js',          // entry의 key값인 'main'이 파일이름으로
  },
  devServer: {                      // 서버를 띄우기 위함
    port: 3000,
    hot: true,                      // 저장시 자동으로 새로고침
    contentBase: __dirname + '/public/',
    inline: true,
    watchOptions: {
      poll: true,
    },
  },
  plugins: [
    new HtmlWebpackPlugin({         // html 파일도 컴파일
      template: './src/index.html',
    }),
  ],
};
```

`package.json` 또한 설정해준다

```json
{
    ...
    "scripts": {
        "compile": "tsc -w",
        "build": "webpack --watch",
        "start": "webpack serve --open",
        "predeploy": "webpack"
    },
    ...
}
```

`src`에 파일들을 추가한다.

```html
<!-- root/src/index.html -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <div id='app'></div>
</body>
</html>
```

위에서 `<script src="/public/main.js"></script>`를 추가할 필요가 없다.

웹팩에서 알아서 `head` 태그에 `script`태그를 삽입해준다.

<br/>

```typescript
// index.ts

const $app = document.querySelector('#app');

$app &&
  (() => {
    $app.innerHTML = `<div>hi??</div>`;
  })();
```

### 컴파일 & 서버 실행하기

```bash
# webpack으로 컴파일
npm run build

# 서버 오픈
npm run start
```

`localhost:3000`에 진입하면 성공!