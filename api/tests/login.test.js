const request = require('supertest');
const app = require('../server');

describe('Pruebas del API REST - Login', () => {

  test('CP-01: Debe permitir login con credenciales correctas', async () => {

    // ARRANGE
    const credenciales = {
      correo: 'edgar@test.com',
      password: '123456'
    };

    // ACT
    const respuesta = await request(app)
      .post('/api/login')
      .send(credenciales);

    // ASSERT
    expect(respuesta.statusCode).toBe(200);
    expect(respuesta.body.mensaje).toBe('Login correcto');
    expect(respuesta.body.usuario.correo).toBe('edgar@test.com');
  });

  test('CP-02: Debe rechazar una contraseña incorrecta', async () => {

    // ARRANGE
    const credenciales = {
      correo: 'edgar@test.com',
      password: 'incorrecta'
    };

    // ACT
    const respuesta = await request(app)
      .post('/api/login')
      .send(credenciales);

    // ASSERT
    expect(respuesta.statusCode).toBe(401);
    expect(respuesta.body.mensaje).toBe('Credenciales incorrectas');
  });

  test('CP-03: Debe rechazar un correo inexistente', async () => {

    // ARRANGE
    const credenciales = {
      correo: 'noexiste@test.com',
      password: '123456'
    };

    // ACT
    const respuesta = await request(app)
      .post('/api/login')
      .send(credenciales);

    // ASSERT
    expect(respuesta.statusCode).toBe(401);
    expect(respuesta.body.mensaje).toBe('Credenciales incorrectas');
  });

  test('CP-04: Debe rechazar login sin correo', async () => {

    // ARRANGE
    const credenciales = {
      password: '123456'
    };

    // ACT
    const respuesta = await request(app)
      .post('/api/login')
      .send(credenciales);

    // ASSERT
    expect(respuesta.statusCode).toBe(400);
    expect(respuesta.body.mensaje)
      .toBe('Correo y contraseña son obligatorios');
  });

  test('CP-05: Debe rechazar login sin contraseña', async () => {

    // ARRANGE
    const credenciales = {
      correo: 'edgar@test.com'
    };

    // ACT
    const respuesta = await request(app)
      .post('/api/login')
      .send(credenciales);

    // ASSERT
    expect(respuesta.statusCode).toBe(400);
    expect(respuesta.body.mensaje)
      .toBe('Correo y contraseña son obligatorios');
  });
  test('CP-06: Debe confirmar que el API está funcionando', async () => {

  // ARRANGE
  const ruta = '/api';

  // ACT
  const respuesta = await request(app)
    .get(ruta);

  // ASSERT
  expect(respuesta.statusCode).toBe(200);
  expect(respuesta.body.mensaje)
    .toBe('API funcionando correctamente');
});

});