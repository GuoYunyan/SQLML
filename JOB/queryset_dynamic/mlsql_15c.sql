/* 1 0 0 0 0 0 0 0 0 188 56581 29854 75178 0 2 1 0 0 0 0 0 0 0 0 */
/* 0.0 0.001 0.001 0.0 0.001 0.0 0.001 20.231 138.676 51.225 137.873 */
/* 0.0 0.0155883 0.0012394 */
EXPLAIN ANALYZE
SELECT MIN(mi.info) AS release_date,
       MIN(t.title) AS modern_american_internet_movie
FROM
  mi_budget CROSS JOIN
  mi_votes CROSS JOIN
  mi_gross CROSS JOIN
  title AS t CROSS JOIN
  movie_info AS mi CROSS JOIN
  info_type AS it1 CROSS JOIN
  movie_companies AS mc CROSS JOIN
  company_type AS ct CROSS JOIN
  company_name AS cn CROSS JOIN
  aka_title AS at CROSS JOIN
  movie_keyword AS mk CROSS JOIN
  keyword AS k
     
WHERE cn.country_code = '[us]'
  AND it1.info = 'release dates'
  AND mi.note LIKE '%internet%'
  AND mi.info IS NOT NULL
  AND (mi.info LIKE 'USA:% 199%'
       OR mi.info LIKE 'USA:% 200%')
  AND t.production_year > 1990
  AND t.id = at.movie_id
  AND t.id = mi.movie_id
  AND t.id = mk.movie_id
  AND t.id = mc.movie_id
  AND mk.movie_id = mi.movie_id
  AND mk.movie_id = mc.movie_id
  AND mk.movie_id = at.movie_id
  AND mi.movie_id = mc.movie_id
  AND mi.movie_id = at.movie_id
  AND mc.movie_id = at.movie_id
  AND k.id = mk.keyword_id
  AND it1.id = mi.info_type_id
  AND cn.id = mc.company_id
  AND ct.id = mc.company_type_id
  AND t.id = mi_votes.movie_id
  AND t.id = mi_budget.movie_id
  AND t.id = mi_gross.movie_id
  AND 24.68597945375489 + (-0.009269798761945815) * t.production_year + 0.000006922266433562143 * mi_votes.votes + (-0.000000005029019143423868) * mi_budget.budget + (-0.00000000030921567270) * mi_gross.gross >= 9.9
  AND 24.68597945375489 + (-0.009269798761945815) * t.production_year + 0.000006922266433562143 * mi_votes.votes + (-0.000000005029019143423868) * mi_budget.budget + (-0.00000000030921567270) * mi_gross.gross <= 11.0;