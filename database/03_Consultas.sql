USE servece;

-- Listar serviços ativos, priorizando os profissionais com maior média de avaliações.
-- Em caso de empate, priorizar o menor ID de perfil
-- como aproximação da ordem de cadastro.

SELECT
    s.id AS servico_id,
    s.nome AS servico,
    s.descricao,
    c.nome AS categoria,
    p.id AS perfil_id,
    p.nome_perfil AS profissional,
    s.valor_min,
    s.bairro,
    s.cidade,
    ROUND(reputacao.media_avaliacoes, 2) AS media_avaliacoes,
    COALESCE(reputacao.total_avaliacoes, 0) AS total_avaliacoes
FROM servicos AS s
INNER JOIN categorias AS c
    ON c.id = s.categoria_id
INNER JOIN perfis_profissionais AS p
    ON p.id = s.perfil_id
INNER JOIN usuarios AS u
    ON u.id = p.usuario_id
LEFT JOIN (
    SELECT
        sv.perfil_id,
        AVG(a.nota) AS media_avaliacoes,
        COUNT(a.id) AS total_avaliacoes
    FROM servicos AS sv
    INNER JOIN contratacoes AS ct
        ON ct.servico_id = sv.id
    INNER JOIN avaliacoes AS a
        ON a.contratacao_id = ct.id
    GROUP BY sv.perfil_id
) AS reputacao
    ON reputacao.perfil_id = p.id
WHERE s.status = 'ativo'
    AND p.status = 'ativo'
    AND u.ativo = TRUE
    AND c.ativa = TRUE
ORDER BY
    reputacao.media_avaliacoes DESC,
    p.id ASC,
    s.id ASC;