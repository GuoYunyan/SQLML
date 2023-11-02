EXPLAIN ANALYZE
SELECT MIN(cn.name) AS producing_company,
       MIN(miidx.info) AS rating,
       MIN(t.title) AS movie
FROM 
    info_type AS it
    CROSS JOIN movie_info_idx AS miidx
    CROSS JOIN title AS t
    CROSS JOIN kind_type AS kt
    CROSS JOIN mi_budget
    CROSS JOIN keyword_counts
    CROSS JOIN cast_counts
    CROSS JOIN company_counts
    CROSS JOIN movie_companies AS mc
    CROSS JOIN company_name AS cn
    CROSS JOIN company_type AS ct
    CROSS JOIN movie_info AS mi
    CROSS JOIN info_type AS it2
    CROSS JOIN mi_votes
WHERE cn.country_code ='[us]'
  AND ct.kind ='production companies'
  AND it.info ='rating'
  AND it2.info ='release dates'
  AND kt.kind ='movie'
  AND mi.movie_id = t.id
  AND it2.id = mi.info_type_id
  AND kt.id = t.kind_id
  AND mc.movie_id = t.id
  AND cn.id = mc.company_id
  AND ct.id = mc.company_type_id
  AND miidx.movie_id = t.id
  AND it.id = miidx.info_type_id
  AND mi.movie_id = miidx.movie_id
  AND mi.movie_id = mc.movie_id
  AND miidx.movie_id = mc.movie_id
  AND t.id = mi_votes.movie_id
  AND t.id = mi_budget.movie_id
  AND t.id = keyword_counts.movie_id
  AND t.id = cast_counts.movie_id
  AND t.id = company_counts.movie_id
  AND predict_gross_class(mi_votes.votes, mi_budget.budget, keyword_counts.keyword_count, t.production_year, cast_counts.cast_count, company_counts.company_count) = 'High_Gross';
