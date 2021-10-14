### Based on [SDK](https://github.com/workato/workato-connector-sdk)

### Create settings.yaml configuration file based on settings.example.yaml file with valid keys
```shell
api_token: atlassian api_token
username: atlassian username
subdomain: atlassian subdomain
```
### Run specs
```shell
rspec spec --format documentation --color --require spec_helper
```

### Jira

##### #test_connection
```shell
workato exec test --connection=jira --verbose
```

##### #get_issue
```shell
workato exec actions.get_issue.execute --verbose --input="fixtures/actions/get_issue/input.json"
```

