use mydb;
SELECT * FROM mydb.BOOK;

TRUNCATE BOOK;
LOAD DATA INFILE '/var/lib/mysql-files/assignment1/books_normalized.csv'
INTO TABLE BOOK
FIELDS TERMINATED BY '\t' 
-- ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


select count(TITLE), count(distinct(TITLE)) from BOOK;
select count(TITLE) from BOOK;

select TITLE from BOOK
group by TITLE
having count(*)>1;


TRUNCATE mydb.AUTHORS;
LOAD DATA INFILE '/var/lib/mysql-files/assignment1/authors_normalized.csv' 
INTO TABLE AUTHORS
CHARACTER SET UTF8
(NAME);

select * from AUTHORS;
describe AUTHORS;

select count(NAME), count(distinct(NAME)) from AUTHORS;
select count(distinct(naME)) from AUTHORS;
select count(name) from AUTHORS;

select name from AUTHORS
group by name
having count(*)>1
COLLATE utf8_bin;

SET SQL_SAFE_UPDATES = 0;
DELETE t1 FROM AUTHORS t1
        INNER JOIN
    AUTHORS t2 
WHERE
    t1.AUTHOR_ID < t2.AUTHOR_ID AND t1.name = t2.name;
SET SQL_SAFE_UPDATES = 1;

select * from BOOK_AUTHORS;

select count(*) from AUTHORS;
SHOW VARIABLES LIKE 'character_set_client';

TRUNCATE BOOK_AUTHORS;
set foreign_key_checks = 0;
LOAD DATA INFILE '/var/lib/mysql-files/assignment1/book_authors_normalized.csv' 
INTO TABLE BOOK_AUTHORS
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@ISBN, @AUTHOR_NAME)
set
	AUTHOR_ID = (select AUTHOR_ID FROM AUTHORS WHERE NAME = @AUTHOR_NAME COLLATE utf8_bin limit 1),
    ISBN = @ISBN;

set foreign_key_checks = 1;
    
SHOW CHARACTER SET;

INSERT INTO BOOK_AUTHORS VALUES ('1', 'asda');
select * from BOOK_AUTHORS;

set
	AUTHOR_ID = (select AUTHOR_ID FROM AUTHORS WHERE NAME = @AUTHOR_NAME),
    ISBN = @ISBN;


select author_id from AUTHORS where name = 'E. J. W. Barber';


select count(*) from BOOK where TITLE = '';
select count(*) from AUTHORS where NAME = '';

-- SHOW VARIABLES LIKE "secure_file_priv";

LOAD DATA INFILE '/var/lib/mysql-files/assignment1/borrowers_normalized.csv' 
INTO TABLE BORROWER
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
