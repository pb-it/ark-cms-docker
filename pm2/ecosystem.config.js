module.exports = {
    "apps": [
        {
            "name": "wing-cms-api",
            "script": "./wing-cms-api/server.js",
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
            "script": "./wing-cms/server.js",
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