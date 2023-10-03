SELECT DISTINCT firstname
FROM users
ORDER BY firstname;

SELECT *
FROM profiles
WHERE 
	gender ='m' AND timestampdiff(YEAR, birthday, NOW())> 35
	

SELECT status, COUNT(*) AS count
FROM friend_requests
GROUP BY status 


SELECT initiator_user_id, COUNT(*) as num_requests
FROM friend_requests
GROUP BY initiator_user_id
ORDER BY num_requests DESC
LIMIT 1;


SELECT name, name
FROM communities
WHERE name LIKE '_____';




