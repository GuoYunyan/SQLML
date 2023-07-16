/* 1 0 0 20848 21536 21536 33684 80625 5245 7000 7000 16771 43811 41755 11708 1 17559 37091 3 12364 0 4 1 3 1 1 1 15 0 1 1 1 0 0 */
/* 0.001 35.847 40.584 19.929 158.358 6321.006 77.961 11.712 16.168 16.697 57.233 70.946 30.579 2.385 120.772 84.963 */
/* 0.0 0.0366063 0.064 */
EXPLAIN ANALYZE
SELECT MIN(cn.name) AS movie_company,
       MIN(mi_idx.info) AS rating,
       MIN(t.title) AS complete_euro_dark_movie
        
FROM
      keyword AS k CROSS JOIN
      movie_keyword AS mk CROSS JOIN
      movie_info_idx AS mi_idx CROSS JOIN
      info_type AS it2 CROSS JOIN
      mi_gross CROSS JOIN
      complete_cast AS cc CROSS JOIN
      comp_cast_type AS cct2 CROSS JOIN
      comp_cast_type AS cct1 CROSS JOIN
      mi_votes CROSS JOIN
      movie_info AS mi CROSS JOIN
      info_type AS it1 CROSS JOIN
      mi_budget CROSS JOIN
      movie_companies AS mc CROSS JOIN
      company_type AS ct CROSS JOIN
      company_name AS cn CROSS JOIN
      title AS t CROSS JOIN
      kind_type AS kt
WHERE cct1.kind = 'crew'
  AND cct2.kind != 'complete+verified'
  AND cn.country_code != '[us]'
  AND it1.info = 'countries'
  AND it2.info = 'rating'
  AND k.keyword IN ('murder',
                    'murder-in-title',
                    'blood',
                    'violence')
  AND kt.kind IN ('movie',
                  'episode')
  AND mc.note NOT LIKE '%(USA)%'
  AND mc.note LIKE '%(200%)%'
  AND mi.info IN ('Sweden',
                  'Germany',
                  'Swedish',
                  'German')
  AND mi_idx.info > '6.5'
  AND t.production_year > 2005
  AND kt.id = t.kind_id
  AND t.id = mi.movie_id
  AND t.id = mk.movie_id
  AND t.id = mi_idx.movie_id
  AND t.id = mc.movie_id
  AND t.id = cc.movie_id
  AND mk.movie_id = mi.movie_id
  AND mk.movie_id = mi_idx.movie_id
  AND mk.movie_id = mc.movie_id
  AND mk.movie_id = cc.movie_id
  AND mi.movie_id = mi_idx.movie_id
  AND mi.movie_id = mc.movie_id
  AND mi.movie_id = cc.movie_id
  AND mc.movie_id = mi_idx.movie_id
  AND mc.movie_id = cc.movie_id
  AND mi_idx.movie_id = cc.movie_id
  AND k.id = mk.keyword_id
  AND it1.id = mi.info_type_id
  AND it2.id = mi_idx.info_type_id
  AND ct.id = mc.company_type_id
  AND cn.id = mc.company_id
  AND cct1.id = cc.subject_id
  AND cct2.id = cc.status_id
  AND t.id = mi_votes.movie_id
  AND t.id = mi_budget.movie_id
  AND t.id = mi_gross.movie_id
  AND 24.68597945375489 + (-0.009269798761945815) * t.production_year + 0.000006922266433562143 * mi_votes.votes + (-0.000000005029019143423868) * mi_budget.budget + (-0.00000000030921567270) * mi_gross.gross >= 9.9
  AND 24.68597945375489 + (-0.009269798761945815) * t.production_year + 0.000006922266433562143 * mi_votes.votes + (-0.000000005029019143423868) * mi_budget.budget + (-0.00000000030921567270) * mi_gross.gross <= 11.0;