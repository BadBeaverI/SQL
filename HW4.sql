SELECT user_id  , COUNT(user_id) AS count
FROM users_communities 
GROUP BY user_id 

SELECT community_id, COUNT(*) AS count
FROM users_communities 
GROUP BY community_id

SELECT from_user_id, COUNT(*) AS count
FROM messages
WHERE to_user_id 
GROUP BY from_user_id
ORDER BY count DESC
LIMIT 1;

SELECT SUM(media_id)
FROM users 
JOIN profiles ON profiles.user_id  = users.id
JOIN likes ON likes.id = users.id
WHERE  age < 18

SELECT gender, SUM(media_id)  
FROM users 
JOIN profiles ON profiles.user_id  = users.id
JOIN likes ON likes.id = users.id
GROUP BY gender



