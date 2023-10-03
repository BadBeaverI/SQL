# Задание 1
DROP FUNCTION IF EXISTS vk.delete_user; 
 
DELIMITER // 
create function vk.delete_user(delete_user_id bigint unsigned)  
RETURNS INT READS SQL DATA 
  BEGIN 
 
 DELETE FROM   messages 
 where from_user_id = delete_user_id 
 or to_user_id = delete_user_id;  
 
 DELETE FROM likes 
 where user_id = delete_user_id 
 or media_id = delete_user_id;  
 
 DELETE FROM media 
 where user_id = delete_user_id; 
  
 DELETE FROM profiles 
 where user_id = delete_user_id; 
 
RETURN delete_user_id; 
end 
 
DELIMITER ; 
 
select vk.delete_user(8)

select * from profiles



# Задание 2
use VK;
DROP PROCEDURE IF EXISTS delete_user;

DELIMITER $$

CREATE PROCEDURE delete_user(delete_id BIGINT UNSIGNED)
BEGIN
    DECLARE _rollback BOOL DEFAULT 0;
     DECLARE code varchar(100);
     DECLARE error_string varchar(100);
     DECLARE tran_result varchar(100);

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   begin
      SET _rollback = 1;
  GET stacked DIAGNOSTICS CONDITION 1
          code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
      set tran_result := concat('Error occured. Code: ', code, '. Text: ', error_string);
    end;
            
    START TRANSACTION;
    DELETE FROM messages
    WHERE (from_user_id = del_id) OR (to_user_id = del_id);
    
    DELETE FROM friend_requests
    WHERE (initiator_user_id = del_id) OR (target_user_id = del_id);
    
    DELETE FROM users_communities
    WHERE user_id = del_id;
    
    DELETE FROM likes
    WHERE (user_id = del_id) 
    OR (media_id IN (SELECT id FROM media WHERE user_id = del_id));
    
    UPDATE profiles
    SET photo_id = NULL
    WHERE photo_id IN (SELECT id FROM media WHERE user_id = del_id);
    
    DELETE FROM media
    WHERE user_id = del_id;
    
    DELETE FROM profiles
    WHERE user_id = del_id;
    
    DELETE FROM users
    WHERE id = del_id;  
      IF _rollback THEN
    SELECT tran_result;
         ROLLBACK;
      ELSE
    set tran_result := concat(del_id);
        SELECT del_id;
         COMMIT;
      END IF;
END$$

DELIMITER ;

# Вызов процедуры
CALL del_user(1);