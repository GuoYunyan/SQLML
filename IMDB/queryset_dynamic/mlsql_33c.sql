/* 1 0 0 0 0 0 0 133 150 51 51 27 41 1 41 47 1 3080 2315 2 1875 2 1 1 2 1 3 1 0 0 0 0 0 0 */
/* 0.001 0.001 0.0 0.001 0.001 0.14 0.269 0.163 0.118 0.101 0.143 0.027 0.13 0.197 5.497 0.775 */
/* 0.0 0.0 0.0 */
EXPLAIN ANALYZE
SELECT MIN(cn1.name) AS first_company,
       MIN(cn2.name) AS second_company,
       MIN(mi_idx1.info) AS first_rating,
       MIN(mi_idx2.info) AS second_rating,
       MIN(t.title) AS first_movie,
       MIN(t2.title) AS second_movie
FROM company_name AS cn1,
     company_name AS cn2,
     info_type AS it1,
     info_type AS it2,
     kind_type AS kt1,
     kind_type AS kt2,
     link_type AS lt,
     movie_companies AS mc1,
     movie_companies AS mc2,
     movie_info_idx AS mi_idx1,
     movie_info_idx AS mi_idx2,
     movie_link AS ml,
     title AS t,
     title AS t2, mi_votes, mi_budget, mi_gross
WHERE cn1.country_code != '[us]'
  AND it1.info = 'rating'
  AND it2.info = 'rating'
  AND kt1.kind IN ('tv series',
                   'episode')
  AND kt2.kind IN ('tv series',
                   'episode')
  AND lt.link IN ('sequel',
                  'follows',
                  'followed by')
  AND mi_idx2.info < '3.5'
  AND t2.production_year BETWEEN 2000 AND 2010
  AND lt.id = ml.link_type_id
  AND t.id = ml.movie_id
  AND t2.id = ml.linked_movie_id
  AND it1.id = mi_idx1.info_type_id
  AND t.id = mi_idx1.movie_id
  AND kt1.id = t.kind_id
  AND cn1.id = mc1.company_id
  AND t.id = mc1.movie_id
  AND ml.movie_id = mi_idx1.movie_id
  AND ml.movie_id = mc1.movie_id
  AND mi_idx1.movie_id = mc1.movie_id
  AND it2.id = mi_idx2.info_type_id
  AND t2.id = mi_idx2.movie_id
  AND kt2.id = t2.kind_id
  AND cn2.id = mc2.company_id
  AND t2.id = mc2.movie_id
  AND ml.linked_movie_id = mi_idx2.movie_id
  AND ml.linked_movie_id = mc2.movie_id
  AND mi_idx2.movie_id = mc2.movie_id
  AND t.id = mi_votes.movie_id
  AND t.id = mi_budget.movie_id
  AND t.id = mi_gross.movie_id
  AND 24.68597945375489 + (-0.009269798761945815) * t.production_year + 0.000006922266433562143 * mi_votes.votes + (-0.000000005029019143423868) * mi_budget.budget + (-0.00000000030921567270) * mi_gross.gross <= 11.0
  AND 24.68597945375489 + (-0.009269798761945815) * t.production_year + 0.000006922266433562143 * mi_votes.votes + (-0.000000005029019143423868) * mi_budget.budget + (-0.00000000030921567270) * mi_gross.gross >= 9.9;