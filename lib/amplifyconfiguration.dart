const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "analytics": {
        "plugins": {
            "awsPinpointAnalyticsPlugin": {
                "pinpointAnalytics": {
                    "appId": "20abae0a48df4d0590e5ecfebafa491c",
                    "region": "us-east-1"
                },
                "pinpointTargeting": {
                    "region": "us-east-1"
                }
            }
        }
    },
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "elysonline": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://lwysedfk6zaq3czqdqiwkejdde.appsync-api.us-east-1.amazonaws.com/graphql",
                    "region": "us-east-1",
                    "authorizationType": "AMAZON_COGNITO_USER_POOLS"
                }
            }
        }
    },
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "us-east-1:b35ff7d5-5f4f-430d-9e11-fd25d67f51fa",
                            "Region": "us-east-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "us-east-1_4XDwq0UyV",
                        "AppClientId": "4n0obprqpasiim7kplqan3v6dh",
                        "AppClientSecret": "du0qeg6bhr4jcvghhgbq8k2dd8sna905i3uh3af9fmla8eg463j",
                        "Region": "us-east-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH",
                        "loginMechanisms": [
                            "PREFERRED_USERNAME"
                        ],
                        "signupAttributes": [
                            "EMAIL"
                        ],
                        "passwordProtectionSettings": {
                            "passwordPolicyMinLength": 8,
                            "passwordPolicyCharacters": []
                        },
                        "mfaConfiguration": "OFF",
                        "mfaTypes": [
                            "SMS"
                        ],
                        "verificationMechanisms": [
                            "EMAIL"
                        ],
                        "socialProviders": [],
                        "usernameAttributes": []
                    }
                },
                "AppSync": {
                    "Default": {
                        "ApiUrl": "https://lwysedfk6zaq3czqdqiwkejdde.appsync-api.us-east-1.amazonaws.com/graphql",
                        "Region": "us-east-1",
                        "AuthMode": "AMAZON_COGNITO_USER_POOLS",
                        "ClientDatabasePrefix": "elysonline_AMAZON_COGNITO_USER_POOLS"
                    }
                },
                "S3TransferUtility": {
                    "Default": {
                        "Bucket": "elysonline361ff3e65f004dbbaf0eaa5afa9ce9ec103619-test",
                        "Region": "us-east-1"
                    }
                },
                "PinpointAnalytics": {
                    "Default": {
                        "AppId": "20abae0a48df4d0590e5ecfebafa491c",
                        "Region": "us-east-1"
                    }
                },
                "PinpointTargeting": {
                    "Default": {
                        "Region": "us-east-1"
                    }
                }
            }
        }
    },
    "storage": {
        "plugins": {
            "awsS3StoragePlugin": {
                "bucket": "elysonline361ff3e65f004dbbaf0eaa5afa9ce9ec103619-test",
                "region": "us-east-1",
                "defaultAccessLevel": "guest"
            }
        }
    }
}''';