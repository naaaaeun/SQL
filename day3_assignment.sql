/* 
* 이론과제 답안 제출 먼저 드립니다.
* Q 3-1
* (1) 원자성
* (2) 완전 함수적 종속
* (3) 이행적 종속 제거
*
* Q 3-2
* (1) 제3정규화
* (2) 제2정규화
*
* Q 3-3
* (1) inner join
* (2) left join
* (3) right join
* (4) outer join
*
* Q 3-4
* (1) 반정규화
*
* Q 3-5
* (1) 인덱스 
* (2) 인덱스
* (3) 인덱스
* (4) 인덱스
*
* Q 3-6
* (1) 트랜잭션
* (2) 원자성
* (3) 일관성
*/


/* 
* 1. DEPT 테이블과 동일한 DEPT_TEST 테이블을 만들고 다음과 같이 데이터를 입력하세요
*/
CREATE TABLE DEPT_TEST (
    DEPTNO NUMBER(2) PRIMARY KEY,
    DNAME VARCHAR2(20),
    LOC VARCHAR2(20)
);

INSERT INTO DEPT_TEST VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT_TEST VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO DEPT_TEST VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO DEPT_TEST VALUES (40, 'OPERATIONS', 'BOSTON');
INSERT INTO DEPT_TEST VALUES (50, 'ORACLE', 'BUSAN');
INSERT INTO DEPT_TEST VALUES (60, 'SQL', 'ILSAN');
INSERT INTO DEPT_TEST VALUES (70, 'SELECT', 'INCHEON');
INSERT INTO DEPT_TEST VALUES (80, 'DML', 'BUNDANG');




/* 2. EMP 테이블 구조와 동일한 EMP_TEST 테이블을 생성한 후 다음과 같이 데이터를 입력하세요 */
CREATE TABLE EMP_TEST (
    EMPNO NUMBER(4) PRIMARY KEY,
    ENAME VARCHAR2(20),
    JOB VARCHAR2(20),
    MGR NUMBER(4),
    HIREDATE DATE,
    SAL NUMBER(6)
);

INSERT INTO EMP_TEST VALUES (7201, 'TEST_USER1', 'MANAGER', 7788, TO_DATE('2016-01-02', 'YYYY-MM-DD'), 4500);
INSERT INTO EMP_TEST VALUES (7202, 'TEST_USER2', 'CLERK', 7201, TO_DATE('2016-02-21', 'YYYY-MM-DD'), 1800);
INSERT INTO EMP_TEST VALUES (7203, 'TEST_USER3', 'ANALYST', 7201, TO_DATE('2016-04-11', 'YYYY-MM-DD'), 3400);
INSERT INTO EMP_TEST VALUES (7204, 'TEST_USER4', 'SALESMAN', 7201, TO_DATE('2016-05-31', 'YYYY-MM-DD'), 2700);
INSERT INTO EMP_TEST VALUES (7205, 'TEST_USER5', 'CLERK', 7201, TO_DATE('2016-07-20', 'YYYY-MM-DD'), 2600);
INSERT INTO EMP_TEST VALUES (7206, 'TEST_USER6', 'CLERK', 7201, TO_DATE('2016-09-08', 'YYYY-MM-DD'), 2600);
INSERT INTO EMP_TEST VALUES (7207, 'TEST_USER7', 'LECTURER', 7201, TO_DATE('2016-10-28', 'YYYY-MM-DD'), 2300);
INSERT INTO EMP_TEST VALUES (7208, 'TEST_USER8', 'STUDENT', 7201, TO_DATE('2016-03-09', 'YYYY-MM-DD'), 1200);


/* 3. EMP_TEST 테이블에서 DEPTNO = 50인 직원의 평균 월급(SAL)인 직원보다 큰 경우 */
/* DEPTNO를 70으로 값을 갱신하세요 */

UPDATE EMP_TEST
SET DEPTNO = 70
WHERE DEPTNO = 50 AND SAL > (SELECT AVG(SAL) FROM EMP_TEST WHERE DEPTNO = 50);



/* 4. EMP_TEST 테이블에서 DEPTNO = 60인 직원 중에서 입사일이 가장 빠른 직원 이후에 */
/* 입사한 직원의 DEPTNO를 80으로 변경하고 월급(SAL)을 20% 인상한 수치로 갱신하세요*/

UPDATE EMP_TEST 
SET DEPTNO = 80, SAL = SAL * 1.2
WHERE DEPTNO = 60 
AND HIREDATE > (SELECT MIN(HIREDATE) FROM EMP_TEST WHERE DEPTNO = 60);



/* 1. 아래와 같은 컬럼명과 데이터 구조로 EMP_USER 테이블을 만들어 보세요*/

CREATE TABLE EMP_USER (
    EMPNO NUMBER(5),
    ENAME VARCHAR2(20),
    JOB VARCHAR2(10),
    MGR NUMBER(5),
    HIREDATE DATE,
    SAL NUMBER(7,2),
    DEPTNO NUMBER(2),
    ROWID ROWID
);

/* 2. EMP_USER 테이블에 일자(DATE), 퇴사일 컬럼(RESIGN_DATE)을 추가하세요 */

ALTER TABLE EMP_USER ADD (HIRE_DATE DATE, RESIGN_DATE DATE);


/* 3. EMP_USER 테이블에 문자열 5자리, 성(SUR_NAME) 컬럼을 추가하세요 */

ALTER TABLE EMP_USER ADD (SUR_NAME VARCHAR2(5));

/* 4. 직원 중에서 성이 9자리인 직원 때문에 문자열 10자리로 성(SUR_NAME) 컬럼을 변경하세요 */

ALTER TABLE EMP_USER MODIFY (SUR_NAME VARCHAR2(10));

/* 5. EMP_USER 테이블명의 ENAME 컬럼명을 FULL_NAME명으로 변경하세요 */
  
ALTER TABLE EMP_USER RENAME COLUMN ENAME TO FULL_NAME;

/* 1. EMP 테이블과 동일한 구조의 EMP_IDX 테이블을 생성한 후 EMPNO컬럼에 인덱스를 지정하고 */
/* 인덱스명은 EMP_EMPNO_IDX를 지정하세요 */

-- EMP_IDX 테이블 생성
CREATE TABLE EMP_IDX (
  EMPNO NUMBER(5),
  ENAME VARCHAR2(10),
  JOB VARCHAR2(9),
  DEPTNO NUMBER(2),
  SAL NUMBER(7, 2),
  COMM CHAR(1)
);

-- EMP_EMPNO_IDX 인덱스 생성
CREATE INDEX EMP_EMPNO_IDX ON EMP_IDX (EMPNO);



/* 2. 1번에서 만든 인덱스를 USER_INDEXES 사전 테이블에서 인덱스명으로 조회하세요 */

SELECT *
FROM USER_INDEXES
WHERE INDEX_NAME = 'EMP_EMPNO_IDX';

/* 3. CREATE OR REPLACE VIEW 명령어를 사용하여 EMP_IDX 테이블에서 SAL(월급)이 20,000 */
/* 이상인 직원을 추출하고 COMM이 있는 경우 'Y', 없거나 NULL인 경우 'N'으로 표시하세요 */

CREATE OR REPLACE VIEW SAL_COMM_VIEW AS
SELECT EMPNO, ENAME, JOB, DEPTNO, SAL, 
       CASE WHEN COMM IS NOT NULL THEN 'Y' ELSE 'N' END AS COMM_YN
FROM EMP
WHERE SAL >= 20000;


/* 다음의 내용에 해당하는 용어는 무엇일까요?
 1. 테이블에 입력할 데이터의 특성이나 조건을 정의하는 데 사용되는 규칙은? 
- 제약 조건(Constraints)
 2. 컬럼에 유일한 값만 고유값만 입력 가능하지만 NULL 값은 가능한 키워드는?
- 유일성 제약 조건(Unique Constraint)
 3. NULL 값을 허용하지 않는 키워드는?
- NOT NULL
 4. 가장 중요한 컬럼의 특셩으로 고유값이면서 NULL 값이 허용되지 않는 키워드는?
- PRIMARY KEY
 5. 다른 테이블의 칼럼을 참조하는 특성을 설명하는 키워드는?
- 외래키(Foreign Key) */