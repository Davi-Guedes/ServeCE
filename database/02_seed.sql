-- =====================================================
-- ServeCE - Dados de teste (TODOS FICTÍCIOS)
-- Rode DEPOIS do 01_schema.sql, em um banco recém-criado.
-- As senhas abaixo são textos de exemplo, NÃO são hashes reais:
-- o login só funcionará quando o backend gerar hashes de verdade.
-- =====================================================

USE servece;

INSERT INTO categorias (nome) VALUES
  ('Eletricista'), ('Encanador'), ('Pintor'), ('Pedreiro'),
  ('Diarista'), ('Marceneiro'), ('Ar-condicionado'), ('Jardinagem');

INSERT INTO usuarios (nome, email, senha_hash, is_admin) VALUES
  ('Admin ServeCE', 'admin@servece.test',  'HASH_FALSO_1', TRUE),   -- id 1
  ('João Silva',    'joao@servece.test',   'HASH_FALSO_2', FALSE),  -- id 2 (profissional)
  ('Maria Souza',   'maria@servece.test',  'HASH_FALSO_3', FALSE),  -- id 3 (profissional)
  ('Carlos Lima',   'carlos@servece.test', 'HASH_FALSO_4', FALSE),  -- id 4 (cliente)
  ('Ana Pereira',   'ana@servece.test',    'HASH_FALSO_5', FALSE);  -- id 5 (cliente)

INSERT INTO telefones (usuario_id, numero, principal) VALUES
  (1, '88999990000', TRUE),   -- id 1
  (2, '88999990001', TRUE),   -- id 2 (João, principal)
  (2, '88999990002', FALSE),  -- id 3 (João, comercial)
  (3, '88999990003', TRUE),   -- id 4
  (4, '88999990004', TRUE),   -- id 5
  (5, '88999990005', TRUE);   -- id 6

INSERT INTO perfis_profissionais (usuario_id, nome_perfil, descricao) VALUES
  (2, 'Eletro Silva',   'Eletricista com 10 anos de experiência em Sobral.'),  -- id 1
  (3, 'Maria Pinturas', 'Pintura residencial e comercial, acabamento fino.');  -- id 2

INSERT INTO servicos (perfil_id, categoria_id, telefone_id, nome, descricao, valor_min, bairro) VALUES
  (1, 1, 2,    'Instalação de tomadas e interruptores', 'Instalação e troca, com material.', 80.00, 'Centro'),
  (1, 1, 3,    'Reparo de quadro de energia',           'Diagnóstico e conserto.',           NULL,  'Junco'),
  (2, 3, 4,    'Pintura de parede interna',             'Preço por cômodo.',                 250.00,'Centro'),
  (2, 3, NULL, 'Pintura de fachada',                    'Orçamento após visita.',            NULL,  'Derby');

INSERT INTO contratacoes (usuario_id, servico_id, status) VALUES
  (4, 1, 'atendido'),      -- id 1
  (5, 1, 'atendido'),      -- id 2
  (4, 3, 'contatado'),     -- id 3
  (5, 3, 'nao_atendido');  -- id 4

-- Confirmações fictícias das duas contratações avaliadas no seed.
UPDATE contratacoes
SET conclusao_confirmada_cliente_em = data,
    conclusao_confirmada_prestador_em = data
WHERE id IN (1, 2);

INSERT INTO avaliacoes (contratacao_id, nota, comentario) VALUES
  (1, 5, 'Serviço rápido e bem feito.'),
  (2, 4, 'Bom, só atrasou um pouco.');
