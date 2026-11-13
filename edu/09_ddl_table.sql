CREATE DATABASE test;
USE test;





-- ------------------------------------------------------------------------
-- 개념적 설계
-- 테이블과 필요한 속성들이 무엇일까?
-- ------------------------------------------------------------------------

-- -------------
-- 테이블 생성
-- -------------

-- 유저 테이블
-- pk, 이메일, PW, 이름, 생년월일, 전화번호, 성별, 주소, 프로필,
-- 가입일자, 탈퇴일, 작성일, 수정일, 삭제일
-- 컬럼명, 테이터타입, 여러가지 제약 조건 
-- PRIMARY KEY not null unique 안써줘도 둘다 포함된다.
-- CREATE + 어떤스키마 만들꺼냐? 테이블, 인덱슨, 등등 

CREATE TABLE users(
	id 					BIGINT 			PRIMARY KEY AUTO_INCREMENT
	,email 				VARCHAR(100) 	NOT NULL UNIQUE
	,`password` 		VARCHAR(255) 	NOT NULL
	,user_name 			VARCHAR(30) 	NOT NULL
	,birth 				DATE 				NOT NULL
	,phone 				CHAR(13) 		NOT NULL COMMENT '\'010-0000-1111\' , 하이픈 포함 13자'
	,gender 				CHAR(1) 			NOT NULL COMMENT '\'M\', \'F\''
	,addr_number 		CHAR(5)
	,addr1 				VARCHAR(50)
	,addr2 				VARCHAR(50)
	,`profile` 			VARCHAR(100)
	,hired_at 			DATE 				NOT NULL  DEFAULT (CURRENT_DATE()) -- CURRENT_DATE() 키워드로 만들어지지않은건 () 안에 넣어서 해야한다.
	,withdrawn_at 		DATETIME 		DEFAULT NULL
	,created_at 		DATETIME 		NOT NULL DEFAULT CURRENT_TIMESTAMP()
	,updated_at 		DATETIME 		NOT NULL DEFAULT CURRENT_TIMESTAMP()
	,deleted_at 		DATETIME 		DEFAULT NULL
	
	
	-- CONSTRAINT 키워드로 이름을 별도로 지정
	,CONSTRAINT uk_user_email UNIQUE(email)
	
);

-- 게시물 테이블
-- PK, 제목, 본문, 이미지, 작성자, 게시글 삭제일, 작성일, 수정일, 삭제일
CREATE TABLE posts(
	id 					BIGINT 			PRIMARY KEY AUTO_INCREMENT
	,user_id				BIGINT 			NOT NULL 
	,title 				VARCHAR(100) 	NOT NULL
	,content 			VARCHAR(500) 	
	,image 				VARCHAR(100) 	NOT NULL
	,deactived_at 		DATE				DEFAULT NULL
	,created_at 		DATETIME			NOT NULL	DEFAULT CURRENT_TIMESTAMP()
	,updated_at 		DATETIME 		NOT NULL DEFAULT CURRENT_TIMESTAMP() 
	,deleted_at 		DATETIME 		DEFAULT NULL  


);
-- ---------------------
-- 테이블 수정(스키마수정)
-- 제약 조건 (CONSTRAINT) 추가
-- -----------------------

-- 컬럼 추가
ALTER TABLE users
ADD COLUMN birth_month CHAR(2) NOT NULL COMMENT '\'MM\' 양식' ;


-- 컬럼의 수정
-- ALTER TABLE[테이블명] MODIFY COLUMN[컬럼명][타입][제약조건]
ALTER TABLE users
MODIFY COLUMN birth_month CHAR(2) COMMENT '\'MM\' 양식'; 

-- 컬럼 삭제
-- ALTER TABLE [테이블명] DROP COLUMN[컬럼명]
ALTER TABLE users
DROP COLUMN birth_month; 



-- posts 테이블에 fk 제약조건 추가
-- ALTER, 어떤스키마
ALTER TABLE posts
ADD CONSTRAINT fk_posts_user_id 
FOREIGN KEY (user_id) REFERENCES users(id);

-- 제약조건 (CONSTRAINT)제거
ALTER TABLE posts
DROP CONSTRAINT fk_posts_user_id; 

-- INDEX도 삭제하기
ALTER TABLE posts
DROP INDEX fk_posts_user_id; 

-- ---------------------
-- AUTO_INCREMENT 값 변경 
-- 최대값 도달 문제: 자료형이 허용하는 최대 번호에 도달하면 더 이상 증가시킬 수 없다.
-- 더블체크 꼭 하기
ALTER TABLE users AUTO_INCREMENT = 1; 



-- --------------------------
-- TRUNCATE 문 : 테이블의 모든 데이터를 깨끗하게 제거하는 문 : 
-- 한번 제거 하면 되돌릴수 없음, 복구방법이 없음 
-- TRUNCATE 있는 이유 : 지금 당장에 쓰지 않더라도 보존하는기간이 있음
-- 그러다가 시간이 지나서 유지하지않아도 되는 기간이 오면 데이터를 제거할때 있음
-- 쓸때 꼭 재차 확인하기!!
-- --------------------------
TRUNCATE TABLE users;

-- ----------------------------------
-- 테이블 삭제
--  ---------------------------------
DROP TABLE posts, users;







