CREATE DATABASE teaspoon;

USE teaspoon;

CREATE TABLE sample(
	NO INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(100)
);

INSERT INTO sample VALUES(DEFAULT, '홍길동');
INSERT INTO sample VALUES(DEFAULT, '강감찬');
INSERT INTO sample VALUES(DEFAULT, '이순신');
INSERT INTO sample VALUES(DEFAULT, '서광');
INSERT INTO sample VALUES(DEFAULT, '이소윤');