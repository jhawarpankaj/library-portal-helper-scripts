use mydb;

LOAD DATA INFILE '/var/lib/mysql-files/assignment1/books_normalized.csv'
INTO TABLE BOOK
FIELDS TERMINATED BY '\t' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/var/lib/mysql-files/assignment1/authors_normalized.csv' 
INTO TABLE AUTHORS
CHARACTER SET UTF8
(NAME);

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

LOAD DATA INFILE '/var/lib/mysql-files/assignment1/borrowers_normalized.csv' 
INTO TABLE BORROWER
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
