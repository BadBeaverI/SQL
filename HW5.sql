CREATE OR REPLACE VIEW messages1 AS 
SELECT * FROM messages 
 
SELECT * FROM  messages1 WHERE  from_user_id = 1 
 
DROP VIEW messages1; 
 
SELECT COUNT(*), user_id, email 
FROM media 
JOIN users_id = media_user_id
GROUP BY user_id;