EXPLAIN ANALYZE
SELECT MIN(k.keyword) AS movie_keyword,
       MIN(n.name) AS actor_name,
       MIN(t.title) AS hero_movie
FROM cast_info AS ci,
     keyword AS k,
     movie_keyword AS mk,
     name AS n,
     title AS t, mi_votes, mi_budget, keyword_counts, cast_counts, company_counts
WHERE k.keyword IN ('superhero',
                    'sequel',
                    'second-part',
                    'marvel-comics',
                    'based-on-comic',
                    'tv-special',
                    'fight',
                    'violence')
  AND n.name LIKE '%Downey%Robert%'
  AND t.production_year > 2000
  AND k.id = mk.keyword_id
  AND t.id = mk.movie_id
  AND t.id = ci.movie_id
  AND ci.movie_id = mk.movie_id
  AND n.id = ci.person_id
  AND t.id = mi_votes.movie_id
  AND t.id = mi_budget.movie_id
  AND t.id = keyword_counts.movie_id
  AND t.id = cast_counts.movie_id
  AND t.id = company_counts.movie_id
  AND predict_gross_class(mi_votes.votes, mi_budget.budget, keyword_counts.keyword_count, t.production_year, cast_counts.cast_count, company_counts.company_count) = 'High_Gross';
