
-- Практическое задание по теме “Транзакции, переменные, представления”
-- Задание 1

Start transaction;
INSERT INTO SAMPLE2.users SELECT * from SHOP.users where id=2;
DELETE FROM SHOP.users where id=2;
Commit;

-- Задание 2
CREATE View cat as SELECT p.name 'prod', c.name 'catal' from SHOP.products p 
	JOIN SHOP.catalogs c 
		on p.catalog_id = c.id;
	
SELECT * From cat;

-- Задание 3
CREATE TABLE `august_data` (
  `data` bigint DEFAULT NULL
);

INSERT INTO august_data Value (1);
INSERT INTO august_data Value (2);
INSERT INTO august_data Value (3);
INSERT INTO august_data Value (4);
INSERT INTO august_data Value (5);
INSERT INTO august_data Value (6);
INSERT INTO august_data Value (7);
INSERT INTO august_data Value (8);
INSERT INTO august_data Value (9);
INSERT INTO august_data Value (10);
INSERT INTO august_data Value (11);
INSERT INTO august_data Value (12);
INSERT INTO august_data Value (13);
INSERT INTO august_data Value (14);
INSERT INTO august_data Value (15);
INSERT INTO august_data Value (16);
INSERT INTO august_data Value (17);
INSERT INTO august_data Value (18);
INSERT INTO august_data Value (19);
INSERT INTO august_data Value (20);
INSERT INTO august_data Value (21);
INSERT INTO august_data Value (22);
INSERT INTO august_data Value (23);
INSERT INTO august_data Value (24);
INSERT INTO august_data Value (25);
INSERT INTO august_data Value (26);
INSERT INTO august_data Value (27);
INSERT INTO august_data Value (28);
INSERT INTO august_data Value (29);
INSERT INTO august_data Value (30);

SELECT *, CASE 
when `data` = (SELECT DAYOFMONTH(created_at) as 'day' from products p2 GROUP BY day) THEN '1'
END AS 'includes'
from august_data ad;

-- Задание 4
Start transaction;
DROP VIEW cat_2;
CREATE VIEW cat_2 as SELECT id FROM SHOP.products p ORDER BY created_at DESC LIMIT 5;
SELECT * from cat_2;
DELETE from SHOP.products where id not in (SELECT * from cat_2);
commit;


-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"
-- Задание 1
DROP FUNCTION IF EXISTS hallo;
DELIMITER //
CREATE FUNCTION hallo ()
RETURNS TEXT DETERMINISTIC
BEGIN
	IF (HOUR(CURTIME()) > 0 and HOUR(CURTIME()) < 6) THEN RETURN 'Доброй ночи';
	ELSEIF (HOUR(CURTIME()) > 6 and HOUR(CURTIME()) < 12) THEN RETURN 'Доброе утро';
	ELSEIF (HOUR(CURTIME()) > 12 and HOUR(CURTIME()) < 18) THEN RETURN 'Добый день';
	ELSEIF (HOUR(CURTIME()) > 0 and HOUR(CURTIME()) > 18) THEN RETURN 'Добрый вечер';
END IF;
END//

SELECT hallo ();

-- Задание 2
DELIMITER //
DROP TRIGGER IF EXISTS not_null//
CREATE TRIGGER not_null BEFORE INSERT ON SHOP.products FOR EACH ROW
BEGIN
	IF(NEW.name is NULL and NEW.description is NULL) THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Укажите описание или название';
	END IF;
END//

SHOW triggers;
DROP trigger not_null;

INSERT INTO SHOP.products (id, name, description, price, catalog_id, created_at, updated_at)
VALUES(9, NULL, NULL, 7890.00, 1, '2020-09-18 15:02:53.0', '2020-09-18 15:02:53.0');


SHOW Create table august_data;

