-- c##을 사용안하도록 설정
-- 오라클버전이 업데이트 되면서 사용자를 아이디 앞에 c##을 붙이도록 설정되어 있음
-- hr 사용자 생성 => c##hr
ALTER SESSION SET "_oracle_script"=TRUE;

-- @C:\db-sample-schemas-main\human_resources\hr_install.SQL
-- @C:\app\soldesk\product\21c\dbhomeXE\rdbms\admin\scott.SQL
-- sys AS sysdba

-- 권한부여 : GRANT 
GRANT CREATE VIEW TO SCOTT;

GRANT CREATE PUBLIC SYNONYM TO SCOTT;
GRANT CREATE SYNONYM TO SCOTT;


-- 사용자
-- 데이터베이스에 접속하여 데이터 관리하는 계정

-- Oracle DB
-- 테이블, 뷰, 인덱스, 시퀀스, ... => 업무별 사용자 생성 후 객체 생성할 수 있는 권한 부여
-- CREATE USER 사용자이름 IDENTIFIED BY 비밀번호 ;

-- 공통 사용자 또는 롤 이름이 부적합합니다. => C## 접두어가 무조건 필요
CREATE USER TEST1 IDENTIFIED BY 12345;

CREATE USER C##TEST1 IDENTIFIED BY 12345;
-- C##을 안붙이려면
ALTER SESSION SET "_oracle_script"=TRUE;
CREATE USER TEST2 IDENTIFIED BY 12345;

-- 사용자 TEST1은 CREATE SESSION 권한을 가지고있지 않음; 로그온이 거절되었습니다
GRANT CREATE SESSION TO TEST2;
-- 개별 권한을 묶어서 관리 => 롤
GRANT CONNECT, RESOURCE TO TEST2;
-- 테이블스페이스 'USERS'에 대한 권한이 없습니다.
--ALTER USER TEST2 DEFAULT TABLESPACE USERS QUOTA 2M ON USERS;



-- 사용자 생성 ------------------------
ALTER SESSION SET "_oracle_script"=TRUE; -- C##을 안붙이기 위한 조건
CREATE USER TEST3 IDENTIFIED BY 12345 -- ID(대소문자 구분X) 비밀번호(대소문자 구분O)
DEFAULT TABLESPACE USERS 
TEMPORARY TABLESPACE TEMP
QUOTA 2M ON USERS --용량
;
GRANT CONNECT, RESOURCE TO TEST3; -- 다양한 기본적 권한 부여
------------------------------------

-- 사용자 삭제
DROP USER test2 CASCADE;
DROP USER test3 CASCADE;

-- 권한 취소
-- REVOKE 권한 FROM 사용자명
REVOKE CREATE SESSION FROM test2;

-- 비밀번호 변경
ALTER USER TEST3 IDENTIFIED BY 변경할비밀번호;