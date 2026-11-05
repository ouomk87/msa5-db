-- SELECT 문
-- DML 중 하나로, 저장되어 있는 데이터를 
-- 조회하기 위해 사용하는 쿼리 

-- SELECT 절 : 조회한 데이터 중 특정 컬럼만 출력
SELECT 
	emp_id  -- 예약어로 안쓴다. 백틱(`)으로 감싸줘도 상관없다.
	, `name` -- 백틱(`)안에 감싸주면 SQL 예약어가 아니라 컬럼명으로 더 정확하게 인식된다  
	, gender 
	, birth -- add v2.0
FROM employees -- FROM 절 : 테이블을 지정 : "employees"에서 가져오겠다!
;  -- 세미콜롬 ; 꼭 적기 


-- Asterrisk(*) 기호명 : 모든 컬럼 조회

SELECT
	*
FROM employees
;


-- WHERE 절 : 특정 컬럼의 값이 조건에 맞는 데이터만 조회
-- 사번이 10009인 사원의 모든 정보를 조회해 주세요.
SELECT
	*
FROM employees
WHERE
	emp_id = 10009 -- '10009'이렇게 안쓰는게 좋음. 데이터 타입이 안 맞을경우 
;


-- 사원명이  "박보람"인 사원의 정보를 조회해 주세요
SELECT
	*
FROM employees  -- AS emp 별칭 지어줄수 있음 emp.
WHERE 
	`name` = "박보람" -- '박보람' "",'' 둘다 가능함
;


-- 생일이 2000-01-01 이후인 사원 모두 찾아주세요
SELECT
	*
FROM employees
WHERE
	birth >= '2000-01-01' -- '2000-01-01 00:00:00.000' 형식 지키기
	-- 특정 달의 사람들을 가지고 오려면 데이터를 년 따로 월, 일 따로 해서 가져오는 방식으로 해야함
;


-- 퇴사 하지 않은 사원 정보 다 주세요.
-- NULL 값
SELECT
	*
FROM employees
WHERE
	fire_at IS NULL
;

-- 퇴사 한  사원 정보 다 주세요.

SELECT
	*
FROM employees
WHERE
	fire_at IS NOT NULL
;
	
	
















