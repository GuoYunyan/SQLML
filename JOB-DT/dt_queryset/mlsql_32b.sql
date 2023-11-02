EXPLAIN ANALYZE
SELECT MIN(lt.link) AS link_type,
       MIN(t1.title) AS first_movie,
       MIN(t2.title) AS second_movie
FROM keyword AS k,
     link_type AS lt,
     movie_keyword AS mk,
     movie_link AS ml,
     title AS t1,
     title AS t2, mi_votes, mi_budget, keyword_counts, cast_counts, company_counts
WHERE k.keyword ='character-name-in-title'
  AND mk.keyword_id = k.id
  AND t1.id = mk.movie_id
  AND ml.movie_id = t1.id
  AND ml.linked_movie_id = t2.id
  AND lt.id = ml.link_type_id
  AND mk.movie_id = t1.id
  AND t1.id = mi_votes.movie_id
  AND t1.id = mi_budget.movie_id
  AND t1.id = keyword_counts.movie_id
  AND t1.id = cast_counts.movie_id
  AND t1.id = company_counts.movie_id
  AND predict_gross_class(mi_votes.votes, mi_budget.budget, keyword_counts.keyword_count, t1.production_year, cast_counts.cast_count, company_counts.company_count) = 'High_Gross';
