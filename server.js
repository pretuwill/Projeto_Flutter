const express = require('express');
const mysql = require('mysql');
const cors = require('cors');

const app = express();
const port = 3000;

// Configuração do banco de dados
const db = mysql.createConnection({
  host: 'localhost',
  user: 'seu_usuario',
  password: 'sua_senha',
  database: 'seu_banco_de_dados',
});

db.connect(err => {
  if (err) throw err;
  console.log('Conectado ao banco de dados MySQL!');
});

app.use(cors());
app.use(express.json());

// Exemplo de rota
app.get('/alunos', (req, res) => {
  db.query('SELECT * FROM alunos', (err, results) => {
    if (err) throw err;
    res.json(results);
  });
});

app.listen(port, () => {
  console.log(`Servidor rodando em http://localhost:${port}`);
});
