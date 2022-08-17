export type AmplifyDependentResourcesAttributes = {
    "auth": {
        "elysonline36d62aef": {
            "IdentityPoolId": "string",
            "IdentityPoolName": "string",
            "UserPoolId": "string",
            "UserPoolArn": "string",
            "UserPoolName": "string",
            "AppClientIDWeb": "string",
            "AppClientID": "string",
            "CreatedSNSRole": "string"
        },
        "userPoolGroups": {
            "AdminGroupRole": "string",
            "UserGroupRole": "string"
        }
    },
    "api": {
        "elysonline": {
            "GraphQLAPIIdOutput": "string",
            "GraphQLAPIEndpointOutput": "string"
        }
    },
    "storage": {
        "elyscontent": {
            "BucketName": "string",
            "Region": "string"
        }
    },
    "function": {
        "createCustomer": {
            "Name": "string",
            "Arn": "string",
            "Region": "string",
            "LambdaExecutionRole": "string"
        },
        "createSubscription": {
            "Name": "string",
            "Arn": "string",
            "Region": "string",
            "LambdaExecutionRole": "string"
        },
        "getInvoices": {
            "Name": "string",
            "Arn": "string",
            "Region": "string",
            "LambdaExecutionRole": "string"
        },
        "newCard": {
            "Name": "string",
            "Arn": "string",
            "Region": "string",
            "LambdaExecutionRole": "string"
        },
        "cancelSubscription": {
            "Name": "string",
            "Arn": "string",
            "Region": "string",
            "LambdaExecutionRole": "string"
        },
        "getSubscriptionStatus": {
            "Name": "string",
            "Arn": "string",
            "Region": "string",
            "LambdaExecutionRole": "string"
        },
        "deleteCustomer": {
            "Name": "string",
            "Arn": "string",
            "Region": "string",
            "LambdaExecutionRole": "string"
        },
        "sendEventEmail": {
            "Name": "string",
            "Arn": "string",
            "Region": "string",
            "LambdaExecutionRole": "string"
        },
        "sendDesigneeEmail": {
            "Name": "string",
            "Arn": "string",
            "Region": "string",
            "LambdaExecutionRole": "string"
        },
        "sendSpecialEventWarning": {
            "Name": "string",
            "Arn": "string",
            "Region": "string",
            "LambdaExecutionRole": "string"
        },
        "checkSpecialEventTime": {
            "Name": "string",
            "Arn": "string",
            "Region": "string",
            "LambdaExecutionRole": "string"
        },
        "sendSpecialEventText": {
            "Name": "string",
            "Arn": "string",
            "Region": "string",
            "LambdaExecutionRole": "string"
        },
        "changeSubscription": {
            "Name": "string",
            "Arn": "string",
            "Region": "string",
            "LambdaExecutionRole": "string"
        },
        "getNextInvoice": {
            "Name": "string",
            "Arn": "string",
            "Region": "string",
            "LambdaExecutionRole": "string"
        },
        "getCurrentPrice": {
            "Name": "string",
            "Arn": "string",
            "Region": "string",
            "LambdaExecutionRole": "string"
        },
        "checkEventDate": {
            "Name": "string",
            "Arn": "string",
            "Region": "string",
            "LambdaExecutionRole": "string"
        }
    }
}