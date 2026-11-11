-- ------------------
-- join 문
-- 복수의 테이블을 묶어서 하나의 결과 집합으로 출력
-- ------------------



-- ------------------
-- INNER JOIN
-- 복수의 테이블이 공통적으로 만족하는 레코드를 출력
-- ------------------
-- 전 사원의 사번, 이름, 현재급여를 출력해주세요.
-- 여러테이플을 가져오기때문에 FROM
SELECT
	 emp.emp_id
	 ,emp.`name`
	 ,sal.salary
FROM employees emp
	 JOIN  salaries sal             -- INNER JOIN 에 INNER 생략함 
		ON emp.emp_id = sal.emp_id -- 조건절 ON절 where절 having절
		AND sal.end_at IS NULL
	;


-- 재직중인 사원의 사번, 이름, 생일, 부서명 (공통되는 부분이 없다면 연결되는 테이블을 찾아 다 가져온다.)
-- emp_id , `name` , birth, 부서명은 
SELECT
	emp.emp_id
	, emp.`name`
	, emp.birth
	, dep.dept_name

FROM employees emp
	JOIN department_emps depe
		ON emp.emp_id = depe.emp_id
			AND emp.fire_at IS NULL
		JOIN departments dep
			ON depe.dept_code = dep.dept_code
				AND depe.end_at IS NULL
;


-- ------------------------------------
-- LEFT JOIN
-- ------------------------------------
-- 재직중인 전 사원 정보를 출력하는데,
-- 현재 부서장인 사원이면 부서장 정보도 같이 출력해주세요.
SELECT
	emp.emp_id                    
	,emp.`name`
	,depm.dept_code
	,dep.dept_name
FROM employees emp
	LEFT JOIN department_managers depm
		ON emp.emp_id = depm.emp_id
			AND emp.fire_at IS NULL
			AND depm.end_at IS NULL
		 JOIN departments dep
		ON dep.dept_code = depm.dept_code
ORDER BY depm.dept_code DESC -- ORDER BY depm.dept_code IS NULL, depm.dept_code
;

SELECT * FROM department_managers WHERE end_at IS NULL;

SELECT
	emp.emp_id
	,emp.`name`
	,depm.dept_code
	,dep.dept_name
FROM employees emp
	LEFT JOIN (department_managers depm
		JOIN departments dep
			ON dep.dept_code = depm.dept_code
				AND depm.end_at IS NULL
	)
		ON emp.emp_id = depm.emp_id
			AND emp.fire_at IS NULL		
ORDER BY depm.dept_code IS NULL, depm.dept_code
;


-- --------------------------------------------
-- UNION
-- 두개 이상의 쿼리의 결과를 합쳐서 출력
-- NUION     (중복 레코드를 제거)
-- UNION ALL (중복 레코드를 제거 안함)
-- --------------------------------------------

SELECT
*
FROM employees
	WHERE emp_id IN(1,3)
UNION
SELECT
*
FROM employees
	WHERE emp_id IN(1,5)
;

SELECT
	*, '1'
FROM employees
	WHERE emp_id IN(1,3)
UNION
SELECT
	*, '2'
FROM employees
	WHERE emp_id IN(1,5)
; 
-- 한컬럼이라도 다르면 다르게 취급한다.
-- UNION 할때 컬럼의 갯수를 같게 해야한다. *, '1'


-- --------------------------------------------
-- SELF JOIN
-- 같은 테이블 끼리 조인
-- --------------------------------------------
-- 현재 슈퍼바이저인 사원 정보 출력

SELECT
	emp.emp_id junior_emp_id
	,emp.`name` junior_emp_name
	,sup.emp_id sup_id
	,sup.`name` sup_name
FROM employees emp
 	JOIN employees sup
 		ON emp.sup_id = sup.emp_id
 		AND emp.sup_id IS NOT NULL
 ;


