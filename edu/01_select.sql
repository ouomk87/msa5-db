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

-- 1106 --------------------------------------------------------------

-- 1990년생인 사원을 조회해 주세요. 1990-01-01 1990 12-31
SELECT
	*
FROM employees
WHERE 
 birth >= '1990-01-01' -- '00:00:00'
 AND birth <= '1990-12-31' -- '< 1991-01-01 00:00:00'	
;

-- 이름이 '김철수' 또는  '정유리'인 사원을 조회해 주세요
SELECT
	*
FROM employees
WHERE
 `name` = '박보람'
 OR `name` = '정유리'
 ;
 
 
 -- 1990년생 이거나, 이름이 '정유리'인 사원을 조회해 주세요
 SELECT
 	*
FROM employees
WHERE
	(
	birth >= '1990-01-01'
	AND birth <= '1990-12-31'
	)
	OR `name` = '정유리' 
 ;  -- 조건이 두개 이기 떄문에 년생은 ()로 묶어야함: 그룹화 시켜줌 AND가 제일 먼전 연산됨
 
 -- 1990년생 이후이면서, 이름이 '정유리' 또는 '박보람'인 사원을 조회해 주세요
 SELECT
 	*
FROM employees
WHERE
	
	birth >= '1990-01-01'
	AND 
	(
	`name` = '정유리'
	OR `name` ='박보람' 
	)
 ;  -- 묶은거 부더 계산함
 
 -- 경계값들을 하나씩 확인해보면 내 쿼리가 맞는지 빠르게 확인 할수 있다.  
 

 
 
 -- BETWEEN 연산자 : 지정한 범위 내의 데이터를 조회
 SELECT
	*
FROM employees
WHERE 
	-- birth >= '1990-01-01'
	-- AND birth <= '1990-12-31'
	birth BETWEEN '1990-01-01' AND '1990-12-31' -- BETWEEN 는 이상 이하로 조회된다.
;


-- IN 연산자 : 다수의 지정한 값과 일치하는 데이터를 조회
SELECT
	*
FROM employees
WHERE
	`name` IN('박보람','정유리')
	-- OR 과 똑같은 결과가 나옴, 퍼포먼스 이슈가 나면 하나씩 풀어서 쓰면된다. 
	-- 아주 미세하게 느림 그래두 쓰는걸 추천
;


-- 사번이 10001, 10005, 10006인 사원의 모든 정보 조회
SELECT
	*
FROM  employees
WHERE
 	emp_id IN (10001, 10005, 10006)
;


-- LIKE 절 : 문자열의 내용을 조회
-- % 글자수와 상관없이 조회할 경우 사용
-- 이름이 '우'로 끝나는 사원 조회
SELECT
	*
FROM  employees
WHERE
	`name` LIKE '%우'
	`name` LIKE '우%' -- '우'가시작하는 사원 조회
	`name` LIKE '%우%' -- '우'가 포함된 사원 조회
	-- 많아 지면 많아질수록 속도가 느려짐
;


-- (_) : 언더바의 개수만큼 글자수를 허용해서 조회
SELECT
	*
FROM employees
WHERE
	`name` LIKE '_우'
	`name` LIKE '_우%'  -- 2번째가 무조건 '우'가 나오고 뒤에는 몇글자가 나와도 상관없을때 %
;

-- ORDER BY 절: 조회한 데이터를 정렬하는 절
SELECT
	*
FROM employees
-- ORDER BY `name` ASC  -- 오름차순 ASC은 생략이 가능하다 
ORDER BY `name` DESC  -- 내림차순
;

-- ORDER BY 절: 조회한 데이터를 정렬하는 절
SELECT
	*
FROM employees
ORDER BY `name` DESC , birth -- 이름(1순위)을 우선 보고  같은 결과 중에서 생일(2순위)을 정렬한다.
;
	
-- myAQL은 (NULL)이 1순위로 가져옴
-- myAQL은 데이터 순서가 정해져 있지않음
-- 컬럼들은 순서성을 가지지 않는다. (테이블에서 name이 2번째라고 해서 name익 2번인건 아니다. 중간에 데이터가 투가 되면 순서가 밀리기 때문에 
-- 정확한 컬러명을 지정해줘야한다. 


-- LIMIT 절, OFFSET 절 : 출력의 개수를 제한
SELECT
	*
FROM employees
-- LIMIT 5 OFFSET 10 -- 5개까지 자르고 5개부터  
LIMIT 10, 5 -- 단축해서 쓸수 있다.그대신 순서가 바뀐다. 
;-- 위치를 잡아주는 커서가 있는데 

-- SELECT CEIL(RAND()*100000);

-- ------------------------------------------------------------------

-- 집계함수: 
-- SUM(컬럼명) 값 : 조회된 해당 컬럼의 모든 값의 합꼐를 반환
-- 전 사원의 현재 급여 합계를 조회해 주세요.
SELECT
	SUM(salary) sum_sal -- 별칭을 적어주는게 좋음 : 합계
FROM salaries
WHERE 
	end_at IS NULL
;	
	
-- MAX(컬럼) : 최대값
SELECT
	MAX(salary) max_sal 
FROM salaries
WHERE 
	end_at IS NULL
;	

-- MIN(컬럼) : 최소값
SELECT
	MIN(salary) min_sal 
FROM salaries
WHERE 
	end_at IS NULL
;	

-- AVG(컬럼) : 평균
SELECT
	AVG(salary) avg_sal 
FROM salaries
WHERE 
	end_at IS NULL
;	

-- COUNT(컬럼) : 
-- 현재 재직중인 사원 수를 구해주세요.
SELECT
--	* 먼저 모든 값을 확인한다.
	COUNT(*) cnt -- 별칭
FROM employees
WHERE 
	fire_at IS NULL
;	

SELECT
	COUNT(*), -- *은 전체 개수를 샘 : NULL값으로 되어있는게 없음. *를 넣거나 PK(emp_id)를 넣거나
	COUNT(`name`) cnt -- (name 이외 특정컬럼 모두)은  그 목록중에 NULL이 있으면 개수를 제외하고 집계됨
FROM employees
WHERE 
	fire_at IS NULL
;	
-- 컬러명 삽입시  검색 결과 중 해당 컬럼의 값이
-- NULL 이 아닌 레코드의 총 수를 출력



-- DISTINCT 키워드 : 검색결과에서 중복된 레코드를 없이 출력
SELECT DISTINCT -- 중복된 레코드를 없애고 싶을때
	`name`
 -- , emp_id -- ID값을 같이 조회하면 중복된 레코드가 없기때문에 이름중독이 생김
  
FROM employees
ORDER BY `name`
;
-- 속도가 느려질수 밖에 없는 구조다.
-- DISTINCT는 SELECT 바로 옆에 적어야함!



-- GROUP BY 절, HAVING 절
-- 그룹으로 묶어서 조회

-- 부서별 사원수??
SELECT
	-- SELECT 절에 작성하는 컬럼은
	-- GROUP BY 절에서 사용한 컬럼과
	-- 집계함수만 작성해야한다.(SQL 표준문법)
	dept_code
	, COUNT(*) cnt_emps 이렇게 써도 되고 PK를 써도됨
--	, COUNT(dept_emp_id) cnt_emps -- 보통 PK를 씀
	 
FROM department_emps
WHERE
	end_at IS NULL
GROUP BY dept_code
;
-- 순서 
-- nuLL값을 먼저구하고  그룹으로 묶고 묶은 그룹에서 전체 개수를 계산함 


-- 직급별 사원수가 10000만명 이상인 직급을 조회 해주세요.
SELECT

	title_code
	,COUNT(*) cnt
	
FROM title_emps
WHERE
	end_at IS NULL
GROUP BY title_code
	HAVING cnt >= 10000
;
-- 직급별 사원수를 먼저 계산함
-- 10000만명 이상인은 직
-- 그룹절에 조건을 달았을때 거기에 해빙절을 사용함 













 

 
 














