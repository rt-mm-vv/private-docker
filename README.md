# README
Hameln Amplify アプリ開発環境構築用のdocker-compose

## ファイル構成
  - aws
    - amplify認証用のcredentialsファイルを配置

## ローカル構築方法
https://bltinc.esa.io/posts/3591

### react 起動まで
```
$ git clone https://git.tdept.com/hr/hameln/amplify.git
$ git clone https://git.tdept.com/hr/hameln/docker.git
$ cd docker
$ docker-compose up -d
$ docker exec -it docker_hameln_amplify_1 bash
$ yarn install
$ yarn start
```

### Amplify の取得
もらった AIM ユーザーの認証情報を credentials, config に入力し
~/dev/Hameln/docker/aws/ 配下に配置する
ディレクトリは各自の環境に合わせる。docker-compose.yml に記載のパスと同じである必要あり

コンテナ入った状態で amplify init

```
$ amplify init
Note: It is recommended to run this command from the root of your app directory
? Do you want to use an existing environment? Yes
? Choose the environment you would like to use: dev
? Choose your default editor: None
Using default provider  awscloudformation

For more information on AWS Profiles, see:
https://docs.aws.amazon.com/cli/latest/userguide/cli-multiple-profiles.html

? Do you want to use an AWS profile? Yes
? Please choose the profile you want to use default
✔ Initialized provider successfully.
Initialized your environment successfully.
```
ポイントは最初に既存の環境があるか聞かれるので Yes, 次にその環境を選択すること。
No にすると新規 Amplify プロジェクトが生成されてしまうので注意
AWS profile を使うか聞かれるので、さきほど配置した credentials に記載した profile を選択

### Amplify mock
ローカルで GraphQL の検証ができる

```
$ amplify mock api
```
http://localhost:20002 にアクセス

react との疎通確認するときは aws-export.js の aws_appsync_graphqlEndpoint を以下のように修正

```
"aws_appsync_graphqlEndpoint": "http://localhost:20002/graphql",
```

※ もし以下のエラーがでる場合
```
Failed to run GraphQL codegen with following error:
ENOENT: no such file or directory, open '/var/www/hameln/amplify/backend/api/referral/build/schema.graphql'
```

ビルドファイルが生成されていないのが問題のよう。
解決方法として正しいのか不明だが以下を実行することで解決
```
$ amplify update api
? Please select from one of the below mentioned services: GraphQL
? Select from the options below Walkthrough all configurations
? Choose the default authorization type for the API Amazon Cognito User Pool
Use a Cognito user pool configured as a part of this project.
? Do you want to configure advanced settings for the GraphQL API No, I am done.
```

git を確認すると backend-config.json に変更が起きているので変更を破棄（実際は同じファイルが生成されているだけだが）
もし、なにか変更が起きていたらおかしいのでその時は誰かに聞いてください。