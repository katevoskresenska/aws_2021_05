Publish message to the SNS topic:
```$ aws sns publish --topic arn:aws:sns:us-west-2:275291927375:topic --message "hello from aws" --region us-west-2```

Send message to the SQS queue:
```$ aws sqs send-message --queue-url "https://sqs.us-west-2.amazonaws.com/275291927375/queue.fifo" --message-body "hello from sqs" --message-group-id "hello" --region us-west-2```

Receive message from the SQS queue:
```$ aws sqs receive-message --queue-url "https://sqs.us-west-2.amazonaws.com/275291927375/queue.fifo" --region us-west-2  ```

