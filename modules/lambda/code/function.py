import os
import json
        
def lambda_handler(event, context):
    ENVIRON = os.environ['ENV']
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps({
            "ENVIRONMENT: ": ENVIRON
        })
    }