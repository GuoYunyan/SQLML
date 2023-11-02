EXPLAIN ANALYZE
SELECT MIN(n.name) AS voicing_actress,
       MIN(t.title) AS jap_engl_voiced_movie
FROM 
    mi_budget
    CROSS JOIN title AS t
    CROSS JOIN cast_counts
    CROSS JOIN movie_companies AS mc
    CROSS JOIN company_counts
    CROSS JOIN keyword_counts
    CROSS JOIN mi_votes
    CROSS JOIN company_name AS cn
    CROSS JOIN cast_info AS ci
    CROSS JOIN char_name AS chn
    CROSS JOIN role_type AS rt
    CROSS JOIN aka_name AS an
    CROSS JOIN name AS n
    CROSS JOIN movie_info AS mi
    CROSS JOIN info_type AS it
WHERE ci.note IN ('(voice)',
                  '(voice: Japanese version)',
                  '(voice) (uncredited)',
                  '(voice: English version)')
  AND cn.country_code ='[us]'
  AND it.info = 'release dates'
  AND n.gender ='f'
  AND rt.role ='actress'
  AND t.production_year > 2000
  AND t.id = mi.movie_id
  AND t.id = mc.movie_id
  AND t.id = ci.movie_id
  AND mc.movie_id = ci.movie_id
  AND mc.movie_id = mi.movie_id
  AND mi.movie_id = ci.movie_id
  AND cn.id = mc.company_id
  AND it.id = mi.info_type_id
  AND n.id = ci.person_id
  AND rt.id = ci.role_id
  AND n.id = an.person_id
  AND ci.person_id = an.person_id
  AND chn.id = ci.person_role_id
  AND t.id = mi_votes.movie_id
  AND t.id = mi_budget.movie_id
  AND t.id = keyword_counts.movie_id
  AND t.id = cast_counts.movie_id
  AND t.id = company_counts.movie_id
  AND predict_gross_class(mi_votes.votes, mi_budget.budget, keyword_counts.keyword_count, t.production_year, cast_counts.cast_count, company_counts.company_count) = 'High_Gross';
