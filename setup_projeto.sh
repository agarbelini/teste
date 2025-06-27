#!/bin/bash
mkdir -p /opt/teste/templates /opt/teste/certs

cat <<EOF > /opt/teste/app.py
# (Conteúdo do app.py conforme última versão com HTTPS)
EOF

cat <<EOF > /opt/teste/templates/index.html
<!doctype html>
<html>
<head><title>Projetos</title></head>
<body>
  <h1>Projetos</h1>
  <ul>
    {% for projeto in projetos %}
      <li><a href="{{ url_for('ver_projeto', id=projeto.id) }}">{{ projeto.nome }}</a></li>
    {% endfor %}
  </ul>
</body>
</html>
EOF

cat <<EOF > /opt/teste/templates/projeto.html
<!doctype html>
<html>
<head><title>{{ projeto.nome }}</title></head>
<body>
  <h1>{{ projeto.nome }}</h1>
  <p>{{ projeto.descricao }}</p>
  <h2>Atividades</h2>
  <ul>
    {% for atividade in atividades %}
      <li>{{ atividade.titulo }} - {{ atividade.status }}</li>
    {% endfor %}
  </ul>
</body>
</html>
EOF

cat <<EOF > /opt/teste/setup_mysql.sql
CREATE DATABASE IF NOT EXISTS planejamento CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE planejamento;

CREATE TABLE IF NOT EXISTS usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    perfil VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS projeto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(200) NOT NULL,
    descricao TEXT,
    data_inicio DATE NOT NULL,
    data_fim_planejada DATE NOT NULL,
    data_fim_real DATE
);

CREATE TABLE IF NOT EXISTS atividade (
    id INT AUTO_INCREMENT PRIMARY KEY,
    projeto_id INT NOT NULL,
    titulo VARCHAR(200) NOT NULL,
    descricao TEXT,
    responsavel_id INT,
    status VARCHAR(50) DEFAULT 'Planejada',
    data_inicio_planejada DATE NOT NULL,
    data_fim_planejada DATE NOT NULL,
    data_inicio_real DATE,
    data_fim_real DATE,
    horas_planejadas FLOAT,
    horas_gastas FLOAT,
    FOREIGN KEY (projeto_id) REFERENCES projeto(id),
    FOREIGN KEY (responsavel_id) REFERENCES usuario(id)
);
EOF

chmod -R 755 /opt/teste
echo "✅ Projeto criado em /opt/teste"

