/* 1 1680 19680 70848 1968 8 11456 2793 2793 41840 1 41840 0 1 4 1 246 36 0 0 */
/* 32.038 102.388 20.731 1.403 28.435 7.701 14.476 39.984 14.566 */
/* 0.0 1.0 0.9942714 */
EXPLAIN ANALYZE
SELECT MIN(n.name) AS member_in_charnamed_american_movie,
       MIN(n.name) AS a1
FROM cast_info AS ci,
     company_name AS cn,
     keyword AS k,
     movie_companies AS mc,
     movie_keyword AS mk,
     name AS n,
     title AS t, mi_votes, mi_budget, mi_gross
WHERE cn.country_code ='[us]'
  AND k.keyword ='character-name-in-title'
  AND n.name LIKE 'B%'
  AND n.id = ci.person_id
  AND ci.movie_id = t.id
  AND t.id = mk.movie_id
  AND mk.keyword_id = k.id
  AND t.id = mc.movie_id
  AND mc.company_id = cn.id
  AND ci.movie_id = mc.movie_id
  AND ci.movie_id = mk.movie_id
  AND mc.movie_id = mk.movie_id
  AND t.id = mi_votes.movie_id
  AND t.id = mi_budget.movie_id
  AND t.id = mi_gross.movie_id
  AND 24.68597945375489 + (-0.009269798761945815) * t.production_year + 0.000006922266433562143 * mi_votes.votes + (-0.000000005029019143423868) * mi_budget.budget + (-0.00000000030921567270) * mi_gross.gross >= 9.9
  AND 24.68597945375489 + (-0.009269798761945815) * t.production_year + 0.000006922266433562143 * mi_votes.votes + (-0.000000005029019143423868) * mi_budget.budget + (-0.00000000030921567270) * mi_gross.gross <= 11.0;