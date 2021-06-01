const request = require('supertest');
const app = require('../app');

let server;

beforeEach(() => {
    server = request(app);
});

describe('testing for app to be up and running', () => {
    it('GET request', async () => {
        const url = '/';
        const response = await server.get(url);
        expect(response.status).toEqual(200);
    });

});