# Banco de dados do ServeCE

## Como rodar (MySQL Workbench)
1. Conecte na sua instância local.
2. File > Open SQL Script > `01_schema.sql` > raio (Execute).
3. File > Open SQL Script > `02_seed.sql` > raio (Execute).
4. Atualize Schemas e confira as 7 tabelas em `servece`.

## Regras da equipe
- Nunca altere a estrutura direto no Workbench: mude o script e abra um PR (Pull Request).
- `01_schema.sql` apaga e recria as tabelas (só use no banco local).
- O seed usa dados fictícios. Nunca suba dados reais.

## Teste de integridade (devem dar ERRO)
```sql
INSERT INTO avaliacoes (contratacao_id, nota) VALUES (3, 7);   -- nota fora de 1 a 5
INSERT INTO avaliacoes (contratacao_id, nota) VALUES (1, 5);   -- contratação já avaliada
INSERT INTO perfis_profissionais (usuario_id, nome_perfil) VALUES (2, 'Outro'); -- 2º perfil
INSERT INTO usuarios (nome, email, senha_hash) VALUES ('X','joao@servece.test','h'); -- e-mail repetido
```

## Consulta de verificação (reputação)
```sql
SELECT p.nome_perfil, ROUND(AVG(a.nota),1) AS media, COUNT(a.id) AS total
FROM perfis_profissionais p
JOIN servicos s     ON s.perfil_id = p.id
JOIN contratacoes c ON c.servico_id = s.id
JOIN avaliacoes a   ON a.contratacao_id = c.id
GROUP BY p.id, p.nome_perfil;
-- Esperado: Eletro Silva | 4.5 | 2
```
