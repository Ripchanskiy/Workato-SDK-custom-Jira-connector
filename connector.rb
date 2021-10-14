{
  title: "Jira SDK Lab",

  connection: {
    fields: [
      {
       name: 'subdomain',
       control_type: 'subdomain',
       url: '.atlassian.net',
       hint: 'Your Atlassian URL for your Jira Cloud instance.'
      },
      {name: 'username',
       optional: false,
       hint: 'Your username.'
      },
    {
       name: 'api_token',
       control_type: 'password',
       label: 'API token'
      },
    ],

    authorization: {
      type: "basic_auth",

      apply: lambda do |connection|
       user(connection['username'])
       password(connection['api_token'])
      end
    },

    base_uri: lambda do |connection|
      "https://#{connection['subdomain']}.atlassian.net"
    end
  },

  test: lambda do |_connection|
    get("/rest/api/3/myself")
  end,

    actions: {
    get_issue: {
      title: 'Get issue from Jira',
      subtitle: 'Get issue details from Jira Cloud',
      description: "Get <span class='provider'>issue ID and issue summary</span> " \
                   "from <span class='provider'>Jira Cloud</span>",
      help: "This action retrieves your issue ID and issue summary from Jira Cloud. Use this acttion" \
            " to search for issues from your Jira Cloud instance",


      input_fields: lambda do |object_definitions, connection, config_fields|
        [
          {
            name: 'issue_key',
            label: 'Issue ID/key',
            optional: false,
          },
        ]
      end,

      output_fields: lambda do |object_definitions|
        [
          { name: 'key', label: 'Issue key' },
          { name: 'id', label: 'Issue ID' },
          { name: 'fields',
            label: 'Issue fields',
            type: 'object',
            properties: [
              { name: 'summary', label: 'Summary' },
            ]
          },
        ]
      end,

      execute: lambda do |_connection, input, _input_schema, _output_schema|
        url = '/rest/api/3/issue/' + input['issue_key']
        get(url)
      end,
    },
  },
}