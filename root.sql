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
create table TABLE1(COL1 INT, COL2 VARCHAR(50), COL3 DATETIME);

create table TABLE2(COL1 INT auto_increment primary key, COL2 VARCHAR(50), COL3 DATETIME);

insert into TABLE2 (COL2,COL3) values ('TEST','2025-10-29');

select * from TABLE2;