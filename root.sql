-- MY SQL

-- 사용할 데이터베이스 지정
use sakila;

-- customer 테이블 조회
select * from customer;
-- first_name 이 MARIA인 데이터 조회
select * from customer where first_name='MARIA';
-- first_name 열에서 데이터가 A,B,C 순으로 MARIA 보다 앞에 위치한 데이터 조회
select * from customer where first_name<'MARIA';
-- first_name이 M ~ O 사이가 아닌 데이터 조회
select * from customer where first_name not between 'M' and 'O'; 
-- first_name이 MARIA, LINDA인 데이터 조회
select * from customer where first_name in ('MARIA','LINDA');
-- first_name이 A로 시작하는 데이터 조회
select * from customer where first_name like 'A%';
-- first_name이 A로 시작하고 문자열 길이가 3인 데이터 조회
select * from customer where first_name like 'A__';
-- first_name이 A로 시작하고 A로 끝나면서 문자열 길이가 4인 데이터 조회
select * from customer where first_name like 'A__A';


-- film 테이블
-- special_features를 기준으로 그룹화 후 count 
select special_features, count(*) as count from film group by special_features;
-- special_features, rating 기준으로 그룹화 후 rating이 G인 데이터 조회
select special_features, rating from film group by special_features, rating having rating='G';


-- address 테이블
-- address_id가 200 미만인 데이터 조회
select * from address where address_id<200;
-- address_id가 5~10 범위에 해당하는 데이터 조회
select * from address where address_id between 5 and 10;
-- address2 열 데이터가 null이 아닌 데이터 조회
select * from address where address2 is not null;


-- city 테이블 조회
-- country_id가 103 or 86 이면서 city 열이 'Cheju', 'Sunnyvale', 'Dallas'인 데이터 조회
select * from city where country_id in (103,86) and city in ('Cheju','Sunnyvale','Dallas');


-- payment 테이블 조회
-- payment_date가 2005-07-09 미만인 행 조회
select * from payment where payment_date < '2005-07-09';


-- limit : 특정 조건에 해당하는 데이터 중에서 상위 n 개의 데이터 보기 / 범위 지정해서 보기
-- customer 테이블에서 store_id 내림차순, first_name 오름차순(상위 10개만)
select * from customer order by store_id desc, first_name asc limit 10;
-- limit N1, N2 : 상위 N1 다음행부터 N2개의 행 조회
-- MY SQL에서만 사용 가능
-- 101번째부터 10개
select * from customer order by store_id desc, first_name asc limit 100,10;
-- limit ~ offset
-- 표준 SQL 문법
-- 101번째부터 10개
select * from customer order by store_id desc, first_name asc limit 10 offset 100;


-- 데이터베이스 생성
create database if not exists EXAM;
use EXAM;
-- 테이블 생성
-- 데이터 유형
--  숫자형 : TINYINT(1byte), SMALLINT(2byte), MEDIUMINT(3byte), INT(4byte), BIGINT(8byte)
--	실수형 : 고정소수점 방식 : DECIMAL / NUMERIC
--			부동소수점 방식 : FLOAT, DOUBLE
--	문자형 : CHAR(n) - 고정길이문자열
--			VARCHAR(n) 
--	날짜형 : TIME, DATE, DATETIME, TIMESTAMP

create table TABLE1(COL1 INT, COL2 VARCHAR(50), COL3 DATETIME);
-- primary key 존재하는 테이블 생성
create table TABLE2(COL1 INT auto_increment primary key, COL2 VARCHAR(50), COL3 DATETIME);
-- COL1은 입력하지 않으면 자동으로 증가하면서 값이 생성됨
insert into TABLE2 (COL2,COL3) values ('TEST','2025-10-29');
-- 직접 값을 지정해줄 수도 있음
insert into TABLE2 (COL1,COL2,COL3) values (3,'TEST','2025-10-29');
-- 그 다음 숫자부터 들어감 // 4
insert into TABLE2 (COL2,COL3) values ('TEST','2025-10-29');

select * from TABLE2;

-- 현재 auto_increment로 생성된 마지막 값 확인 // 4
select last_insert_id();

-- auto_increment 시작값 변경
alter table TABLE2 auto_increment = 100;
-- 100부터 시작
insert into TABLE2 (COL2,COL3) values ('TEST','2025-10-29');
-- auto_increment 증가값 변경 // 같은 DB내의 다른 테이블에도 영향을 미치기 때문에 사용에 주의
set @@auto_increment_increment =5;
-- 5씩 증가
insert into TABLE2 (COL2,COL3) values ('TEST','2025-10-29'); 
-- 원상복구
set @@auto_increment_increment =1;



-- 테이블 복사
select * from EXAM_INSERT_SELECT_FROM;
select * from EXAM_INSERT_SELECT_TO;
select * from EXAM_SELECT_NEW;

create table EXAM_INSERT_SELECT_FROM(COL1 INT, COL2 VARCHAR(10));
create table EXAM_INSERT_SELECT_TO(COL1 INT, COL2 VARCHAR(10));

insert into EXAM_INSERT_SELECT_FROM (COL1, COL2) values (1, 'Do');
insert into EXAM_INSERT_SELECT_FROM (COL1, COL2) values (2, 'It');
insert into EXAM_INSERT_SELECT_FROM (COL1, COL2) values (3, 'MySQL');

--  FROM의 데이터를 To로 옮기기
insert into EXAM_INSERT_SELECT_TO select * from EXAM_INSERT_SELECT_FROM;

-- 테이블 생성과 동시에 데이터 옮기기 // AS
create table EXAM_SELECT_NEW as select * from EXAM_INSERT_SELECT_FROM;

-- 날짜형 타입들의 차이
create table EXAM_DATE_TABLE(COL1 DATE, COL2 TIME, COL3 DATETIME, COL4 TIMESTAMP);
insert into EXAM_DATE_TABLE values (NOW(),NOW(),NOW(),NOW());
select * from EXAM_DATE_TABLE;



-- Oracle : 사용자 => DB
-- MySQL : DB // 사용자들에게 권한을 부여

-- 사용자 생성 ------------------------------------------
-- ID 대소문자 구분함

-- localhost : 내 컴퓨터(로컬 접속만 가능)
create user 'test1'@'localhost' identified by '12345';
-- % : 모든 IP에서 접속 가능(외부 접속 허용)
create user 'test1'@'%' identified by '12345';

-- 권한 부여
grant 권한목록 on DB.테이블 to '사용자이름'@'호스트'

grant all privileges on exam.* to 'test1'@'localhost';
-- 변경사항 반영
flush privileges;

-- 사용자 삭제
drop user 'test1'@'localhost';