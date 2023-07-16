EXPLAIN ANALYZE
SELECT MIN(cn.name) AS movie_company,
       MIN(mi_idx.info) AS rating,
       MIN(t.title) AS mainstream_movie
FROM company_name AS cn,
     company_type AS ct,
     info_type AS it1,
     info_type AS it2,
     movie_companies AS mc,
     movie_info AS mi,
     movie_info_idx AS mi_idx,
     title AS t, mi_votes, mi_budget, mi_gross
WHERE cn.country_code = '[us]'
  AND ct.kind = 'production companies'
  AND it1.info = 'genres'
  AND it2.info = 'rating'
  AND mi.info IN ('Drama',
                  'Horror',
                  'Western',
                  'Family')
  AND mi_idx.info > '7.0'
  AND t.production_year BETWEEN 2000 AND 2010
  AND t.id = mi.movie_id
  AND t.id = mi_idx.movie_id
  AND mi.info_type_id = it1.id
  AND mi_idx.info_type_id = it2.id
  AND t.id = mc.movie_id
  AND ct.id = mc.company_type_id
  AND cn.id = mc.company_id
  AND mc.movie_id = mi.movie_id
  AND mc.movie_id = mi_idx.movie_id
  AND mi.movie_id = mi_idx.movie_id
  AND t.id = mi_votes.movie_id
  AND t.id = mi_budget.movie_id
  AND t.id = mi_gross.movie_id
  AND 24.68597945375489 + (-0.009269798761945815) * t.production_year + 0.000006922266433562143 * mi_votes.votes + (-0.000000005029019143423868) * mi_budget.budget + (-0.00000000030921567270) * mi_gross.gross >= 9.9
  AND 24.68597945375489 + (-0.009269798761945815) * t.production_year + 0.000006922266433562143 * mi_votes.votes + (-0.000000005029019143423868) * mi_budget.budget + (-0.00000000030921567270) * mi_gross.gross <= 11.0;