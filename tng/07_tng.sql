-- 1. 사원(재직중)의 사원번호, 이름, 직급코드를 출력해 주세요.
 -- emp_id , `name` title_code 
SELECT
	emp.emp_id
	,emp.`name`
	,tits.title_code

FROM employees emp
 JOIN title_emps tite
	ON emp.emp_id = tite.emp_id
		AND emp.fire_at IS NULL
	JOIN titles tits
	ON tite.title_code = tite.title_code
		AND tite.end_at IS NULL
;
	
-- 2. 사원(재직중)의 사원번호, 성별, 현재 연봉을 출력해 주세요.
--  emp_id, gender, salary
SELECT
	emp.emp_id
	,emp.gender
	,sal.salary

FROM employees emp
	JOIN salaries sal
	ON emp.emp_id = sal.emp_id
		 AND emp.fire_at IS NULL
		 AND sal.end_at IS NULL
;

-- 3. 10010 사원(재직중)의 이름과 과거부터 현재까지 연봉 이력을 출력해 주세요.

SELECT
	emp.`name`
	,sal.salary
	,sal.start_at
	,sal.end_at
FROM salaries sal
	JOIN employees emp
	ON sal.emp_id = emp.emp_id
	AND emp.emp_id = 10010	
;

-- 4. 사원(재직중)의 사원번호, 이름, 소속부서명을 출력해 주세요.
-- emp_id, `name` dept_emp_id
SELECT
	emp.emp_id
	,emp.`name`
	,dep.dept_name

FROM  employees emp
	JOIN department_emps depe
	ON emp.emp_id = depe.emp_id
		AND emp.fire_at IS NULL
	JOIN departments dep
		ON depe.dept_code = dep.dept_code
			AND depe.end_at IS NULL
;

-- 5. 현재 연봉의 상위 10위까지 사원의 사번, 이름, 연봉을 출력해 주세요.
--  emp_id `name` salary
SELECT
	emp.emp_id
	,emp.`name`
	,sal.salary

FROM employees emp
	JOIN salaries sal	
	ON emp.emp_id = sal.emp_id
		AND emp.fire_at IS NULL
		AND sal.end_at IS NULL
ORDER BY sal.salary DESC
LIMIT 10 		
;

 -- 속도 개선버전 (공간 복잡도는 증가 할수 있음
SELECT
	emp.emp_id
	,emp.`name`
	,tmp_sal.salary
FROM employees emp
	JOIN (
		SELECT
			sal.emp_id
			,sal.salary
		FROM salaries sal
		WHERE
			sal.end_at IS NULL
		ORDER BY sal.salary DESC
		LIMIT 10
	) tmp_sal
		ON emp.emp_id = tmp_sal.emp_id
			AND emp.fire_at IS NULL
ORDER BY tmp_sal.salary DESC
;
				
-- 6. 현재 각 부서의 부서장의 부서명, 이름, 입사일을 출력해 주세요.
-- dept_code, `name` hire_at

SELECT
	emp.`name`
	,emp.hire_at
	,dep.dept_code

FROM employees emp
	JOIN department_managers depm
	ON emp.emp_id = depm.emp_id
		AND emp.fire_at IS NULL 
		AND depm.end_at IS NULL 
	JOIN departments dep
    ON dep.dept_code = depm.dept_code
    	AND dep.end_at IS NULL 
    
;

SELECT
	emp.`name`
	,emp.hire_at
	,dep.dept_code

FROM employees emp
	JOIN department_managers depm
	ON emp.emp_id = depm.emp_id
		
	JOIN departments dep
    ON dep.dept_code = depm.dept_code
    -- AND dep.end_at IS NULL
WHERE emp.fire_at IS NULL 
		AND depm.end_at IS NULL 
    
;

-- 7. 현재 직급이 "부장"인 사원들의 각각 연봉 평균을 출력해 주세요.
SELECT
	emp.emp_id
	,AVG(sal.salary)
FROM employees emp
	JOIN title_emps tite
	ON emp.emp_id = tite.emp_id
		AND emp.fire_at IS NULL
	JOIN titles tits
	ON tite.title_code = tits.title_code
		AND tite.end_at IS NULL
		AND tits.title = '부장'
	JOIN salaries sal
	ON emp.emp_id = sal.emp_id
		AND sal.end_at IS NULL
GROUP BY emp.emp_id	
;

SELECT
	tite.emp_id	
	,AVG(sal.salary)
FROM title_emps tite
	JOIN titles tit
	ON tite.title_code = tit.title_code
		AND tite.end_at IS NULL
		AND tit.title = '부장'
	JOIN salaries sal
		ON tite.emp_id = sal.emp_id
GROUP BY tite.emp_id	
ORDER BY tite.emp_id	
;

			

-- 7-1. (보너스)현재 각 부장별 이름, 연봉평균
SELECT
	emp.`name`
	,tite.emp_id	
	,AVG(sal.salary)
FROM employees emp
	JOIN title_emps tite
	ON emp.emp_id = tite.emp_id
		AND emp.fire_at IS NULL
	JOIN titles tits
	ON tite.title_code = tits.title_code
		AND tite.end_at IS NULL
		AND tits.title = '부장'
	JOIN salaries sal
	ON emp.emp_id = sal.emp_id
		AND sal.end_at IS NULL
GROUP BY emp.emp_id	
ORDER BY tite.emp_id
;

-- 8. 부서장직을 역임했던 모든 사원의 이름과 입사일, 사번, 부서번호를 출력해 주세요.
-- `name` hire_at  emp_id  dept_code
SELECT
	emp.`name`
	,emp.hire_at
	,emp.emp_id
	,depm.dept_code
 FROM  employees emp
 	JOIN department_managers depm
 	ON emp.emp_id = depm.emp_id
 		AND emp.fire_at IS NULL
 	;


-- 9. 현재 각 직급별 평균연봉 중 60,000,000이상인 직급의 직급명, 평균연봉(정수)를을 평균연봉 내림차순으로 출력해 주세요.
-- title avg
SELECT
	tit.title
	,CEIL(AVG(sal.salary)) avg_sal
FROM title_emps tite
	JOIN titles tit
		ON tite.title_code = tit.title_code
	JOIN salaries sal
	ON sal.emp_id = tite.emp_id
		AND sal.end_at IS NULL
		AND tite.end_at IS NULL
GROUP BY tit.title
	HAVING AVG(sal.salary) >= 60000000
ORDER BY avg_sal DESC		
;
	

-- 10. 성별이 여자인 사원들의 직급별 사원수를 출력해 주세요.
SELECT
	tite.title_code
	,COUNT(tite.emp_id) cnt
FROM employees emp
	JOIN title_emps tite
		ON emp.emp_id = tite.emp_id
			AND emp.fire_at IS NULL
			AND tite.end_at IS NULL
			AND emp.gender = 'F'	
GROUP BY tite.title_code
ORDER BY tite.title_code
;



-- ------------------------------
-- 전체 평균 급여보다 높은 급여를 받은 기록을 조회



-- 가장 높은 급여를 받은 이력이있는 사원의 사번과 급여를 조회