/* 1 0 38 76 76 76 76 4388 41840 1 41840 0 0 1 9 1 0 1 */
/* 0.101 0.117 0.694 0.174 0.159 5.226 36.905 13.67 */
/* 0.0 1.0 1.0 */
EXPLAIN ANALYZE
SELECT MIN(lt.link) AS link_type,
       MIN(t1.title) AS first_movie,
       MIN(t2.title) AS second_movie
FROM keyword AS k,
     link_type AS lt,
     movie_keyword AS mk,
     movie_link AS ml,
     title AS t1,
     title AS t2, mi_votes, mi_budget, mi_gross
WHERE k.keyword ='character-name-in-title'
  AND mk.keyword_id = k.id
  AND t1.id = mk.movie_id
  AND ml.movie_id = t1.id
  AND ml.linked_movie_id = t2.id
  AND lt.id = ml.link_type_id
  AND mk.movie_id = t1.id
  AND t1.id = mi_votes.movie_id
  AND t1.id = mi_budget.movie_id
  AND t1.id = mi_gross.movie_id
  AND 24.68597945375489 + (-0.009269798761945815) * t1.production_year + 0.000006922266433562143 * mi_votes.votes + (-0.000000005029019143423868) * mi_budget.budget + (-0.00000000030921567270) * mi_gross.gross >= 9.9
  AND 24.68597945375489 + (-0.009269798761945815) * t1.production_year + 0.000006922266433562143 * mi_votes.votes + (-0.000000005029019143423868) * mi_budget.budget + (-0.00000000030921567270) * mi_gross.gross <= 11.0;