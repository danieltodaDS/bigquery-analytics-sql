-- =====================================================
-- PROBLEMA: Como verificar se uma tabela possui duplicidade
-- de chave primária antes de usá-la em uma análise?
--
-- SOLUÇÃO: Script que retorna (1) o resumo estatístico de
-- duplicidade e (2) as linhas duplicadas para investigação.
--
-- PLATAFORMA: BigQuery (executar como script)
-- COMO USAR:  substitua os valores das variáveis abaixo
-- =====================================================

DECLARE full_table_name STRING DEFAULT 'bigquery-public-data.austin_waste.waste_and_diversion';
DECLARE primary_key     STRING DEFAULT 'load_id';

-- =====================================================

DECLARE pk_concat STRING;

SET pk_concat = (
  SELECT STRING_AGG(
    CONCAT('CAST(', TRIM(col), ' AS STRING)'),
    " || '|' || "
    ORDER BY pos
  )
  FROM UNNEST(SPLIT(primary_key, ',')) AS col WITH OFFSET pos
);

-- Resumo estatístico
EXECUTE IMMEDIATE FORMAT("""
  WITH base AS (
    SELECT
      %s AS pk_value,
      COUNT(*) AS occurrences
    FROM `%s`
    GROUP BY pk_value
  ),
  stats AS (
    SELECT
      SUM(occurrences)                                      AS total_rows,
      COUNTIF(occurrences > 1)                              AS duplicate_pk_count,
      SUM(IF(occurrences > 1, occurrences, 0))              AS duplicate_rows
    FROM base
  )
  SELECT
    total_rows,
    duplicate_pk_count,
    duplicate_rows,
    ROUND(SAFE_DIVIDE(duplicate_rows, total_rows) * 100, 4) AS duplicate_pct
  FROM stats
""", pk_concat, full_table_name);

-- Linhas duplicadas com todos os campos originais
EXECUTE IMMEDIATE FORMAT("""
  WITH duplicated_keys AS (
    SELECT %s AS pk_value
    FROM `%s`
    GROUP BY pk_value
    HAVING COUNT(*) > 1
  )
  SELECT
    t.*,
    %s AS pk_value_debug
  FROM `%s` t
  INNER JOIN duplicated_keys d
         ON %s = d.pk_value
  ORDER BY pk_value_debug
""", pk_concat, full_table_name,
     pk_concat, full_table_name,
     pk_concat);