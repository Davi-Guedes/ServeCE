ALTER TABLE contratacoes
    ADD COLUMN conclusao_confirmada_cliente_em DATETIME NULL,
    ADD COLUMN conclusao_confirmada_prestador_em DATETIME NULL;

DELIMITER $$

CREATE TRIGGER trg_avaliacoes_exigir_confirmacoes
BEFORE INSERT ON avaliacoes
FOR EACH ROW
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM contratacoes
        WHERE id = NEW.contratacao_id
          AND conclusao_confirmada_cliente_em IS NOT NULL
          AND conclusao_confirmada_prestador_em IS NOT NULL
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'A avaliação exige a confirmação de conclusão das duas partes.';
    END IF;
END$$

DELIMITER ;