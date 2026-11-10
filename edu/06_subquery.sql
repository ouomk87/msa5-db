-- sub Query


-- ----------------------
-- WHERE 절에서 사용
-- ----------------------
-- 단일 행 서브 쿼리
-- 서브쿼리가 단일 행 비교 연산자와 함께 사용할 때는
-- 반드시 서브쿼리의 결과 수가 1건 이하여햐한다.
-- 만약에 2건 이상일 경우 오류가 발생

-- D001 부서장의 사번과 이름을 출력

SELECT 
	emp.emp_id -- 테이블명.컬럼(중복되는 컬럼이 많기 때문에 테이블명 써 주는게 좋다.)
	,emp. `name`
FROM employees emp -- 테이블이 2개이상 사용할떄 별칭을 정함 employees.emp_id 나 emp.emp_id 사용하거나 테이블 명이 길어서 별칭을 쓴다.
WHERE
	emp.emp_id = (
	
	SELECT
	 	depm.emp_id
	 FROM department_managers depm
	 WHERE
	 	depm.dept_code = 'D001'
	 	AND depm.end_at IS NULL

	)

;
-- `D001`의 현재 부서장 사번
SELECT
 emp_id
 FROM department_managers
 WHERE
 	dept_code = 'D001'
 	AND end_at IS NULL
;

-- 다중 행 서브쿼리
-- 서브쿼리의 결과가 2건 이상을 반환 할 경우
-- 반드시 다중 행 비교 연산자(IN,ALL,ANY, SOME, EXISTS)를 사용해야한다. 
-- 현재 부서장인 사원의 사번과 이름을 출력
SELECT
	depm.emp_id
FROM department_managers depm
WHERE 
	 depm.end_at IS NULL
	;
	
SELECT
	 emp.emp_id
	,emp.`name`
FROM employees emp
WHERE 
	emp.emp_id IN(
	
	SELECT
		depm.emp_id
		FROM department_managers depm
		WHERE 
		 depm.end_at IS NULL
	)
	;


-- 다중 열 서브쿼리
-- 현재'D002' 부서장이 해당 부서에 소속 된 날짜를 출력

SELECT
	depe.start_at
FROM department_managers depe
WHERE
	(depe.emp_id, depe.dept_code) IN (
	
	SELECT
	  depm.emp_id
	 ,depm.dept_code
	FROM department_managers depm
	WHERE 
		depm.dept_code = 'D002'
		AND depm.end_at IS NULL
	) 
;


SELECT
  depm.emp_id
 ,depm.dept_code
FROM department_managers depm
WHERE 
	depm.dept_code = 'D002'
	AND depm.end_at IS NULL
;


-- 연관 서브쿼리
-- 서브쿼리 내에서 메인쿼리의 컬럼이 사용된 서브쿼리
-- 부서장직을 지냈던 경력이 있는 사원의 정보를 출력
SELECT
	emp.*
FROM employees emp
WHERE 
	emp.emp_id IN(
	SELECT
		 depm.emp_id
	FROM department_managers depm
	where
		depm.emp_id = emp.emp_id
	 
	)
;

SELECT
		emp.*
	FROM department_managers emp
	JOIN department_managers depm
	ON depm.emp_id = emp.emp_id
;


-- ----------------------
-- SELECT 절에서 사용
-- ----------------------
-- 사원별 역대 전체 급여 평균
SELECT 
	emp.emp_id
	,(
	SELECT 
		AVG(sal.salary)
		FROM salaries sal
		WHERE sal.emp_id = emp.emp_id
	) avg_sal
FROM employees emp
; 

-- -------------------
-- from 절에서 사용
-- -------------------

SELECT
	tmp.*
FROM (
	select
	emp.emp_id
	,emp.`name`
	FROM employees emp
	where
	 fire_at IS NOT NULL
) tmp
;

-- ----------------------
-- Insert 문에서 사용
-- ----------------------
INSERT INTO employees(
 	 employees.emp_id
 	, employees.`name`
 	, employees.birth
 	, employees.gender
 	, employees.hire_at

)
VALUES (
	(SELECT MAX(emp.emp_id) + 1 FROM employees emp) 
 	,'둘리'
 	, '1980-01-01'
 	, 'M'
 	, NOW()
)
;



-- ----------------------
-- Update 문에서 사용
-- ---------------------- 
--  퇴사한 사원의 직급 테이블의  직급 종료일을 퇴사일로 갱신해 주세요
UPDATE title_emps
SET
	title_emps.end_at = (
		SELECT employees.fire_at
		FROM employees
		where
			employees.emp_id = 100017
	)
WHERE
	title_emps.emp_id = 100017
	AND title_emps.end_at IS NULL
	;





