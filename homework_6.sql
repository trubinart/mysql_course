
-- Практическое задание по теме «Операторы, фильтрация, сортировка и ограничение»
-- Задание 1
UPDATE users set updated_at = NOW()

-- Задание 2
ALTER TABLE users drop column updated_at;
ALTER TABLE users ADD updated_at varchar(200);
UPDATE users set updated_at = 20.10.2017 8:10;
ALTER TABLE users ADD updated_at_dt DATETIME;
UPDATE users set updated_at_dt = str_to_date(updated_at, '%d.%m.%Y %h:%i');
ALTER TABLE users DROP updated_at,
RENAME COLUMN updated_at_dt TO updated_at;

-- Задание 3
UPDATE users set photo_id = 0 where id>90;
SELECT photo_id from users ORDER BY CASE
    when photo_id=0 THEN 300 ELSE photo_id END;

-- Задание 4 (делаю на примере hometown)
SELECT name, hometown FROM users Where hometown in ('South','East');

-- Задание 5
SELECT name, photo_id FROM users WHERE photo_id IN (5, 1, 2)
    ORDER BY CASE when photo_id < 5 THEN 300 ELSE photo_id END;

-- Практическое задание теме «Агрегация данных»
-- Задание 1
SELECT name, ROUND((TO_DAYS(NOW()) - TO_DAYS(birthday))/365.25) AS age from users;

-- Задание 2
ALTER TABLE users ADD birthday_name_of_week VARCHAR(200);
UPDATE users set birthday_name_of_week = DAYNAME(users.birthday);
SELECT birthday_name_of_week,COUNT(name) from users group by birthday_name_of_week;


-- Урок 6
-- Задание 1 (все друзья, кто отправлял пользователю письмо)
select target_user_id as friend_id from friend_requests where initiator_user_id = 8 and status ='approved'
and target_user_id IN (SELECT from_user_id from messages m where to_user_id = 8)
union
select initiator_user_id as friend_id from friend_requests where target_user_id = 8 and status ='approved'
and initiator_user_id IN (SELECT from_user_id from messages m where to_user_id = 8);

-- Задание 2
SELECT
    (SELECT CONCAT(name, ' ', surname) from users where id=from_user_id) as 'user',
    COUNT(*) as 'massage'
FROM messages where to_user_id=1 GROUP BY from_user_id order by massage DESC limit 1;

-- Задание 3
SELECT COUNT(reaction) as 'count_all_reactions' FROM likes_users where reaction = 1 and user_id_to in (SELECT id from
    (SELECT id, name, ROUND((TO_DAYS(NOW()) - TO_DAYS(birthday))/365.25) AS age from users order by age limit 10) `tbl`);

-- Задание 4
SELECT (SELECT SUM(`reaction_1`)+ SUM(`reaction_2`)+SUM(`reaction_3`)) as 'sum' , gender_2 from (SELECT u.gender `gender_2`, lu.user_id_from `id_2`, lu.reaction `reaction_1`, lp.reaction `reaction_2`, l2.reaction `reaction_3`
FROM likes_users lu
left outer join likes_photos lp
on lu.user_id_from = lp.user_id
left outer join users u
on lu.user_id_from = u.id
left outer join likes l2
on lu.user_id_from = l2.user_id) as `table_3` GROUP by gender_2;

-- Задание 5
Select (SELECT SUM(act1) + SUM(act2)) as 'sum2', name
from
(SELECT ac1.active_1 `act1`, ac2.active_2 `act2`, nm.name `name`
from (SELECT user_id, COUNT(id) as 'active_1' from posts group by user_id) as `ac1`
left outer JOIN (SELECT from_user_id,COUNT(id) as 'active_2' FROM messages group by from_user_id) as `ac2`
on ac1.user_id = ac2.from_user_id
left outer JOIN (SELECT id, name from users) as `nm`
on nm.id = ac1.user_id) as `result` group by name ORDER BY sum2 limit 10;





