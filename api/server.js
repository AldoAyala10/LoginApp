const express = require('express');

const app = express();

app.use(express.json());

// Usuarios simulados
const usuarios = [
  {
    id: 1,
    nombre: 'Edgar',
    correo: 'edgar@test.com',
    password: '123456'
  }
];

// Endpoint de prueba
app.get('/api', (req, res) => {
  res.status(200).json({
    mensaje: 'API funcionando correctamente'
  });
});

// LOGIN
app.post('/api/login', (req, res) => {
  const { correo, password } = req.body;

  if (!correo || !password) {
    return res.status(400).json({
      mensaje: 'Correo y contraseña son obligatorios'
    });
  }

  const usuario = usuarios.find(
    u => u.correo === correo && u.password === password
  );

  if (!usuario) {
    return res.status(401).json({
      mensaje: 'Credenciales incorrectas'
    });
  }

  return res.status(200).json({
    mensaje: 'Login correcto',
    usuario: {
      id: usuario.id,
      nombre: usuario.nombre,
      correo: usuario.correo
    }
  });
});

const PORT = 3000;

if (require.main === module) {
  app.listen(PORT, () => {
    console.log(`API ejecutándose en http://localhost:${PORT}`);
  });
}

module.exports = app;