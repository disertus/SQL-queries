-- LEFT and RIGHT JOINs, FULL JOINs are types of OUTER joins
-- they keep the records of the original table while reaching out for the records from the new one.
-- On the contrary, INNER JOINs keep only the records, that are present IN both tables - key fields that are in both tables (on the intersection)



-- ### LEFT JOIN checks the key field in the left table, and the key field in the right table,
-- then it extracts the values from the right table (just as in INNER JOIN) no matter if the keys are present in the right table or not
-- if the keys from LEFT are missing in the RIGHT, the selected values will be NULL
-- keys present in RIGHT but missing in LEFT will not be presented at all.
-- Sometimes there may be multiple matches for one LEFT key, all of those will be represented
SELECT p1.country, prime_minister, president
FROM prime_minsters AS p1
LEFT JOIN presidents AS p2
ON p1.country = p2.country;

-- RIGHT JOIN is much less common then inner or left JOINs
-- It is the reverse of the LEFT JOIN
