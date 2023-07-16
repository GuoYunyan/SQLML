/* 1 0 48 1036 146 405 12951 30 432 0 0 7 0 1 */
/* 0.148 40.42 0.856 1.125 46.667 22.864 */
/* 0.0 1.0 1.0 */
EXPLAIN ANALYZE
SELECT MIN(t.title) AS movie_title
FROM keyword AS k,
     movie_info AS mi,
     movie_keyword AS mk,
     title AS t, mi_votes, mi_budget, mi_gross
WHERE k.keyword LIKE '%sequel%'
  AND mi.info IN ('Bulgaria')
  AND t.production_year > 2010
  AND t.id = mi.movie_id
  AND t.id = mk.movie_id
  AND mk.movie_id = mi.movie_id
  AND k.id = mk.keyword_id
  AND t.id = mi_votes.movie_id
  AND t.id = mi_budget.movie_id
  AND t.id = mi_gross.movie_id
  AND 24.68597945375489 + (-0.009269798761945815) * t.production_year + 0.000006922266433562143 * mi_votes.votes + (-0.000000005029019143423868) * mi_budget.budget + (-0.00000000030921567270) * mi_gross.gross >= 9.9
  AND 24.68597945375489 + (-0.009269798761945815) * t.production_year + 0.000006922266433562143 * mi_votes.votes + (-0.000000005029019143423868) * mi_budget.budget + (-0.00000000030921567270) * mi_gross.gross <= 11.0;