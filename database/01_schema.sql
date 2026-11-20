-- =====================================================
-- ServeCE - Schema do banco de dados (MySQL 8+)
-- Rode este arquivo inteiro. Ele pode ser executado de novo:
-- as tabelas são apagadas e recriadas (APAGA OS DADOS!).
-- =====================================================

CREATE DATABASE IF NOT EXISTS servece
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE servece;

-- Apaga na ordem inversa das dependências (filhas antes das pais)
DROP TABLE IF EXISTS avaliacoes;
DROP TABLE IF EXISTS contratacoes;
DROP TABLE IF EXISTS servicos;
DROP TABLE IF EXISTS categorias;
DROP TABLE IF EXISTS perfis_profissionais;
DROP TABLE IF EXISTS telefones;
DROP TABLE IF EXISTS usuarios;

-- 1. Usuários (conta única: cliente e/ou profissional)
CREATE TABLE usuarios (
  id         INT AUTO_INCREMENT PRIMARY KEY,
  nome       VARCHAR(100) NOT NULL,
  email      VARCHAR(150) NOT NULL UNIQUE,
  senha_hash VARCHAR(255) NOT NULL,
  is_admin   BOOLEAN NOT NULL DEFAULT FALSE,
  ativo      BOOLEAN NOT NULL DEFAULT TRUE,
  criado_em  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 2. Telefones (atributo multivalorado de usuário: 1 usuário -> N telefones)
CREATE TABLE telefones (
  id         INT AUTO_INCREMENT PRIMARY KEY,
  usuario_id INT NOT NULL,
  numero     VARCHAR(15) NOT NULL,   -- só dígitos, com DDD
  principal  BOOLEAN NOT NULL DEFAULT FALSE,
  FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
  UNIQUE (usuario_id, numero)
);

-- 3. Perfis profissionais (no máximo 1 por usuário)
CREATE TABLE perfis_profissionais (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  usuario_id  INT NOT NULL UNIQUE,
  nome_perfil VARCHAR(100) NOT NULL,
  descricao   TEXT,
  status      ENUM('ativo','inativo') NOT NULL DEFAULT 'ativo',
  FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- 4. Categorias
CREATE TABLE categorias (
  id    INT AUTO_INCREMENT PRIMARY KEY,
  nome  VARCHAR(80) NOT NULL UNIQUE,
  ativa BOOLEAN NOT NULL DEFAULT TRUE
);

-- 5. Serviços (os anúncios)
CREATE TABLE servicos (
  id           INT AUTO_INCREMENT PRIMARY KEY,
  perfil_id    INT NOT NULL,
  categoria_id INT NOT NULL,
  telefone_id  INT NULL,             -- NULL: usa o telefone principal do dono
  nome         VARCHAR(120) NOT NULL,
  descricao    TEXT,
  valor_min    DECIMAL(10,2) NULL,   -- NULL = "a combinar"
  bairro       VARCHAR(80),
  cidade       VARCHAR(80) NOT NULL DEFAULT 'Sobral',
  status       ENUM('ativo','pausado','removido') NOT NULL DEFAULT 'ativo',
  criado_em    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (perfil_id)    REFERENCES perfis_profissionais(id),
  FOREIGN KEY (categoria_id) REFERENCES categorias(id),
  FOREIGN KEY (telefone_id)  REFERENCES telefones(id),
  CHECK (valor_min IS NULL OR valor_min >= 0)
);

-- 6. Contratações (cliente confirmou interesse em um serviço)
CREATE TABLE contratacoes (
  id         INT AUTO_INCREMENT PRIMARY KEY,
  usuario_id INT NOT NULL,
  servico_id INT NOT NULL,
  data       DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  status     ENUM('contatado','atendido','nao_atendido') NOT NULL DEFAULT 'contatado',
  FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
  FOREIGN KEY (servico_id) REFERENCES servicos(id)
);

-- 7. Avaliações (no máximo 1 por contratação)
CREATE TABLE avaliacoes (
  id             INT AUTO_INCREMENT PRIMARY KEY,
  contratacao_id INT NOT NULL UNIQUE,
  nota           TINYINT NOT NULL,
  comentario     TEXT,
  data           DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (contratacao_id) REFERENCES contratacoes(id),
  CHECK (nota BETWEEN 1 AND 5)
);

-- Índices extras para busca (as FKs já criam índice automaticamente)
CREATE INDEX idx_servicos_status_cidade ON servicos (status, cidade);
CREATE INDEX idx_contratacoes_usuario_status ON contratacoes (usuario_id, status);
