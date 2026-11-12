-- DB 생성
CREATE DATABASE test;

-- DB 접근/선택
USE test;
USE dbsample;
-- SELECT * FROM employees;

-- DB 삭제
DROP DATABASE test;

-- DB는 수정이 없음 지우고 다시 생성해야한다.
-- 복원 지점을 지정하지않는 이상 되돌릴수 없다. 
-- 컬럼은 수정할수 있지만 이 수정도 되돌릴방법이 없다. 바로 적용된다.
