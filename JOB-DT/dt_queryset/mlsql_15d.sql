EXPLAIN ANALYZE
SELECT MIN(at.title) AS aka_title,
       MIN(t.title) AS internet_movie_title
FROM 
    mi_budget
    CROSS JOIN keyword_counts
    CROSS JOIN title AS t
    CROSS JOIN aka_title AS at
    CROSS JOIN movie_info AS mi
    CROSS JOIN info_type AS it1
    CROSS JOIN movie_keyword AS mk
    CROSS JOIN keyword AS k
    CROSS JOIN cast_counts
    CROSS JOIN movie_companies AS mc
    CROSS JOIN company_name AS cn
    CROSS JOIN company_type AS ct
    CROSS JOIN mi_votes
    CROSS JOIN company_counts
WHERE cn.country_code = '[us]'
  AND it1.info = 'release dates'
  AND mi.note LIKE '%internet%'
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
  AND t.id = keyword_counts.movie_id
  AND t.id = cast_counts.movie_id
  AND t.id = company_counts.movie_id
  AND predict_gross_class(mi_votes.votes, mi_budget.budget, keyword_counts.keyword_count, t.production_year, cast_counts.cast_count, company_counts.company_count) = 'High_Gross';
