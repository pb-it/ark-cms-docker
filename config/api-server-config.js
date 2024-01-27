var server = {
    port: 3002,
    ssl: true,
    fileStorage: [{
        name: "localhost",
        url: "/cdn",
        path: "/var/www/html/cdn/"
    }],
    processManager: 'pm2'
};

module.exports = server;