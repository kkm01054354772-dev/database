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