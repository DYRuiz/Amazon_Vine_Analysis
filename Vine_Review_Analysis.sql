CREATE TABLE vine_table (
  review_id TEXT PRIMARY KEY,
  star_rating INTEGER,
  helpful_votes INTEGER,
  total_votes INTEGER,
  vine TEXT,
  verified_purchase TEXT
);

SELECT * 
INTO vine_filter
FROM vine_table
WHERE total_votes >20;

SELECT * 
INTO votes
FROM vine_filter
WHERE CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >= 0.5;

SELECT * 
INTO vine
FROM votes
WHERE vine ='Y';

SELECT * 
INTO unpaid
FROM votes
WHERE vine ='N';

SELECT *
INTO five_star_unpaid
FROM unpaid
WHERE star_rating = 5;

SELECT *
INTO five_star_vine
FROM vine
WHERE star_rating = 5;

SELECT vine, count(total_votes) 
INTO vote_summary
FROM votes
GROUP BY vine;

SELECT vine, count(total_votes)
INTO five_star_summary
from votes
WHERE star_rating = 5
GROUP BY vine;

SELECT * FROM vote_summary;
SELECT * FROM five_star_summary;

SELECT vote_summary.vine, vote_summary.count AS total_votes, five_star_summary.count AS five_star_votes,
(CAST(five_star_summary.count AS FLOAT)/CAST(vote_summary.count AS FLOAT)) AS five_star_perc
INTO five_star_vote_analysis
FROM vote_summary
JOIN five_star_summary
ON vote_summary.vine = five_star_summary.vine;

SELECT * FROM five_star_vote_analysis;