var server = {
    port: 3002,
    ssl: true,
    fileStorage: [{
        name: "localhost",
        url: "/cdn",
        path: "../cdn/"
    }],
    processManager: 'pm2'
};

module.exports = server;