--sql 구문은 대소문자를 구분하지 않는다.
--단, 비밀번호는 대소문자 구분함

-- 조회(select)
-- select 컬럼명 => 5 
-- from 테이블명 => 1
-- where 조건절 => 2
-- group by => 3
-- having => 4
-- order by 컬럼명 asc(desc) => 6

-- EMP(사원) 테이블
-- empno(사번) : number(4,0) => 숫자, 4자리, 소수점 아래 자리수 0
-- ename(이름) : varchar2(10) => 문자 
-- job(직무) : varchar2
-- mgr(매니저-사번) 
-- hiredate(입사일)
-- sal(급여) : number(7,2) 
-- comm(수당)
-- deptno(부서번호) 

-- DEPT(부서) 테이블
-- deptno(부서번호)
-- dname(부서명)
-- loc(부서위치)

-- 조회 기본 구문
-- SELECT 보고싶은 열 이름, ... FROM 테이블명 (where 조건);

-- (1) 전체 사원 조회
SELECT * FROM EMP e;
-- (2) 전체 사원의 이름만 
SELECT ename FROM EMP e;
-- (3) 전체 사원의 사번과 사원명, 부서번호만 추출
SELECT empno, ename, deptno FROM EMP e ;
-- (4) 전체 사원의 부서번호 추출 + 중복 데이터는 제거(distinct)
SELECT DISTINCT deptno FROM EMP e ;
-- (5) alais(별칭)
SELECT ename AS "사원명" FROM EMP e;
-- (6) 연봉구하기(select*12+comm)
select empno, sal*12+comm 연봉 FROM emp e;
-- (7) 별칭에 ""반드시 넣어줘야하는 경우 : 중간에 공백이 존재할 때
SELECT ename "사원 이름" FROM EMP e;
-- (8) 오름차순(default), 내림차순 정렬 : order by 정렬기준 열 이름 ASC(DESC), ... ;
SELECT * FROM Emp e ORDER BY sal;
-- (9) 정렬 조건이 여러가지일 경우
SELECT * FROM Emp e ORDER BY sal DESC, ename ASC;

--[실습]
-- empno : employee_no
-- ename : employee_name
-- mgr : manager
-- sal : salary
-- comm : commission
-- deptno : department_no
-- 별칭 지정, 부서번호를 기준으로 내림차순 정렬(단, 같은 부서번호의 경우 이름 오름차순)
-- Ctrl + Shift + F (코드 가독성 높이기)
SELECT
	empno employee_no,
	ename employee_name,
	mgr manager,
	sal salary,
	comm commission,
	deptno department_no
FROM
	EMP e
ORDER BY
	deptno DESC,
	ename ASC;

-- (10) 부서번호가 30번인 사원정보 조회 / = 같다, 문자 ' '(홑따옴표) 사용, and 및 or 사용 
SELECT * FROM EMP e WHERE deptno=30;
-- 사번이 7698
SELECT * FROM EMP e WHERE empno=7698;
-- 부서번호가 30, 사원직책이 salesman
SELECT * FROM EMP e WHERE deptno =30 AND job='SALESMAN';
-- 부서번호가 30이거나 사원직책이 analyst
SELECT * FROM EMP e WHERE deptno =30 OR job='ANALYST';

-- (11) 연산자
-- =, >, <, >=, <=, and, or, 같지않다 {!=, <>, ^=}
-- in, between A and B
-- 연봉(sal * 12)이 36000인 사원 조회
SELECT * FROM EMP e WHERE sal*12=36000; 
-- 급여가 3000 초과인 사원 조회
SELECT * FROM EMP e WHERE sal>3000;
-- 이름이 'F' 이후의 문자로 시작하는 사원 조회 (F-Z)
SELECT * FROM EMP e WHERE e.ENAME >= 'F';
-- 직무가 manager, salesman, clerk인 사원 조회
SELECT * FROM EMP e  WHERE job='MANAGER' OR job ='SALESMAN' OR job='CLERK';
-- sal이 3000이 아닌 사원 조회
SELECT * FROM EMP e  WHERE sal != 3000;
SELECT * FROM EMP e  WHERE sal <> 3000;
SELECT * FROM EMP e  WHERE sal ^= 3000;
-- 직무가 manager, salesman, clerk인 사원 조회 + IN
SELECT * FROM EMP e  WHERE job IN('MANAGER','SALESMAN','CLERK');
-- 직무가 manager, salesman, clerk가 아닌 사원 조회 + NOT IN
SELECT * FROM EMP e  WHERE job NOT IN('MANAGER','SALESMAN','CLERK');
-- 부서번호가 10, 20인 사원 조회(OR, IN)
SELECT * FROM EMP e  WHERE deptno=10 OR deptno=20;
SELECT * FROM EMP e  WHERE deptno IN (10,20);
-- sal이 2000이상 3000이하 사원
SELECT * FROM EMP e  WHERE sal BETWEEN 2000 AND 3000;
-- sal이 2000이상 3000이하가 아닌 사원
SELECT * FROM EMP e  WHERE sal NOT BETWEEN 2000 AND 3000;

-- (12) like + 와일드카드(%, _)
-- % : 길이와 상관없이(문자 없는 경우도 포함) 모든 문자 데이터를 의미
-- _ : 한개의 문자 데이터
-- 사원명이 S로 시작하는 사원들의 정보 조회
SELECT * FROM EMP e WHERE e.ENAME LIKE 'S%';
-- 사원명의 두번째 글자가 L인 사원들의 정보 조회
SELECT * FROM EMP e WHERE e.ENAME LIKE '_L%';
-- 사원명에 AM이 포함된 사원들의 정보 조회
SELECT * FROM EMP e WHERE e.ENAME LIKE '%AM%';
-- 사원명에 AM이 포함되지 않은 사원들의 정보 조회
SELECT * FROM EMP e WHERE e.ENAME NOT LIKE '%AM%';

-- (13) null 값은 비교시 = 혹은 !=를 사용할 수 없음
SELECT * FROM EMP e WHERE e.COMM IS NULL;
SELECT * FROM EMP e WHERE e.COMM IS NOT NULL;