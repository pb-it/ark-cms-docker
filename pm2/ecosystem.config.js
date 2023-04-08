module.exports = {
    "apps": [
        {
            "name": "wing-cms-api",
            "script": "./wing-cms-api/index.js",
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
            "name": "wing-cms",
            "script": "./wing-cms/index.js",
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