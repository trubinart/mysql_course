-- ПРАКТИЧЕСКОЕ ЗАДАНИЕ Урок 7
-- Я переформулировал задания, так как у нас БД соц. сети, а не интернет магазин

-- Задание 1
-- Составьте список пользователей users, которые отправили хотя бы два сообщения

SELECT name from users u2 where id in
(SELECT from_user_id from (SELECT from_user_id , COUNT(to_user_id) as count_mes from messages m group by from_user_id) `tbl` where count_mes >= 2);


-- Задание 2
-- Выведите список пользователей и их фото, которые соответствуют пользвателю

SELECT u.name 'name', p.description 'photo' from users u
left outer join photos p
on u.id = p.user_id
