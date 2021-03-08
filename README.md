# Setup

`wget https://raw.githubusercontent.com/cryon-io/alis-cli/master/install.sh -O /tmp/install.sh && sh /tmp/install.sh`

# Usage

`alis-cli` loads configuration by default from `/etc/alis-cli/alis.hjson` or `/etc/alis-cli/alis.json`. 
You can specify custom configuration directory by passing `--config=<path to config file>`
`alis-cli` passes all commands and options to `ami` of specified preconfigured apps.

# Examples:

1. Setup all apps
   `alis-cli all setup`

2. Setup app with id node1
    `alis-cli node1 setup`

3. Get info of all apps
    `alis-cli all info`

For all alis-cli specific options run `alis-cli --help`

# Configuration

Sample configuration:

```hjson
{
    global: {
        user: james
        appDirectory: "/alis-apps/"
        configuration: {
            ...
        }
    },
    apps: [
        {
            id: node1,
            type: nice.node,
            configuration: {
                ...
            }
        },
        {
            id: node2,
            type: nice.node,
            configuration: {
                ...
            },
            user: george
        },
        ...
    ]
}
```
*NODE: All options passed to global.configuration are passed down to app.configuration unless app specifies its own value.*