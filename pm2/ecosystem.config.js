module.exports = {
    "apps": [
        {
            "name": "ark-cms-api",
            "script": "./ark-cms-api/index.js",
            "node_args": "--max_old_space_size=4096",
            "min_uptime": "5000",
            "max_restarts": "5",
            "env": {
                "NODE_ENV": "development"
            },
            "env_production": {
                "NODE_ENV": "production"
            }
        },
        {
            "name": "ark-cms",
            "script": "./ark-cms/index.js",
            "min_uptime": "5000",
            "max_restarts": "5",
            "env": {
                "NODE_ENV": "development"
            },
            "env_production": {
                "NODE_ENV": "production"
            }
        }
    ]
}