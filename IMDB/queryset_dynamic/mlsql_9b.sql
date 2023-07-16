/* 1 0 0 0 0 0 0 103336 103350 105449 31744 198519 0 3 1 1 0 0 0 0 0 0 */
/* 0.001 0.0 0.001 0.001 0.0 186.565 163.923 158.064 61.734 195.06 */
/* 0.0 0.0261187 1.0 */
EXPLAIN ANALYZE
SELECT MIN(an.name) AS alternative_name,
       MIN(chn.name) AS voiced_character,
       MIN(n.name) AS voicing_actress,
       MIN(t.title) AS american_movie
FROM aka_name AS an,
     char_name AS chn,
     cast_info AS ci,
     company_name AS cn,
     movie_companies AS mc,
     name AS n,
     role_type AS rt,
     title AS t, mi_votes, mi_budget, mi_gross
WHERE ci.note = '(voice)'
  AND cn.country_code ='[us]'
  AND mc.note LIKE '%(200%)%'
  AND (mc.note LIKE '%(USA)%'
       OR mc.note LIKE '%(worldwide)%')
  AND n.gender ='f'
  AND n.name LIKE '%Angel%'
  AND rt.role ='actress'
  AND t.production_year BETWEEN 2007 AND 2010
  AND ci.movie_id = t.id
  AND t.id = mc.movie_id
  AND ci.movie_id = mc.movie_id
  AND mc.company_id = cn.id
  AND ci.role_id = rt.id
  AND n.id = ci.person_id
  AND chn.id = ci.person_role_id
  AND an.person_id = n.id
  AND an.person_id = ci.person_id
  AND t.id = mi_votes.movie_id
  AND t.id = mi_budget.movie_id
  AND t.id = mi_gross.movie_id
  AND 24.68597945375489 + (-0.009269798761945815) * t.production_year + 0.000006922266433562143 * mi_votes.votes + (-0.000000005029019143423868) * mi_budget.budget + (-0.00000000030921567270) * mi_gross.gross >= 9.9
  AND 24.68597945375489 + (-0.009269798761945815) * t.production_year + 0.000006922266433562143 * mi_votes.votes + (-0.000000005029019143423868) * mi_budget.budget + (-0.00000000030921567270) * mi_gross.gross <= 11.0;