USE self1;

CREATE TABLE member (
	id VARCHAR(16) PRIMARY KEY,
	pw VARCHAR(330) NOT NULL ,
	NAME VARCHAR(100) NOT NULL ,
	email VARCHAR(100) NOT NULL ,
	tel VARCHAR(13) ,
	regdate TIMESTAMP NULL DEFAULT current_timestamp(),
	POINT INT(11) NULL DEFAULT '0'
)

CREATE TABLE board (
	bno INT(11) PRIMARY KEY AUTO_INCREMENT,
	title VARCHAR(200) NOT NULL,
	content VARCHAR(1000) NULL,
	author VARCHAR(16) NULL ,
	resdate TIMESTAMP NOT NULL DEFAULT current_timestamp(),
	cnt INT(11) NULL DEFAULT '0'
)