CREATE DATABASE IF NOT EXISTS planejamento;
USE planejamento;

DROP TABLE IF EXISTS atividade;
DROP TABLE IF EXISTS projeto;
DROP TABLE IF EXISTS usuario;

CREATE TABLE usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    perfil VARCHAR(50) NOT NULL
);

CREATE TABLE projeto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(200) NOT NULL,
    descricao TEXT,
    data_inicio DATE NOT NULL,
    data_fim_planejada DATE NOT NULL,
    data_fim_real DATE
);

CREATE TABLE atividade (
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

-- Inserção de usuários
INSERT INTO usuario (nome, email, perfil) VALUES
('Ana Costa', 'ana@empresa.com', 'admin'),
('Bruno Lima', 'bruno@empresa.com', 'coordenador'),
('Carla Mendes', 'carla@empresa.com', 'executor');

-- Inserção de projetos
INSERT INTO projeto (nome, descricao, data_inicio, data_fim_planejada, data_fim_real) VALUES
('Implementação ERP', 'Implantar o novo sistema ERP na empresa', '2024-01-15', '2024-07-30', NULL),
('Reestruturação da Intranet', 'Atualização do portal interno', '2024-02-01', '2024-05-30', NULL);

-- Inserção de atividades
INSERT INTO atividade (projeto_id, titulo, descricao, responsavel_id, status, data_inicio_planejada, data_fim_planejada, data_inicio_real, data_fim_real, horas_planejadas, horas_gastas) VALUES
(1, 'Mapeamento de processos', 'Identificar processos-chave da empresa', 2, 'Concluída', '2024-01-15', '2024-02-15', '2024-01-15', '2024-02-10', 40, 38),
(1, 'Treinamento de usuários', 'Capacitar os usuários do ERP', 3, 'Em andamento', '2024-03-01', '2024-03-30', '2024-03-02', NULL, 32, 18),
(2, 'Design da nova intranet', 'Proposta visual e navegação', 2, 'Planejada', '2024-04-01', '2024-04-15', NULL, NULL, 20, NULL),
(2, 'Migração de conteúdo', 'Mover dados antigos para a nova plataforma', 3, 'Planejada', '2024-04-16', '2024-04-30', NULL, NULL, 24, NULL);

