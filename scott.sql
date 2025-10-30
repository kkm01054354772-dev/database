--SQL
-- 1. 데이터 정의 언어(DDL : Data Define Language)
-- 2. 데이터 조작 언어(DML : Data Manipulation Language) :SELECT(조회), INSERT(입력), UPDATE(수정), DELETE(삭제) => CRUD
-- 3. 데이터 제어 언어(DCL : Data Control Language)


--sql 구문은 대소문자를 구분하지 않는다.
--단, 비밀번호는 대소문자 구분함
---------------------------- 데이터 조작 언어(DML) ----------------------------------
---------------------------- 조회(select) ----------------------------------
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


-- 집합연산자
-- 합집합(UNION, UNION ALL), 교집합(INTERSECT), 차집합(MUNUS)

-- 합집합 : 출력하려는 열의 개수, 자료형이 일치해야 함.
-- UNION : 중복제거
-- DEPTNO=10 UNION DEPTNO=20 
SELECT
	e.EMPNO ,e.ENAME ,e.SAL 
FROM
	EMP e
WHERE
	e.DEPTNO = 10
UNION
SELECT
	e.EMPNO ,e.ENAME ,e.SAL 
FROM
	EMP e
WHERE
	e.DEPTNO = 20;

-- UNION ALL : 중복을 제거하지 않고 가져옴
SELECT
	e.EMPNO ,e.ENAME ,e.SAL 
FROM
	EMP e
WHERE
	e.DEPTNO = 10
UNION ALL
SELECT
	e.EMPNO ,e.ENAME ,e.SAL 
FROM
	EMP e
WHERE
	e.DEPTNO = 10;

-- 차집합(MINUS)
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.SAL
FROM
	EMP e
MINUS
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.SAL
FROM
	EMP e
WHERE
	e.DEPTNO = 10;


--INTERSECT
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.SAL
FROM
	EMP e

INTERSECT
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.SAL
FROM
	EMP e
WHERE
	e.DEPTNO = 10;


-- [실습 예제]
-- 1. 사원 이름이 S로 끝나는 사원 데이터 조회
SELECT * FROM EMP e WHERE e.ENAME LIKE '%S';
-- 2. 30번 부서에 근무하고 있는 사원중에 JOB이 SALESMAN인 사원의 사번, 이름, 직책, 급여, 부서번호 조회
SELECT e.EMPNO , e.ENAME , e.JOB , e.SAL , e.DEPTNO FROM EMP e WHERE e.DEPTNO = 30 AND e.JOB = 'SALESMAN';
-- 3. 20번, 30번 부서에 근무하고 있는 사원 중 급여가 2000 초과인 사원을 다음 두 방식의 SELECT문으로 작성 사원번호, 이름 직책, 급여, 부서번호
-- 집합 연산자 사용
SELECT e.EMPNO , e.ENAME , e.JOB , e.SAL , e.DEPTNO FROM EMP e WHERE e.DEPTNO = 20 AND e.SAL > 2000 
UNION
SELECT e.EMPNO , e.ENAME , e.JOB , e.SAL , e.DEPTNO FROM EMP e WHERE e.DEPTNO = 30 AND e.SAL > 2000;
-- 집합 연산자 미사용 
SELECT e.EMPNO , e.ENAME , e.JOB , e.SAL , e.DEPTNO FROM EMP e WHERE e.DEPTNO IN (20,30) AND e.SAL > 2000;
-- 4. NOT BETWEEN A AND B 연산자를 사용하지 않고 급여열이 2000이상 3000이하 범위 이외의 값을 가진 데이터 조회
SELECT * FROM EMP e WHERE e.SAL < 2000 OR e.SAL > 3000;
-- 5. 사원 이름에 E가 포함된 30번 부서의 사원 중 급여가 1000 ~ 2000 사이가 아닌 사원의 사원명, 사번, 급여, 부서번호 조회
SELECT
	e.ENAME ,
	e.EMPNO ,
	e.SAL ,
	e.DEPTNO
FROM
	EMP e
WHERE
	e.ENAME LIKE '%E%'
	AND e.DEPTNO = 30
	AND e.SAL NOT BETWEEN 1000 AND 2000;
-- 6. 추가 수당이 없고, 상급자가 있고 직책이 MANAGER, CLERK인 사원 중에서 이름의 두번째 글자가 L이 아닌 사원 정보 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.COMM IS NULL
	AND e.MGR IS NOT NULL
	AND e.JOB IN('MANAGER', 'CLERK')
	AND e.ENAME NOT LIKE '_L%'; 


-- 함수 
-- 1. 문자함수
-- UPPER(문자열) : 대문자 변환
-- LOWER(문자열) : 소문자 변환
-- INITCAP(문자열) : 첫글자는 대문자, 나머지는 소문자
-- LENGTH(문자열) : 문자열 길이
-- LENGTHB(문자열) : 문자열의 byte 길이
-- SUBSTR(문자열데이터, 시작위치, 추출길이) : 문자열 부분 추출
-- INSTR(대상문자열, 위치를 찾으려는 문자, 위치찾기 시작 위치, 찾으려는 문자가 몇번째인지) : 문자열 데이터 내에세 특정 문자 위치 찾기
-- REPLACE(문자열, 찾는문자, 바꿀문자) : 문자열 대체
-- CONCAT(문자열1, 문자열2) : 두 문자열 데이터 합치기
-- TRIM(삭제옵션(opt), 삭제할문자(opt) FROM 원본문자열)
-- 	(1) 삭제옵션 : LEADING, TRAILING, BOTH
-- LTRIM(원본문자열, 삭제할 문자열)
-- RTRIM(원본문자열, 삭제할 문자열)

SELECT ENAME, UPPER(ENAME), lOWER(ENAME), INITCAP(ENAME) FROM EMP e ;

-- LENGTH, LENGTHB 비교 // 영어일 때는 동일
SELECT ENAME, LENGTH(ENAME), LENGTHB(ENAME) FROM EMP e ;
-- DUAL : 임시연산이나 함수 결과값 확인 용도의 SYS 소유의 더미 테이블
-- XE21 (한글 한자당 3BYTE 사용)
SELECT LENGTH('한글'), LENGTHB('한글') FROM DUAL;
-- 사원명 길이가 5이상인 사원을 조회
SELECT * FROM EMP e  WHERE LENGTH(E.ENAME)>=5;
-- 직책명이 6자 이상인 사원 조회
SELECT * FROM EMP e  WHERE LENGTH(E.JOB)>=6;

-- SUBSTR
SELECT JOB, SUBSTR(JOB,1,2), SUBSTR(JOB,3,2), SUBSTR(JOB, 5) FROM EMP e ;
-- 사원명을 세번째 글자부터 끝까지 출력
SELECT e.ENAME, SUBSTR(E.ENAME,3) FROM EMP e;
-- -인덱스 : 뒤에서부터 -1
SELECT JOB, SUBSTR(JOB,-LENGTH(JOB)), SUBSTR(JOB,-LENGTH(JOB),2), SUBSTR(JOB, -3) FROM EMP e ;

-- INSTR
SELECT
	INSTR('HELLO, ORACLE!', 'L') AS "첫번째 l",
	INSTR('HELLO, ORACLE!', 'L', 5) AS "5 이후로 첫번째 L",
	INSTR('HELLO, ORACLE!', 'L',2,2) AS "2 이후로 두번째 L"
FROM
	DUAL;
-- 사원명에 문자 S가 포함된 사원 조회
-- (1) LIKE (2) INSTR
SELECT * FROM EMP e  WHERE INSTR(E.ENAME,'S')>0;

-- REPLACE
-- 010-4526-7858 => 01045267858
SELECT
	'010-4526-7858',
	REPLACE('010-4526-7858', '-', ' ') AS REPLACE1,
	REPLACE('010-4526-7858', '-') AS PREPLACE2
FROM
	DUAL;

-- CONCAT() 또는 ||
-- EMPNO, ENAME을 합치기
SELECT
	CONCAT(e.EMPNO , CONCAT(' : ', E.ENAME) ) AS CONCAT1,
	E.EMPNO || ' : ' || E.ENAME AS CONCAT2
FROM
	EMP e ;

-- TRIM
SELECT
	'[' || TRIM(' __Oracle__ ') || ']' AS TRIM,
	'[' || TRIM(LEADING FROM ' __Oracle__ ') || ']' AS TRIM_LEADING,
	'[' || TRIM(TRAILING FROM ' __Oracle__ ') || ']' AS TRIM_TRAILING,
	'[' || TRIM(BOTH FROM ' __Oracle__ ') || ']' AS TRIM_BOTH
	FROM
	DUAL;
SELECT
	'[' || TRIM(' _Oracle_ ') || ']' AS TRIM,
	'[' || LTRIM( ' _Oracle_ ') || ']' AS LTRIM,
	'[' || RTRIM(' _Oracle_ ') || ']' AS RTRIM,
	'[' || LTRIM( '<_Oracle_>','_<') || ']' AS LTRIM2,
	'[' || RTRIM( '<_Oracle_>','>_') || ']' AS RTRIM2
	FROM
	DUAL;


-- 2. 숫자함수
-- ROUND(숫자, 위치) : 반올림
-- TRUNC(숫자, 위치) : 버림
-- CEIL(숫자) : 지정된 숫자보다 큰 정수 중 가장 작은 정수 반환
-- FLOOR(숫자) : 지정된 숫자보다 작은 정수 중 가장 큰 정수 반환
-- MOD(숫자, 나눌숫자) : 지정된 숫자를 나눈 나머지 반환

-- ROUND
SELECT
	ROUND(1234.5678) AS ROUND,
	ROUND(1234.5678, 0 )AS ROUND0,
	ROUND(1234.5678, 1 )AS ROUND1,
	ROUND(1234.5678, 2 )AS ROUND2,
	ROUND(1234.5678,-1 )AS ROUND_MINUS1,
	ROUND(1234.5678,-2 )AS ROUND_MINUS2
FROM
	DUAL;

-- TRUNC
SELECT
	TRUNC(1234.5678) AS TRUNC,
	TRUNC(1234.5678, 0 )AS TRUNC0,
	TRUNC(1234.5678, 1 )AS TRUNC1,
	TRUNC(1234.5678, 2 )AS TRUNC2,
	TRUNC(1234.5678,-1 )AS TRUNC_MINUS1,
	TRUNC(1234.5678,-2 )AS TRUNC_MINUS2
FROM
	DUAL;

-- CEIL, FLOOR
SELECT
	CEIL(3.14),
	FLOOR(3.14),
	CEIL(-3.14),
	FLOOR(-3.14)
FROM
	DUAL;

-- MOD
SELECT
	MOD(15, 6),
	MOD(10, 2),
	MOD(11, 2)
FROM
	DUAL;


-- 3. 날짜함수
-- 날짜 데이터 + 숫자 : 이후 날짜 반환
-- 날짜 데이터 - 숫자 : 이전 날짜 반환
-- 날짜 데이터 - 날짜 데이터 : 일수차이 반환
-- 날짜 데이터 + 날짜 데이터 : 연산불가 --
-- ADD_MONTHS(날짜데이터, 월수)
-- MONTHS_BETWEEN(날짜데이터1, 날짜데이터2)
-- NEXT_DAY(날짜데이터, 요일문자) : 다음 요일의 날짜
-- LAST_DAY(날짜데이터) : 그 달의 마지막 날짜

-- SYSDATE : 오라클에서 시스템 날짜 출력
-- CURRENT_DATE 

SELECT SYSDATE, CURRENT_DATE, CURRENT_TIMESTAMP FROM DUAL;

-- ADD_MONTHS()
SELECT SYSDATE, ADD_MONTHS(SYSDATE,3) FROM DUAL;
-- 입사 50주년이 되는 날짜 구하기
SELECT E.HIREDATE, ADD_MONTHS(E.HIREDATE,600) FROM EMP e ;
-- 입사 40년이 넘은 사원 조회
SELECT e.ENAME, E.HIREDATE  FROM EMP e WHERE SYSDATE > ADD_MONTHS(E.HIREDATE,480);

--MONTH_BETWEEN()
SELECT
	E.EMPNO,
	E.HIREDATE ,
	SYSDATE,
	MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTH1,
	MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTH2,
	TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTH3
FROM
	EMP e;

-- LAST_DAY(), NEXT_DAY()
SELECT SYSDATE, LAST_DAY(SYSDATE), NEXT_DAY(SYSDATE,'월요일') FROM DUAL;


-- 4. 형변환 함수
-- TO_CHAR() : 날짜, 숫자 데이터를 문자로 변환
-- TO_NUMBER() : 문자 데이터를 숫자로 변환
-- TO_DATE() : 문자 데이터를 날짜 데이터로 변환

-- TO_CHAR()
-- 날짜 -> 문자
SELECT
	SYSDATE,
	TO_CHAR(SYSDATE, 'YYYY/MM/DD') ,
	TO_CHAR(SYSDATE, 'MM'),
	TO_CHAR(SYSDATE, 'MON') ,
	TO_CHAR(SYSDATE, 'MONTH') ,
	TO_CHAR(SYSDATE, 'DD') ,
	TO_CHAR(SYSDATE, 'DY') ,
	TO_CHAR(SYSDATE, 'DAY'),
	TO_CHAR(SYSDATE, 'HH24:MI:SS') ,
	TO_CHAR(SYSDATE, 'HH12:MI:SS AM') ,
	TO_CHAR(SYSDATE, 'HH:MI:SS P.M.') 
FROM
	DUAL;

-- 자동 형변환
SELECT E.EMPNO , E.ENAME , E.EMPNO +'500' FROM EMP e WHERE E.ENAME ='SMITH';
-- SELECT E.EMPNO , E.ENAME , E.EMPNO +'ABCD' FROM EMP e WHERE E.ENAME ='SMITH'; // 안됨

-- TO_CHAR()
-- 숫자 -> 문자 // L : 지역화폐단위
SELECT E.SAL , TO_CHAR(E.SAL ,'$999,999'), TO_CHAR(E.SAL, 'L999,999')FROM EMP e; 

-- TO_NUMBER()
SELECT TO_NUMBER('1,300','999,999') -TO_NUMBER('1,500','999,999'), '1300'+ 1500 FROM DUAL;

-- TO_DATE()
SELECT TO_DATE('20251027','YYYY-MM-DD') FROM DUAL;
SELECT TO_DATE('2025-10-27') -TO_DATE('2025-09-23') FROM DUAL;


-- 5. null 처리 함수
-- (1) NVL(널에 해당하는 열, 반환할 데이터) : null인 경우만 반환할 데이터로 돌아옴
-- (2) NVL2(널에 해당하는 열, 널이 아닐 때 반환할 데이터, 반환할 데이터)
SELECT empno, ename, sal, comm, NVL(comm,0)+sal FROM EMP e ;
SELECT empno, ename, sal, comm, NVL2(comm,'O','X'), NVL2(COMM,SAL*12+COMM,sal*12) FROM EMP e ;

-- 6. DECODE, CASE 함수 : 상황에 다라 다른 데이터를 반환
-- DECODE(검사대상 데이터, [조건1],[조건1과 일치할 때 반환할 결과],
-- [조건2],[조건2와 일치할 때 반환할 결과],
-- ....
-- [위에 나열된 조건과 일치하지 않는 경우 반환할 결과])

-- CASE : 각 조건에 사용하는 데이터가 서로 상관없어도 됨
-- 		  동등(=) 외에 다양한 조건 사용 가능
-- CASE 검사 대상 데이터
-- WHEN [조건1] THEN [조건1과 일치할 때 반환할 결과]
-- WHEN [조건2] THEN [조건2와 일치할 때 반환할 결과]
-- WHEN [조건3] THEN [조건3과 일치할 때 반환할 결과]
-- ELSE [위에 나열할 조건과 일치하지 않는 경우 반환할 결과]
-- END

-- 직책이 MANAGER인 사원은 급여의 10%, SALEMAN인 사원의 급여의 5%, ANAlist인 사원은 그대로, 나머지는 3%만큼 인상된 급여;
--DECODE()
SELECT
	e.EMPNO ,
	e.EMPNO ,
	E.JOB,
	E.SAL,
	DECODE(E.JOB, 'MANAGER', E.SAL * 1.1, 'SALESMAN', E.SAL * 1.05, 'ANALIST', E.SAL, E.SAL * 1.03) AS "급여"
FROM 
	EMP e;
--CASE
SELECT
	e.EMPNO ,
	e.EMPNO ,
	E.JOB,
	E.SAL,
	CASE E.JOB WHEN 'MANAGER'THEN E.SAL * 1.1 
			   WHEN 'SALESMAN' THEN E.SAL * 1.05
			   WHEN 'ANALIST'THEN E.SAL
			   ELSE E.SAL * 1.03 
    END AS "급여"
FROM 
	EMP e;

-- COMM이 NULL인 경우에는 해당없음, 0인 경우에는 수당없음, 0보다 큰 경우 수당 : 800
SELECT
	E.EMPNO,
	E.ENAME ,
	E.COMM,
	CASE WHEN E.COMM IS NULL THEN '해당없음'
	     WHEN E.COMM = 0 THEN '수당없음'
	     WHEN E.COMM > 0 THEN '수당 : ' || E.COMM
	END AS "COMM_TEXT"
FROM
	EMP e ;


-- EMP 테이블에서 사원의 월 평균 근무일수는 21.5일이다.
-- 하루 근무시간을 8시간으로 보았을 때 하루급여(DAY_PAY)M 시급(TIME_PAY)를 계산하여 결과를 출력
-- 하루 급여는 소수 셋째 자리에서 버리고, 시급은 소수 둘째 자리에서 반올림
SELECT
	E.EMPNO,
	E.ENAME,
	E.SAL,
	TRUNC(E.SAL / 21.5, 2) AS DAY_PAY,
	ROUND(E.SAL / 21.5 / 8, 1) AS TIME_PAY
FROM
	EMP e;


-- EMP 테이블에서 사원은 입사일을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다. 사원이 정직원이 되는 날짜(R_JOB)을 
-- YYYY-MM-DD 형식으로 출력. 단 추가수당이 없는 사원의 추가 수당은 N/A로 출력
-- EMPNO, ENAME, HIREDATE, R_JOB, COMM
SELECT
	E.EMPNO ,
	E.ENAME ,
	E.HIREDATE ,
	TO_CHAR(NEXT_DAY(ADD_MONTHS(E.HIREDATE, 3), '월요일'), 'YYYY-MM-DD') AS "R_JOB" ,
	NVL(TO_CHAR(E.COMM),'N/A') AS "COMM"
FROM
	EMP e; 


-- EMP 테이블의 모든 사원을 대상으로 직속 상관의 사원번호(MGR)을 아래 조건을 기준으로 반환해서 CHG_MGR 열에 출력
-- 조건 :
-- 직속 상관의 번호가 없는 경우 0000
-- 직속 상관의 사원번호 앞 두자리가 75일 때 5555
-- 직속 상관의 사원번호 앞 두자리가 76일 때 6666
-- 직속 상관의 사원번호 앞 두자리가 77일 때 7777
-- 직속 상관의 사원번호 앞 두자리가 78일 때 8888
-- 그 외 직속상관 사원번호 일 때 : 본래 직속상관의 사원번호 그대로 출력
SELECT E.EMPNO, E.MGR,
	   CASE WHEN E.MGR IS NULL THEN '0000'
			WHEN E.MGR LIKE '75%' THEN '5555'
			WHEN E.MGR LIKE '76%' THEN '6666'
			WHEN E.MGR LIKE '77%' THEN '7777'
			WHEN E.MGR LIKE '78%' THEN '8888'
			ELSE TO_CHAR(E.MGR)
		END AS "CHG_MGR"
FROM EMP e ;


-- 7. 다중행 함수 : 단일행 함수와 같이 사용 불가
-- SUM(), AVG(), COUNT(), MAX(), MIN()
SELECT SUM(E.SAL) , ROUND(AVG(E.SAL),0), MAX(E.SAL), MIN(E.SAL), COUNT(E.SAL)  FROM EMP e ;

-- 10번 부서의 급여 총계, 평균 구하기
SELECT SUM(E.SAL), ROUND(AVG(E.SAL),0) FROM EMP e WHERE E.DEPTNO =10;

-- 2O번 부서의 제일 오래된 입사일
SELECT MIN(E.HIREDATE) FROM EMP e WHERE E.DEPTNO = 20 ;



-- 8. GROUP BY : 결과값을 원하는 열로 묶어서 출력
-- 부서별 급여평균 조회
-- 다중행 함수 옆에 올 수 있는 열은 GROUP BY 쓴 것만 가능
SELECT E.DEPTNO, AVG(E.SAL) FROM EMP e GROUP BY e.DEPTNO ORDER BY E.DEPTNO ASC; 

-- 부서별, 직무별 급여 평균 조회
SELECT E.DEPTNO, E.JOB, AVG(E.SAL) FROM EMP e GROUP BY E.DEPTNO, E.JOB ORDER BY E.DEPTNO ASC, E.JOB ASC; 

-- 부서별 추가수당의 평균 조회 (NULL은 빼고 계산하기 때문에 추가 함수가 필요함)
SELECT E.DEPTNO, AVG(NVL(E.COMM,0)) FROM EMP e GROUP BY E.DEPTNO;

-- 9. GROUP BY 열이름 HAVING 출력그룹제한 
-- 다중행함수의 조건문
-- 부서별, 직무별 급여 평균 조회(단, 평균이 2000 이상인 그룹 조회)
SELECT E.DEPTNO, E.JOB, AVG(E.SAL) FROM EMP e  GROUP BY E.DEPTNO, E.JOB HAVING AVG(E.SAL) >= 2000 ORDER BY E.DEPTNO ASC, E.JOB ASC; 

-- WHERE 절과 HAVING 절의 비교
SELECT
	E.DEPTNO,
	E.JOB,
	AVG(E.SAL)
FROM
	EMP e
WHERE 
	E.SAL <=3000
GROUP BY
	E.DEPTNO,
	E.JOB
HAVING
	AVG(E.SAL) >= 2000
ORDER BY
	E.DEPTNO ASC,
	E.JOB ASC; 

-- EMP 테이블을 이용하여 부서번호, 평균급여(AVG_SAL), 최고급여(MAX_SAL), 최저급여(MIN_SAL), 사원수(CNT) 조회
-- 단 평균급여 출력 시 소수점을 제외하고 각 부서번호 별로 출력
SELECT
	E.DEPTNO ,
	ROUND(AVG(E.SAL)) AS AVG_SAL,
	MAX(E.SAL) AS MAX_SAL,
	MIN(E.SAL) AS_MIN_SAL,
	COUNT(*) AS CNT
FROM
	EMP e
GROUP BY
	e.DEPTNO
ORDER BY
	E.DEPTNO ASC;

-- 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원수 출력
SELECT
	E.JOB,
	COUNT(*) AS CNT
FROM
	EMP e
GROUP BY
	E.JOB
HAVING
	COUNT(*)>= 3 ;
-- 사원들의 입사연도를 기준으로 부서별로 몇 명이 입사했는지 출력 (TO_CHAR(1981-09-28,'YYYY') 이용)
SELECT
	TO_CHAR(E.HIREDATE, 'YYYY') AS 입사년도,
	E.DEPTNO AS 부서번호 ,
	COUNT(*) AS CNT
FROM
	EMP e
GROUP BY
	TO_CHAR(E.HIREDATE, 'YYYY'),
	E.DEPTNO
ORDER BY
	TO_CHAR(E.HIREDATE, 'YYYY'),
	E.DEPTNO;


-- 조회 : JOIN / SUBQUERY
-- 10. JOIN : 여러 테이블을 하나의 테이블처럼 사용
-- (1) 내부조인(INNER JOIN)
-- (2) 외부조인
-- 		(1) LEFT OUTER JOIN
--		(2) RIGHT OUTER JOIN
-- 		(3) FULL OUTER JOIN : LEFT JOIN UNION RIGHT JOIN


-- 사원정보 + 부서정보 조회 (EMP, DEPT)
-- 내부조인 + 등가조인
SELECT
	e.EMPNO,
	e.ENAME ,
	e.JOB,
	e.DEPTNO,
	d.DNAME
FROM
	EMP e
INNER JOIN DEPT d ON
	e.DEPTNO = d.DEPTNO ;

SELECT
	e.EMPNO,
	e.ENAME ,
	e.JOB,
	e.DEPTNO,
	d.DNAME
FROM
	EMP e, DEPT d 
WHERE E.DEPTNO = D.DEPTNO;


-- 사원정보 + 급여등급 (EMP, SALGRADE)
-- 내부조인 + 비등가조인
SELECT * FROM EMP e JOIN SALGRADE s ON  E.SAL BETWEEN S.LOSAL AND S.HISAL;  

-- EMP의 MGR을 보고 MANAGER의 이름을 알아내기
-- 셀프조인 (EMP, EMP)
SELECT
	E1.EMPNO,
	E1.ENAME,
	E1.MGR,
	E2.ENAME AS MANAGER
FROM
	EMP e1
JOIN EMP e2 ON
	E1.MGR = E2.EMPNO ;  

-- 외부조인
-- LEFT조인
SELECT
	E1.EMPNO,
	E1.ENAME,
	E1.MGR,
	E2.ENAME AS MANAGER
FROM
	EMP e1
LEFT JOIN EMP e2 ON
	E1.MGR = E2.EMPNO ;  

-- RIGHT조인
SELECT
	E1.EMPNO,
	E1.ENAME,
	E1.MGR,
	E2.ENAME AS MANAGER
FROM
	EMP e1
RIGHT JOIN EMP e2 ON
	E1.MGR = E2.EMPNO ;  

-- 부서번호 및 부서명까지 출력
SELECT
	E.DEPTNO ,
	D.DNAME ,
	ROUND(AVG(E.SAL)) AS AVG_SAL,
	MAX(E.SAL) AS MAX_SAL,
	MIN(E.SAL) AS_MIN_SAL,
	COUNT(*) AS CNT
FROM
	EMP e
JOIN DEPT d ON
	E.DEPTNO = D.DEPTNO
GROUP BY
	e.DEPTNO, d.DNAME
ORDER BY
	E.DEPTNO ASC;

-- TABLE 3개 연동
-- 부서번호, 부서명, 사원번호, 사원명, 매니저번호, 급여, 급여등급
SELECT
	E.DEPTNO ,
	D.DNAME ,
	E.EMPNO ,
	E.ENAME ,
	E.MGR ,
	E.SAL ,
	S.GRADE
FROM
	EMP e
JOIN DEPT d ON
	e.DEPTNO = D.DEPTNO
JOIN SALGRADE s ON
	E.SAL BETWEEN S.LOSAL AND S.HISAL ;

-- 서브쿼리 : 메인쿼리 외에 SELECT 구문이 여러개 존재
-- SELECT 구문 안에 또 다른 SELECT 문 존재 , 반드시 ()로 묶어줘야 함.
-- (1) 단일행 서브쿼리 : 서브쿼리 실행 결과(괄호 안에 있는 것만 실행했을 때)가 행 하나
--			ㄴ 연산자 종류 : >, <, >=, <=, <>, !=, ^=, =
-- (2) 다중행 서브쿼리 : 서브쿼리 실행 결과가 여러 행
			ㄴ 연산자 종류 : IN, ANY(SOME), ALL, EXISTS
			IN : 서브쿼리 결과 중 하나라도 일치한 데이터가 있다면 TRUE 반환
			ANY, SOME : 서브 쿼리 결과가 하나 이상이면 TRUE 반환
			ALL : 모두 반족하면 TRUE 반환
			EXISTS : 서브쿼리 결과가 있으면 TRUE 반환
			
			
-- (1) 단일행 서브쿼리
-- JONES의 급여보다 높은 급여를 받는 사원 데이터 조회
SELECT
	*
FROM
	EMP e
WHERE
	E.SAL> (
	SELECT
		E2.SAL
	FROM
		EMP e2
	WHERE
		E2.ENAME = 'JONES');

-- WARD 사원보다 빨리 입사한 사원 조회
SELECT * FROM EMP e WHERE E.HIREDATE <(SELECT E2.HIREDATE FROM EMP e2 WHERE E2.ENAME ='WARD')

-- 2O번 부서에 속한 사원 중 전체 사원의 평균급여보다 높은 급여를 받는 사원 조회
-- 부서정보 추가 조회
SELECT
	E.EMPNO,
	E.ENAME ,
	E.JOB ,
	D.DNAME ,
	D.LOC
FROM
	EMP e
JOIN DEPT d ON
	E.DEPTNO = D.DEPTNO
WHERE E.DEPTNO =20
	AND E.SAL > (SELECT AVG(E2.SAL) FROM EMP e2 ) ;

-- (2) 다중행 서브쿼리
SELECT * FROM EMP e WHERE E.SAL IN (SELECT MAX(E2.SAL )FROM EMP e2 GROUP BY E2.DEPTNO);
-- =ANY(=SOME) => IN 사용과 동일
SELECT * FROM EMP e WHERE E.SAL = ANY (SELECT MAX(E2.SAL )FROM EMP e2 GROUP BY E2.DEPTNO);
SELECT * FROM EMP e WHERE E.SAL = SOME (SELECT MAX(E2.SAL )FROM EMP e2 GROUP BY E2.DEPTNO);

-- 30번 부서의 '최대' 급여보다 적은 급여를 받는 사원조회
-- < ANY
SELECT * FROM EMP e WHERE E.SAL < ANY (SELECT E2.SAL FROM EMP E2  WHERE E2.DEPTNO = 30);

-- 30번 부서의 '최소' 급여보다 많은 급여를 받는 사원조회
-- > ANY
SELECT * FROM EMP e WHERE E.SAL > ANY (SELECT E2.SAL FROM EMP E2  WHERE E2.DEPTNO = 30);

-- 30번 부서의 '최소' 급여보다 적은 급여를 받는 사원조회
-- < ALL 
SELECT * FROM EMP e WHERE E.SAL < ALL (SELECT E2.SAL FROM EMP E2  WHERE E2.DEPTNO = 30);

-- 30번 부서의 '최대' 급여보다 많은 급여를 받는 사원조회
-- > ALL 
SELECT * FROM EMP e WHERE E.SAL > ALL (SELECT E2.SAL FROM EMP E2  WHERE E2.DEPTNO = 30);

-- 서브쿼리 결과가 하나 이상만 나오면 TRUE
-- EXIST
SELECT * FROM EMP e WHERE EXISTS (SELECT DNAME FROM DEPT d WHERE D.DEPTNO =30);


-- 다중열 서브쿼리
SELECT * FROM EMP e WHERE (E.DEPTNO ,E.SAL) IN (SELECT E2.DEPTNO , MAX(E2.SAL)FROM EMP e2 GROUP BY E2.DEPTNO );
-- FROM 절 서브쿼리 (=인라인 뷰)
SELECT E10.*, D.* FROM (SELECT * FROM EMP e WHERE E.DEPTNO =10) E10, (SELECT * FROM DEPT) d 
WHERE E10.DEPTNO =D.DEPTNO;
-- SELECT 절 서브쿼리 (= 스칼라 서브쿼리)
SELECT
	E.EMPNO ,
	E.ENAME ,
	E.JOB ,
	(SELECT S.GRADE FROM SALGRADE s WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL) AS SALGRADE,
	E.DEPTNO,
	(SELECT	D.DNAME FROM DEPT d	WHERE E.DEPTNO = D.DEPTNO) AS DNAME
FROM
	EMP e ;

-- 전체 사원 중 ALLEN과 같은 직책의 사원들의 사원정보(사번, 이름, 직무, 급여, 부서번호, 부서명)조회
SELECT E.EMPNO , E.ENAME, E.SAL , E.DEPTNO , D.DNAME   
FROM EMP e JOIN DEPT d  ON E.DEPTNO =D.DEPTNO   
WHERE E.JOB IN (SELECT E2.JOB FROM EMP e2 WHERE E2.ENAME='ALLEN'); 

-- 자신의 부서 내에서 최고 연봉과 동일한 급여를 받는 사원 조회
SELECT * 
FROM EMP e 
WHERE (E.DEPTNO ,E.SAL)  IN (SELECT E2.DEPTNO, MAX(E2.SAL) FROM EMP e2 GROUP BY e2.DEPTNO );
-- 10번 부서에 근무하는 사원 중 30번 부서에 없는 직책의 사원의 사번, 이름, 직무, 부서번호, 부서명, 부서위치 조회
SELECT E.EMPNO ,E.ENAME ,E.JOB ,E.DEPTNO ,D.DNAME ,D.LOC 
FROM EMP e JOIN DEPT d ON E.DEPTNO =D.DEPTNO 
WHERE E.DEPTNO =10 AND E.JOB NOT IN (SELECT E2.JOB FROM EMP e2 WHERE E2.DEPTNO =30);


---------------------------- 입력(insert) ----------------------------------
-- insert : 테이블에 데이터 추가

-- 연습용 테이블 생성
CREATE TABLE DEPT_TEMP EMP AS SELECT * FROM dept;  -- 구조 + 데이터
CREATE TABLE EMP_TEMP AS SELECT * FROM EMP WHERE 1<>1; -- 구조만 복사



SELECT * FROM DEPT_TEMP ORDER BY DEPTNO ASC;

--INSERT INTO 테이블명(열이름1, 열이름2, ...) VALUES (값1, 값2, ...)
-- 50번, DATABASE, SEOUL 데이터 추가
INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC) VALUES (50,'DATABASE','SEOUL');
-- 열이름 생략가능  단, 모든 열의 값이 지정되어야 함.
INSERT INTO DEPT_TEMP VALUES (60,'NETWORK','BUSAN');
-- 데이터의 값으로 NULL을 넣고 싶을 경우 명시적 선언, 공백, 암시적 처리 가능
INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC) VALUES (70,'WEB',NULL);
INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC) VALUES (80,'MOBILE','');
INSERT INTO DEPT_TEMP(DEPTNO, DNAME) VALUES (90,'OS');



SELECT * FROM EMP_TEMP ;

INSERT INTO EMP_TEMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) 
VALUES(1111,'성춘향','MANAGER',9999,'2010-10-25',4000,NULL,20);

INSERT INTO EMP_TEMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) 
VALUES(9999,'홍길동','PRESIDENT',NULL,'2000-01-25',8000,1000,10);

INSERT INTO EMP_TEMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) 
VALUES(2222,'김수호','MANAGER',9999,SYSDATE,4000,NULL,30);

-- 다른 테이블에서 값을 가져올 수 있음
-- EMP 테이블에서 S.GRADE가 1인 사원만 EMP_TEMP로 삽입 // VALUES 안씀 
INSERT INTO EMP_TEMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
SELECT E.EMPNO , E.ENAME, E.JOB , E.MGR , E.HIREDATE , E.SAL , E.COMM , E.DEPTNO 
FROM EMP e JOIN SALGRADE s ON E.SAL BETWEEN S.LOSAL AND S.HISAL AND S.GRADE = 1; 


---------------------------- 수정(update) ----------------------------------
-- UPDATE 테이블명 SET 열이름 = 값, 열이름2 = 값 WHERE 수정할 조건

SELECT * FROM DEPT_TEMP dt ORDER BY DT.DEPTNO ASC;
SELECT * FROM EMP_TEMP et ;

-- 10번 부서의 LOC를 NEW YORK -> SEOUL
UPDATE DEPT_TEMP dt SET DT.LOC = 'SEOUL' WHERE dt.DEPTNO =10;

-- EMP_TEMP 테이블의 사원 중에서 SAL이 2500이하인 사원만 추가수당 50으로 수정
UPDATE EMP_TEMP et SET et.COMM = 50 WHERE ET.SAL<=2500;

-- DEPT 테이블의 40번 부서의 DNAME, LOC 정보를 가져와서 DEPT_TEMP 40번 부서의 내용으로 변경
UPDATE DEPT_TEMP dt SET (DT.DNAME, DT.LOC) = (SELECT D.DNAME , D.LOC FROM DEPT d WHERE D.DEPTNO =40 ) WHERE DT.DEPTNO =40;



---------------------------- 삭제(delete) ----------------------------------
--DELETE (FROM) 테이블명 WHERE

CREATE TABLE EMP_TEMP2 AS SELECT * FROM EMP;

SELECT * FROM EMP_TEMP2 et ;

-- FROM 생략 가능
-- 7902 사원 삭제
DELETE EMP_TEMP2 WHERE EMPNO=7902;
-- 7844 사원 삭제
DELETE FROM EMP_TEMP2 WHERE EMPNO=7844;



-- EMP 테이블을 복사하여 EXAM_EMP 테이블 생성
CREATE TABLE EXAM_EMP AS SELECT * FROM EMP;
-- DEPT 테이블을 복사하여 EXAM_DEPT 테이블 생성
CREATE TABLE EXAM_DEPT AS SELECT * FROM DEPT;
-- SALGRADE 테이블을 복사하여 EXAM_SALGRADE 테이블 생성
CREATE TABLE EXAM_SALGRADE AS SELECT * FROM SALGRADE;
-- EXAM_DEPT 테이블에 50,60,70,80번 부서를 등록하는 SQL구문 작성
-- 50, ORACLE, BUSAN
-- 60, SQL, ILSAN
-- 70, SELECT, INCHEON
-- 80, DML, BUNDANG
INSERT INTO EXAM_DEPT VALUES (50,'ORACLE','BUSAN');
INSERT INTO EXAM_DEPT VALUES (60,'SQL','ILSAN');
INSERT INTO EXAM_DEPT VALUES (70,'SELECT','INCHEON');
INSERT INTO EXAM_DEPT VALUES (80,'DML','BUNDANG');
-- EXAM_EMP 테이블에 8명의 사원정보를 등록하는 SQL 구문 작성
-- 8명은 임의의 값(부서번호는 50~80 사이로 지정)
INSERT INTO EXAM_EMP VALUES (8001,'A','MANAGER',7839,'2025-10-05',2000,NULL,50);
INSERT INTO EXAM_EMP VALUES (8002,'B','MANAGER',7839,'2025-10-05',2500,NULL,50);
INSERT INTO EXAM_EMP VALUES (8003,'C','MANAGER',7839,'2025-10-10',2000,NULL,60);
INSERT INTO EXAM_EMP VALUES (8004,'D','MANAGER',7839,'2025-10-20',2000,NULL,60);
INSERT INTO EXAM_EMP VALUES (8005,'E','MANAGER',7839,'2025-10-21',2500,NULL,60);
INSERT INTO EXAM_EMP VALUES (8006,'F','MANAGER',7839,'2025-10-21',2500,NULL,60);
INSERT INTO EXAM_EMP VALUES (8007,'G','MANAGER',7839,'2025-10-21',2500,NULL,60);
INSERT INTO EXAM_EMP VALUES (8008,'H','MANAGER',7839,'2025-10-21',2900,NULL,60);
-- EXAM_EMP에서 50번 부서에 근무하는 사원의 평균 급여보다 많이 받는 사원을 70번 부서로 옮기는 SQL 구문 작성
UPDATE EXAM_EMP ee SET EE.DEPTNO = 70 WHERE EE.SAL > (SELECT AVG(EE2.SAL) FROM EXAM_EMP ee2 WHERE EE2.DEPTNO =50); 
-- EXAM_EMP에 속한 사원 중 입사일이 가장 빠른 60번 부서 사원보다 늦게 입사한 사원의 급여를 10% 인상하고 80번 부서로 옮기는 SQL구문 작성
UPDATE EXAM_EMP ee SET EE.SAL= 1.1*EE.SAL, EE.DEPTNO = 80 WHERE EE.HIREDATE > (SELECT MIN(EE2.HIREDATE) FROM EXAM_EMP ee2 WHERE EE.DEPTNO =60 );
-- EXAM_EMP에 속한 사원 중 급여 등급이 5인 사원을 삭제하는 SQL 구문 작성
DELETE EXAM_EMP WHERE EMPNO IN (SELECT EE.EMPNO  FROM EXAM_EMP ee JOIN SALGRADE s ON EE.SAL BETWEEN S.LOSAL AND S.HISAL AND S.GRADE =5);


------ DML : INSERT, UPDATE, DELETE => 데이터 변경이 일어나는 작업
-- 트랜잭션 : 하나의 단위로 데이터 처리
-- ROLLBACK; 되돌리기
-- COMMIT; 데이터베이스 반영 // DBeaver 기본설정 : AUTO COMMIT

CREATE TABLE DEPT_TCL AS SELECT * FROM DEPT;
SELECT * FROM DEPT_TCL;


INSERT INTO DEPT_TCL VALUES (50,'DATABASE','SEOUL');
UPDATE DEPT_TCL SET LOC='BUSAN' WHERE DEPTNO=40;
DELETE FROM DEPT_TCL WHERE DNAME='RESEARCH';
SELECT * FROM DEPT_TCL;
ROLLBACK; -- 롤백

COMMIT; -- 반영 후에는 롤백 불가능함

-- 세션 : 데이터베이스 접속을 시작으로 작업을 수행한 후 접속을 종료하기까지 전체 기간을 의미
SELECT * FROM DEPT_TCL;

DELETE FROM DEPT_TCL WHERE DEPTNO=50;

COMMIT;

UPDATE DEPT_TCL SET LOC='SEOUL' WHERE DEPTNO=30;

SELECT * FROM DEPT_TCL; -- 트랜잭션 종료 시까지 다른 세션에서의 데이터 조작이 불가능함

COMMIT;


---------------------------- 데이터 정의어(DDL) ----------------------------------
-- 객체를 생성(CREATE), 변경(ALTER), 삭제(DROP)하는 명령어
-------- 테이블 --------
-- (1) 테이블 생성 :CREATE

-- 타입
-- 	문자 : CHAR / NCHAR /VARCHAR2 / NVARCHAR2
--			ㄴ 고정크기      ㄴ 가변크기
-- 		  CHAR(10) : abc => 10자리를 그대로 사용
--		  VARCHAR2(10) : abc => 3자리를 사용
-- 		  VARCHAR2(10) : 안녕하세요 => 입력불가 (10 BYTE까지 가능)
-- 	      NVARCHAR2(10) : 안녕하세요 => 입력가능 (10글자까지 가능)
--	숫자 : NUMBER(7,2) : 소수 둘째짜리 포함 7자리 숫자 지정 가능
--	날짜 : DATE

-- 테이블명 : '문자'로 시작, 특수문자(_, $, #), 숫자 가능 / 예약어(select, order, from)는 사용 불가능
-- 열이름 : '문자'로 시작, 특수문자(_, $, #), 숫자 가능 / 예약어(select, order, from)는 사용 불가능

-- 1. 기존 테이블 구조 이용
CREATE TABLE DEPT_TCL AS SELECT * FROM DEPT;
CREATE TABLE DEPT_TCL AS SELECT * FROM WHERE 1<>1;
-- 2. 자료형을 정의하여 새 테이블 생성
CREATE TABLE EMP_DDL(
EMPNO NUMBER(4), 
ENAME VARCHAR2(10),
JOB VARCHAR2(9), 
MGR NUMBER(4), 
HIREDATE DATE, 
SAL NUMBER(7, 2), 
COMM NUMBER(7, 2),
DEPTNO NUMBER(2)
);

-- (2) 테이블 변경 : ALTER
-- 1. 열 추가 : ADD
-- 2. 열 이름 변경 : RENAME COLUMN
-- 3. 열 자료형 변경 : MODIFY
-- 4. 열 삭제 :DROP COLUMN
-- 테이블 이름 변경 : RENAME 테이블명 TO 변경할 테이블명

-- HP 열 추가
ALTER TABLE EMP_DDL ADD HP VARCHAR2(20);
SELECT * FROM EMP_DDL ed ;

-- HP => TEL 열 이름 변경
ALTER TABLE EMP_DDL RENAME COLUMN HP TO TEL;
SELECT * FROM EMP_DDL ed ;

-- EMPNO(4) => EMPNO(5) 변경
ALTER TABLE EMP_DDL MODIFY EMPNO NUMBER(5);

-- TEL COLUMN 제거
ALTER TABLE EMP_DDL DROP COLUMN TEL;
SELECT * FROM EMP_DDL ed ;

-- EMP_DDL => EMP_RENAME 테이블 이름 변경
RENAME EMP_DDL TO EMP_RENAME;
SELECT * FROM EMP_RENAME ed ;

-- (3) 테이블 삭제 : DROP
DROP TABLE EMP_RENAME;



-- MEMBER 테이블 생성
-- ID 가변문자열(15)
-- PASSWORD 가변문자열(20)
-- NAME 가변문자열(10)
-- TEL 가변문자열(15)
-- EMAIL 가변문자열(20)
-- AGE 숫자(4)
CREATE TABLE MEMBER(ID VARCHAR2(15), PASSWORD VARCHAR2(20), NAME VARCHAR2(10), TEL VARCHAR2(15), EMAIL VARCHAR2(20), AGE NUMBER(4)); 

-- BIGO 열 추가 : 가변 문자열 (10)
ALTER TABLE MEMBER ADD BIGO VARCHAR2(10);
-- BIGO 열 크기 변경 : (30)
ALTER TABLE MEMBER MODIFY BIGO VARCHAR2(30);
-- BIGO 열 이름을 REMARK로 변경
ALTER TABLE MEMBER RENAME COLUMN BIGO TO REMARK;

SELECT * FROM MEMBER;


-------- 인덱스 --------
-- 인덱스 : 테이블 검색 성능 향상
-- 인덱스 사용 여부
-- (1) 테이블 풀 스캔 : 처음부터 끝까지 검색
-- (2) 인덱스 스캔 : 인덱스 사용한 검색
SELECT * FROM EMP WHERE EMPNO=7844 ;

-- 인덱스 생성
CREATE INDEX IDX_EMP_SAL ON EMP(SAL);
-- 인덱스 삭제
DROP INDEX IDX_EMP_SAL;

-------- 뷰 --------
-- 뷰 : 가상 테이블
-- 	   하나 이상의 테이블을 조회하는 SELECT문을 저장한 객체
-- 1. 보안성
-- 2. 편의성 : SQL 구문을 단순화

-- CREATE VIEW 뷰이름(열이름, 열이름2, ...) AS 저장할 SELECT문 WITH CHECK OPTION 제약조건 WITH READ ONLY 제약조건
CREATE VIEW VIEW_EMP20 AS SELECT EMPNO, ENAME, JOB, DEPTNO FROM EMP WHERE DEPTNO = 20;
CREATE VIEW VIEW_EMP_READ AS SELECT EMPNO, ENAME, JOB, DEPTNO FROM EMP WITH READ ONLY;

INSERT INTO VIEW_EMP20 VALUES(7777,'홍길동','SALESMAN',10); -- VIEW에 작업을 해도 원본에 반영됨
SELECT * FROM VIEW_EMP20; 
SELECT * FROM EMP;  -- 정보가 업데이트 됨

-- USER_ : 현재 데이터베이스에 접속한 사용자가 소유한 객체 정보
SELECT * FROM USER_TABLES;
SELECT * FROM USER_UPDATABLE_COLUMNS WHERE TABLE_NAME='VIEW_EMP20';

SELECT * FROM VIEW_EMP_READ;
INSERT INTO VIEW_EMP_READ VALUES(7777,'홍길동','SALESMAN',10); -- 읽기전용에서는 작업 불가능

-- DROP VIEW 뷰 이름

DROP VIEW VIEW_EMP20 ;
DROP VIEW VIEW_EMP_READ;

-------- 시퀀스 --------
-- 시퀀스 (MYSQL limit)
-- Oracle DB에서 특정 규칙에 따른 연속 숫자를 생성하는 객체
-- CREATE  SEQUENCE 시퀀스명;
-- INCREMENT BY N (기본값 : 1)
-- START WITH N (기본값 : 1)
-- MAXVALUE N | NOMAXVALUE
-- MINVALUE N | NOMINVALUE
-- CYCLE | NOCYCLE
-- CACHE N : NOCACHE

CREATE SEQUENCE SEQ_DEPT_SEQUENCE
INCREMENT BY 10
START WITH 10
MAXVALUE 90
MINVALUE 0
NOCYCLE
CACHE 2;

ALTER SEQUENCE SEQ_DEPT_SEQUENCE
INCREMENT BY 3
MAXVALUE 99
CYCLE;

CREATE TABLE DEPT_SEQUENCE AS SELECT * FROM DEPT WHERE 1<>1;

INSERT INTO DEPT_SEQUENCE VALUES (SEQ_DEPT_SEQUENCE.NEXTVAL, 'DATABASE', 'SEOUL');
INSERT INTO DEPT_SEQUENCE VALUES (SEQ_DEPT_SEQUENCE.NEXTVAL, 'NETWORK', 'BUSAN');

-- SEQUENCE.NEXTVAL : 다음 시퀀스
-- SEQUENCE.CURRVAL : 현재 시퀀스
SELECT SEQ_DEPT_SEQUENCE.CURRVAL FROM DUAL;
SELECT * FROM DEPT_SEQUENCE ORDER BY DEPTNO ASC;

-------- 동의어 --------
-- 동의어 : SYNONYM (별칭)
-- 테이블, 뷰, 시퀀스 등 객체 이름 대신 사용할 수 있는 다른 이름 부여

CREATE SYNONYM E FOR EMP;

SELECT * FROM E;


------------ 제약조건 ----------------
-- 1. 빈 값을 허용하지 않는 NOT NULL
-- 2. 중복값을 허용하지 않는 UNIQUE
-- 3. 유일하게 하나만 존재하는 PRIMARY KEY
-- 4. 다른 테이블과 관계를 맺는 FOREIGN KEY
-- 5. 설정한 조건식을 만족하는 데이터 확인 CHECK
-- 6. 기본값을 지정하는 DEFAULT


-- 데이터 무결성 : 정확성과 일관성 보장
-- 1. NOT NULL
-- 테이블 생성 시
CREATE TABLE TABLE_NOTNULL(LOGIN_ID VARCHAR2(20) NOT NULL, LOGIN_PASSWORD VARCHAR2(20) NOT NULL, TEL VARCHAR2(20));

INSERT INTO TABLE_NOTNULL VALUES('test01','test01','010-1234-5678');
-- NULL을 ("SCOTT"."TABLE_NOTNULL"."LOGIN_PASSWORD") 안에 삽입할 수 없습니다
INSERT INTO TABLE_NOTNULL VALUES('test01',NULL,'010-1234-5678');
-- NOT NULL이 아닌 데이터는 NULL로 생성 가능
INSERT INTO TABLE_NOTNULL VALUES('test02','test02',NULL);

-- NULL로 ("SCOTT"."TABLE_NOTNULL"."LOGIN_PASSWORD")을 업데이트할 수 없습니다
UPDATE TABLE_NOTNULL SET LOGIN_PASSWORD = NULL WHERE LOGIN_ID= 'test01';
-- NOT NULL이 아닌 데이터는 NULL로 업데이트 가능
UPDATE TABLE_NOTNULL SET TEL = '010-4321-8765' WHERE LOGIN_ID= 'test02';
UPDATE TABLE_NOTNULL SET TEL = NULL WHERE LOGIN_ID= 'test02';

SELECT * FROM TABLE_NOTNULL;

DROP TABLE TABLE_NOTNULL;

-- 제약조건 이름 지정
CREATE TABLE TABLE_NOTNULL(LOGIN_ID VARCHAR2(20) CONSTRAINT TBLNN_LGNID_NN NOT NULL, LOGIN_PASSWORD VARCHAR2(20) CONSTRAINT TBLNN_LGNPWD_NN NOT NULL, TEL VARCHAR2(20));
-- 제약조건 추가 및 이름 지정 // MODIFY
ALTER TABLE TABLE_NOTNULL MODIFY (TEL CONSTRAINT TBLNN_TEL_NN NOT NULL);
-- 제약조건 이름 변경 // RENAME
ALTER TABLE TABLE_NOTNULL RENAME CONSTRAINT TBLNN_TEL_NN TO TBLNN_TELEPHONE_NN;
-- 제약조건 삭제 // DROP
ALTER TABLE TABLE_NOTNULL DROP CONSTRAINT TBLNN_TELEPHONE_NN ; 



-- 2. UNIQUE 
CREATE TABLE TABLE_UNIQUE(LOGIN_ID VARCHAR2(20) UNIQUE, LOGIN_PASSWORD VARCHAR2(20) NOT NULL, TEL VARCHAR2(20));

INSERT INTO TABLE_UNIQUE VALUES('test01','test01','010-1234-5678');
-- 무결성 제약 조건(SCOTT.SYS_C008361)에 위배됩니다
INSERT INTO TABLE_UNIQUE VALUES('test01','test02','010-4321-8765');
-- NULL 값은 중복의 의미를 부여하지 않는다.
INSERT INTO TABLE_UNIQUE VALUES(NULL,'test02','010-4321-8765');

INSERT INTO TABLE_UNIQUE VALUES('test02','test02','010-4321-8765');
-- 무결성 제약 조건(SCOTT.SYS_C008361)에 위배됩니다
UPDATE TABLE_UNIQUE SET LOGIN_ID ='test01';

DROP TABLE TABLE_UNIQUE;

-- UNIQUE 제약조건 이름 지정
CREATE TABLE TABLE_UNIQUE(LOGIN_ID VARCHAR2(20) CONSTRAINT LGN_UNIQ UNIQUE, LOGIN_PASSWORD VARCHAR2(20) NOT NULL, TEL VARCHAR2(20));
-- TEL에 UNIQUE 제약조건 추가
ALTER TABLE TABLE_UNIQUE MODIFY (TEL CONSTRAINT TEL_UNIQ UNIQUE);

-- 3. PRIMARY KEY(기본키)
-- UNIQUE + NOT NULL
CREATE TABLE TABLE_PK(LOGIN_ID VARCHAR2(20) PRIMARY KEY, LOGIN_PASSWORD VARCHAR2(20) NOT NULL, TEL VARCHAR2(20));

INSERT INTO TABLE_PK VALUES('test01','test01','010-1234-5678');
-- 무결성 제약 조건(SCOTT.SYS_C008369)에 위배됩니다
INSERT INTO TABLE_PK VALUES('test01','test01','010-1234-5678');
-- NULL을 ("SCOTT"."TABLE_PK"."LOGIN_ID") 안에 삽입할 수 없습니다
INSERT INTO TABLE_PK VALUES(null,'test01','010-1234-5678');

-- * 검색, 조건부여 시 PK를 이용하면 유용함 * PRIMARY KEY => INDEX 역할


-- 4. FOREIGN KEY(외래키)
-- 다른 테이블과 관계를 맺을 때
CREATE TABLE DEPT_FK (
DEPTNO NUMBER(2) PRIMARY KEY,
DNAME VARCHAR2(14),
LOC VARCHAR2(13));

CREATE TABLE EMP_FK(
EMPNO NUMBER(4), 
ENAME VARCHAR2(10),
JOB VARCHAR2(9), 
MGR NUMBER(4), 
HIREDATE DATE, 
SAL NUMBER(7, 2), 
COMM NUMBER(7, 2),
DEPTNO NUMBER(2) REFERENCES DEPT_FK(DEPTNO)
);

-- 무결성 제약조건(SCOTT.SYS_C008371)이 위배되었습니다- 부모 키가 없습니다
INSERT INTO EMP_FK VALUES (7201,'TEST_USER1','MANAGER',7788,'2016-01-02',4500,NULL,10);
-- 입력시 부모 테이블 데이터 먼저 입력 후 자식 테이블 데이터 입력
INSERT INTO DEPT_FK VALUES (10, 'DATABASE','SEOUL');
INSERT INTO EMP_FK VALUES (7201,'TEST_USER1','MANAGER',7788,'2016-01-02',4500,NULL,10);

-- 무결성 제약조건(SCOTT.SYS_C008371)이 위배되었습니다- 부모 키가 없습니다
UPDATE EMP_FK SET DEPTNO=20 WHERE EMPNO=7201;

-- 무결성 제약조건(SCOTT.SYS_C008371)이 위배되었습니다- 자식 레코드가 발견되었습니다
DELETE FROM DEPT_FK WHERE DEPTNO =10;
-- (1) 자식 레코드먼저 삭제 후 (2) 부모 레코드 삭제가 가능
DELETE FROM EMP_FK WHERE DEPTNO =10;
DELETE FROM DEPT_FK WHERE DEPTNO =10;

DROP TABLE EMP_FK;
DROP TABLE DEPT_FK;

-- 제약조건명 + 부모 데이터 삭제 시 자식 데이터 처리 방법 지정
-- 1. ON DELETE CASCADE : 부모 데이터 삭제 시 참조하는 데이터도 함께 삭제
-- 2. ON DELETE SET NULL : 부모 데이터 삭제 시 참조하는 데이터를 NULL로 설정
-- ON DELETE CASCADE
CREATE TABLE DEPT_FK (
DEPTNO NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_PK PRIMARY KEY,
DNAME VARCHAR2(14),
LOC VARCHAR2(13));

CREATE TABLE EMP_FK(
EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY, 
ENAME VARCHAR2(10),
JOB VARCHAR2(9), 
MGR NUMBER(4), 
HIREDATE DATE, 
SAL NUMBER(7, 2), 
COMM NUMBER(7, 2),
DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_PK REFERENCES DEPT_FK(DEPTNO) ON DELETE CASCADE
);

INSERT INTO DEPT_FK VALUES (10, 'DATABASE','SEOUL');
INSERT INTO EMP_FK VALUES (7201,'TEST_USER1','MANAGER',7788,'2016-01-02',4500,NULL,10);

-- DEPT_FK의 데이터 뿐만 아니라 그를 참조하고 있던 EMP_FK의 데이터도 지워짐
DELETE FROM DEPT_FK WHERE DEPTNO =10; 

DROP TABLE EMP_FK;
DROP TABLE DEPT_FK;


-- ON DELETE SET NULL
CREATE TABLE DEPT_FK (
DEPTNO NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_PK PRIMARY KEY,
DNAME VARCHAR2(14),
LOC VARCHAR2(13));

CREATE TABLE EMP_FK(
EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY, 
ENAME VARCHAR2(10),
JOB VARCHAR2(9), 
MGR NUMBER(4), 
HIREDATE DATE, 
SAL NUMBER(7, 2), 
COMM NUMBER(7, 2),
DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_PK REFERENCES DEPT_FK(DEPTNO) ON DELETE SET NULL
);

INSERT INTO DEPT_FK VALUES (10, 'DATABASE','SEOUL');
INSERT INTO EMP_FK VALUES (7201,'TEST_USER1','MANAGER',7788,'2016-01-02',4500,NULL,10);

-- EMP_FK의 DEPTNO가 NULL 값으로 변함
DELETE FROM DEPT_FK WHERE DEPTNO =10; 

--------------- 외래키 제약조건을 따로 지정
DROP TABLE EMP_FK;
DROP TABLE DEPT_FK;

CREATE TABLE DEPT_FK (
DEPTNO NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_PK PRIMARY KEY,
DNAME VARCHAR2(14),
LOC VARCHAR2(13));

CREATE TABLE EMP_FK(
EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY, 
ENAME VARCHAR2(10),
JOB VARCHAR2(9), 
MGR NUMBER(4), 
HIREDATE DATE, 
SAL NUMBER(7, 2), 
COMM NUMBER(7, 2),
DEPTNO NUMBER(2)
);

ALTER TABLE EMP_FK ADD FOREIGN KEY (DEPTNO) REFERENCES DEPT_FK (DEPTNO); 
-- 5. CHECK
CREATE TABLE TABLE_CHECK(
	LOGIN_ID VARCHAR2(20) NOT NULL,
	LOGIN_PASSWORD VARCHAR2(20) CONSTRAINT TBLCK_LOGINPW_CK CHECK (LENGTH(LOGIN_PASSWORD)>3),
	TEL VARCHAR2(20)
);

-- 체크 제약조건(SCOTT.TBLCK_LOGINPW_CK)이 위배되었습니다
INSERT INTO TABLE_CHECK VALUES('test01', 'tes','010-1234-5678');

DROP TABLE TABLE_CHECK;

CREATE TABLE TABLE_CHECK(
	LOGIN_ID VARCHAR2(20) NOT NULL,
	LOGIN_PASSWORD VARCHAR2(20) CONSTRAINT TBLCK_LOGINPW_CK CHECK (LENGTH(LOGIN_PASSWORD)>3),
	AGE NUMBER(3) CONSTRAINT TBLCK_AGE_CK CHECK (AGE BETWEEN 10 AND 18),
	TEL VARCHAR2(20)
);
INSERT INTO TABLE_CHECK VALUES('test01', 'test01',8,'010-1234-5678');
INSERT INTO TABLE_CHECK VALUES('test01', 'test01',12,'010-1234-5678');

-- 6. DEFAULT
-- 값을 지정하지 않은 특정한 열에 기본값 지정

CREATE TABLE TABLE_DEFAULT(
	LOGIN_ID VARCHAR2(20) NOT NULL,
	LOGIN_PASSWORD VARCHAR2(20) DEFAULT '1234',
	TEL VARCHAR2(20)
);

INSERT INTO TABLE_DEFAULT(LOGIN_ID, TEL) VALUES('test01','010-1234-5678');
-- 값을 지정하지 않을 때만 기본값이 나옴
INSERT INTO TABLE_DEFAULT VALUES('test02',NULL,'010-4321-8765')




------------------ 사용자 생성 --------------
-- SYSTEM에서
