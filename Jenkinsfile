pipeline {
    agent any
    tools {
        maven 'mvn'
        
    }
    stages {
      stage ('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                '''
            }
        }
        stage('Build') {
            steps {
                echo "Building.. "
                sh "mvn clean install -DskipTests"
                archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true
                sh "docker build -t 892943703739.dkr.ecr.us-west-2.amazonaws.com/varshaapachetomcat:latest ."
               // sh "aws ecr get-login --region us-west-2"
                sh "eval \$(aws ecr get-login --no-include-email  --region us-west-2)"
                sh "docker push 892943703739.dkr.ecr.us-west-2.amazonaws.com/varshaapachetomcat:latest"
                //sh "docker login -u AWS -p eyJwYXlsb2FkIjoiVm90YXBPWlN3bExwUFQ4M0lDQVhTbktnZHFWRVJIWWRlTHI1NGxaUTBFSjI2bkxxcmxuaEFmNTFBeFR3N0NxMGkvM09YaVVXUmJTMzA2QWVLNnhyOVh3V3pXbDl6YVd1eWVzZkFrQTMwM092bkNOOThpWm9FQm5oN0xKWkpFRVd5QUV3RU44c3VBUDQrcG1NQ2RIaEJ1ZFYzYUxZYWlLam1qN2VlN0dtSmxXczlZa1gxaDhKL05lYmZRQ0piVWo5RUgxWHo4QlFjYk5PTVVSOXFYSnNCalgxRTFsSUEzYVkzQXpvZjdCUW5rQ2JsK3J5REx5aWtNc1dER2h0T2ZXVGNmREJUSkptcTFlWFlSSG5uT0UzNUhTY3FhRko0dGw5SVhCV2twd01DeVo3VGk0dG5ZOXZxRUp4MDhDL3ZMZFFmU3dYQjgvODllbEE1YVBVQ2VtWTU4YmEvOGRSaGF4TCtqYlNBMFlqSDUrTXZlZ0tKRmRXcUVMdTNJenhGZUQrdHhlSm1OY3MwazIyOVg2d2Y4WmRQenlmTzRBdXovZDFkM0lwMWlrT3cvZEVudjJrRkVDUjM5MlBmcVFDd0ROR0tJekgwTzkrQWkvVS95eU02ckxzbWJUem5QTklnaFQyaW5aWVJXbjdWMVI3QjZ2ZFY0cDM0cVFIeVNCTllRVkVBM0s2UmpDNTZvNEk4WnRyQ0VIdm03VHg2dWg3VEYyY1dWVnl0VU5NMjZkNFJlcVJSZ0I4cmtvdDE4R01ZOVB4M3ErdTJrNmFoanVkME42VVp3WS8vcE90VmlzQ0IvOTZtbDlCdWxYSHJCQzladWZTayt2bWw4Mlc4NUM0UnZzVTVlU0VxTjNrbGFBV0hPM3BaV1lPa2gzUUNFMjdiSmgydk45ajVQMVlOWmNJM1ZMMmJUQ0Z5WkxRandHdWZ2Z0lkeC9Tb1RaSGxXd0k3VHVqUllZd3VhaVJ3Nkw2elZuTjhRSzJhSUhBb0J4SDNTSlVzMTZ0YkUyZHNIME13ZHU1dHJ6Z0VOQmpMdmVXMkt1REIvTjd4UzduTXlYckdTSGY1dWdPWWtBUGxrNmZtQ1I0d2hjOXd3cktPS2d0QW1ZMkhoN0t6bTJJVWd2UUE2Ri9TZDdIMXpzTGU4ZEpTbXVPV0tPbUhiUDhtZVNZQzdUQkoxQjlmY1hWcW9kdENKRXZtQTZYdncyQUdOSXpwMFFkYlJxMDhIcnVENDVOK1BBcDlCR3lNbDVodkRTc0U3S0YzRVJWY2o4eVpVcFo1QXRCNlR1MW9tcGRuV3FUZmZVSHpNendaYjNNZWgwTWtOWkVWejNYTXNoUFdaVHlSblpHbmYwYjcvZUViNHlDdVQ2T0NTdE5PM095NXpnanZha0J4ZHhmUkt3YlR6c0xBenh2cWxyS1BhRFJrazlJaGZoZTg2YWxpemhycW84OUFTQXk3V0JzRjFCZ1QzcTRidnZpNHVUOVhXODVqamdweFE9PSIsImRhdGFrZXkiOiJBUUVCQUhqNmxjNFhJSncvN2xuMEhjMDBETWVrNkdFeEhDYlk0UklwVE1DSTU4SW5Vd0FBQUg0d2ZBWUpLb1pJaHZjTkFRY0dvRzh3YlFJQkFEQm9CZ2txaGtpRzl3MEJCd0V3SGdZSllJWklBV1VEQkFFdU1CRUVEUEpKeHZ1YUtBREFNK2k1MHdJQkVJQTdnUzd0NkpuNzAzeG9HMDJRWXZkdXQwYmJOelBhcStuOS83MHBpVEh5Z0w3YkZnaElGWGVtNVZva2RBbENjaW40bDE2OWZEaXo5MDAvN3pvPSIsInZlcnNpb24iOiIyIiwidHlwZSI6IkRBVEFfS0VZIiwiZXhwaXJhdGlvbiI6MTU0MTUxNjE0N30= 892943703739.dkr.ecr.us-west-2.amazonaws.com"
            }
        }
       stage('Deploy') {
            steps {
               // sh "aws ecs create-cluster --cluster-name MyCluster --region us-west-2"
                  sh "aws ecs list-container-instances"
                  
            }
        }
    }
}
