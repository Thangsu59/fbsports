SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS ADDR_INFO;
DROP TABLE IF EXISTS BOARD_FILE_INFO;
DROP TABLE IF EXISTS BOARD_INFO;
DROP TABLE IF EXISTS CHAT_TABLE;
DROP TABLE IF EXISTS COMMENT_INFO;
DROP TABLE IF EXISTS COUPON_INFO;
DROP TABLE IF EXISTS COUPON_TYPE_INFO;
DROP TABLE IF EXISTS ORDER_DETAIL_INFO;
DROP TABLE IF EXISTS ORDER_INFO;
DROP TABLE IF EXISTS PRODUCT_FILE_INFO;
DROP TABLE IF EXISTS RECENT_INFO;
DROP TABLE IF EXISTS SHOPING_CART;
DROP TABLE IF EXISTS PRODUCT_INFO;
DROP TABLE IF EXISTS ROLE_MAP;
DROP TABLE IF EXISTS ROLE_INFO;
DROP TABLE IF EXISTS SUB_TYPE_INFO;
DROP TABLE IF EXISTS TYPE_INFO;
DROP TABLE IF EXISTS USER_INFO;




/* Create Tables */

CREATE TABLE ADDR_INFO
(
	-- 기본키
	AI_NUM int NOT NULL AUTO_INCREMENT COMMENT '기본키',
	-- 회원번호
	UI_NUM int NOT NULL COMMENT '회원번호',
	-- 신주소
	-- EX) 경기 의정부시 용현로 143
	AI_ADDRESS varchar(1000) COMMENT '신주소
EX) 경기 의정부시 용현로 143',
	-- API에서는 한글자로 표기되어있음
	-- EX) "R"
	AI_TYPE varchar(1) COMMENT 'API에서는 한글자로 표기되어있음
EX) "R"',
	-- Y OR N
	AI_APARTMENT varchar(1) COMMENT 'Y OR N',
	-- EX) "경기 의정부시 민락동 691-1"
	AI_JIBUNADDRESS varchar(1000) COMMENT 'EX) "경기 의정부시 민락동 691-1"',
	-- "691-1, Millak-dong, Uijeongbu-si, Gyeonggi-do, Korea"
	AI_JIBUNADDRESSENGLISH varchar(1000) COMMENT '"691-1, Millak-dong, Uijeongbu-si, Gyeonggi-do, Korea"',
	-- EX) "경기 의정부시 용현로 143"
	AI_ROADADDRESS varchar(1000) COMMENT 'EX) "경기 의정부시 용현로 143"',
	-- EX) "143, Yonghyeon-ro, Uijeongbu-si, Gyeonggi-do, Korea"
	AI_ROADADDRESSENGLISH varchar(1000) COMMENT 'EX) "143, Yonghyeon-ro, Uijeongbu-si, Gyeonggi-do, Korea"',
	-- EX) "11800"
	AI_ZONECODE int(5) COMMENT 'EX) "11800"',
	-- EX) "4115010600106910001017676"
	AI_BUILDINGCODE int COMMENT 'EX) "4115010600106910001017676"',
	PRIMARY KEY (AI_NUM),
	UNIQUE (UI_NUM)
);


CREATE TABLE BOARD_FILE_INFO
(
	BFI_NUM int NOT NULL AUTO_INCREMENT,
	-- 번호
	BI_NUM int NOT NULL COMMENT '번호',
	BFI_NAME varchar(1000) NOT NULL,
	BFI_FILE_PATH varchar(2000) NOT NULL,
	BFI_SORT int,
	PRIMARY KEY (BFI_NUM)
);


CREATE TABLE BOARD_INFO
(
	-- 번호
	BI_NUM int NOT NULL AUTO_INCREMENT COMMENT '번호',
	-- 회원번호
	UI_NUM int NOT NULL COMMENT '회원번호',
	-- 상품 번호
	PI_NUM int NOT NULL COMMENT '상품 번호',
	-- 제목
	BI_TITLE varchar(100) NOT NULL COMMENT '제목',
	-- 내용
	BI_CONTENT varchar(4000) NOT NULL COMMENT '내용',
	-- 조회수
	BI_VIEWS int DEFAULT 0 COMMENT '조회수',
	-- 생성일
	BI_CREDAT varchar(8) DEFAULT 'DATE_FORMAT(NOW(),''%Y%m%d'')' COMMENT '생성일',
	-- 생성시간
	-- 
	BI_CRETIM varchar(6) DEFAULT 'DATE_FORMAT(NOW(),''%H%i%s'')' COMMENT '생성시간
',
	-- 수정일
	BI_LMODAT varchar(8) DEFAULT ' DATE_FORMAT(NOW(),''%Y%m%d'')' COMMENT '수정일',
	-- 수정시간
	BI_LMOTIM varchar(6) DEFAULT 'DATE_FORMAT(NOW(),''%H%i%s'')' COMMENT '수정시간',
	PRIMARY KEY (BI_NUM)
);


CREATE TABLE CHAT_TABLE
(
	CT_NUM int NOT NULL AUTO_INCREMENT,
	-- 회원번호
	UI_NUM int NOT NULL COMMENT '회원번호',
	CT_CONTENT varchar(1000) NOT NULL,
	CT_CREDAT varchar(8),
	-- 누구랑 채팅했는지 알 수 있다
	CT_ROOMNUM int NOT NULL COMMENT '누구랑 채팅했는지 알 수 있다',
	PRIMARY KEY (CT_NUM)
);


CREATE TABLE COMMENT_INFO
(
	-- 댓글 번호
	CI_NUM int NOT NULL AUTO_INCREMENT COMMENT '댓글 번호',
	-- 회원번호
	UI_NUM int NOT NULL COMMENT '회원번호',
	ODI_NUM int NOT NULL,
	-- 내용
	CI_CONTENT varchar(2000) NOT NULL COMMENT '내용',
	-- 생성일
	CI_CREDAT varchar(8) DEFAULT ' DATE_FORMAT(NOW(),''%Y%m%d'')' COMMENT '생성일',
	-- 생성시간
	CI_CRETIM varchar(6) DEFAULT 'DATE_FORMAT(NOW(),''%H%i%s'')' COMMENT '생성시간',
	-- 수정일
	CI_LMODAT varchar(8) DEFAULT 'DATE_FORMAT(NOW(),''%Y%m%d'')' COMMENT '수정일',
	-- 수정시간
	CI_LMOTIM varchar(6) DEFAULT 'DATE_FORMAT(NOW(),''%H%i%s'')' COMMENT '수정시간',
	-- 평점
	CI_SCORE tinyint NOT NULL COMMENT '평점',
	PRIMARY KEY (CI_NUM)
);


CREATE TABLE COUPON_INFO
(
	-- 보유 쿠폰 번호
	CPI_NUM int NOT NULL AUTO_INCREMENT COMMENT '보유 쿠폰 번호',
	CPTI_NUM int NOT NULL,
	-- 회원번호
	UI_NUM int NOT NULL COMMENT '회원번호',
	-- 쿠폰 유효기간(만료기간)
	CPI_EXPIRE date NOT NULL COMMENT '쿠폰 유효기간(만료기간)',
	PRIMARY KEY (CPI_NUM)
);


CREATE TABLE COUPON_TYPE_INFO
(
	CPTI_NUM int NOT NULL AUTO_INCREMENT,
	CPTI_NAME varchar(1000) NOT NULL,
	CPTI_DESC varchar(1000) NOT NULL,
	-- 이 상태는 쿠폰을 더 발급해줄수있냐 없냐 느낌
	CPTI_STATUS int(1) NOT NULL COMMENT '이 상태는 쿠폰을 더 발급해줄수있냐 없냐 느낌',
	-- 쿠폰에 대한 코드번호 고유값을 가짐
	CPTI_CODE varchar(100) NOT NULL COMMENT '쿠폰에 대한 코드번호 고유값을 가짐',
	CPTI_DISCOUNT int,
	-- 할인 가격이 없을때는 할인율
	CPTI_DISCOUNT_RATE int(3) COMMENT '할인 가격이 없을때는 할인율',
	-- 얼마 이상일때 사용할수 있냐
	CPTI_CONDITION int COMMENT '얼마 이상일때 사용할수 있냐',
	PRIMARY KEY (CPTI_NUM),
	UNIQUE (CPTI_CODE)
);


CREATE TABLE ORDER_DETAIL_INFO
(
	ODI_NUM int NOT NULL AUTO_INCREMENT,
	-- 회원번호
	UI_NUM int NOT NULL COMMENT '회원번호',
	-- 주문번호
	OI_NUM int NOT NULL COMMENT '주문번호',
	-- 상품 번호
	PI_NUM int NOT NULL COMMENT '상품 번호',
	ODI_AMOUNT int NOT NULL,
	ODI_CREDAT varchar(8) DEFAULT 'DATE_FORMAT(NOW(),''%Y%m%d'')',
	ODI_CRETIM varchar(6),
	ODI_PRICE int NOT NULL,
	PRIMARY KEY (ODI_NUM)
);


CREATE TABLE ORDER_INFO
(
	-- 주문번호
	OI_NUM int NOT NULL AUTO_INCREMENT COMMENT '주문번호',
	-- 회원번호
	UI_NUM int NOT NULL COMMENT '회원번호',
	OI_TOTAL_PRICE int NOT NULL,
	OI_ADDRESS varchar(1000) NOT NULL,
	OI_MEMO varchar(200),
	OI_CREDAT varchar(8) DEFAULT 'DATE_FORMAT(NOW(),''%Y%m%d'')',
	OI_CRETIM varchar(6) DEFAULT 'DATE_FORMAT(NOW(),''%H%i%s'')',
	OI_STATUS varchar(4),
	-- API보고 추가로 수정
	-- 
	OI_PAY varchar(10) COMMENT 'API보고 추가로 수정
',
	PRIMARY KEY (OI_NUM)
);


CREATE TABLE PRODUCT_FILE_INFO
(
	PFI_NUM int NOT NULL AUTO_INCREMENT,
	-- 상품 번호
	PI_NUM int NOT NULL COMMENT '상품 번호',
	PFI_NAME varchar(1000) NOT NULL,
	PFI_IMG_PATH varchar(2000) NOT NULL,
	PFI_SORT int,
	PRIMARY KEY (PFI_NUM)
);


CREATE TABLE PRODUCT_INFO
(
	-- 상품 번호
	PI_NUM int NOT NULL AUTO_INCREMENT COMMENT '상품 번호',
	-- 어떤 사람이 이 상품을 올렸는지
	UI_NUM int NOT NULL COMMENT '어떤 사람이 이 상품을 올렸는지',
	STI_NUM int NOT NULL,
	-- 이름
	PI_NAME varchar(100) NOT NULL COMMENT '이름',
	-- 설명
	PI_DESC varchar(4000) NOT NULL COMMENT '설명',
	-- 가격
	PI_PRICE int NOT NULL COMMENT '가격',
	PRIMARY KEY (PI_NUM)
);


CREATE TABLE RECENT_INFO
(
	RI_NUM int NOT NULL AUTO_INCREMENT,
	-- 회원번호
	UI_NUM int NOT NULL COMMENT '회원번호',
	-- 상품 번호
	PI_NUM int NOT NULL COMMENT '상품 번호',
	RI_VIEWTIME varchar(6) DEFAULT 'DATE_FORMAT(NOW(),''%H%i%s'')',
	PRIMARY KEY (RI_NUM)
);


CREATE TABLE ROLE_INFO
(
	RI_NUM int NOT NULL AUTO_INCREMENT,
	-- ROLE_USER, ROLE_ADMIN, ROLE_ROOT
	RI_CODE varchar(30) DEFAULT 'ROLE_USER' COMMENT 'ROLE_USER, ROLE_ADMIN, ROLE_ROOT',
	RI_NAME varchar(30),
	RI_DESC varchar(200),
	PRIMARY KEY (RI_NUM)
);


CREATE TABLE ROLE_MAP
(
	RM_NUM int NOT NULL AUTO_INCREMENT,
	-- 회원번호
	UI_NUM int NOT NULL COMMENT '회원번호',
	RI_NUM int NOT NULL,
	PRIMARY KEY (RM_NUM)
);


CREATE TABLE SHOPING_CART
(
	SC_NUM int NOT NULL AUTO_INCREMENT,
	-- 회원번호
	UI_NUM int NOT NULL COMMENT '회원번호',
	-- 상품 번호
	PI_NUM int NOT NULL COMMENT '상품 번호',
	SC_AMOUNT int NOT NULL,
	SC_CREDAT varchar(8) DEFAULT 'DATE_FORMAT(NOW(),''%Y%m%d'')',
	PRIMARY KEY (SC_NUM)
);


CREATE TABLE SUB_TYPE_INFO
(
	STI_NUM int NOT NULL AUTO_INCREMENT,
	TI_NUM int NOT NULL,
	STI_CODE varbinary(4) NOT NULL,
	-- 신발, 도구, 공, 등등..
	STI_NAME varchar(3) NOT NULL COMMENT '신발, 도구, 공, 등등..',
	PRIMARY KEY (STI_NUM),
	UNIQUE (STI_CODE)
);


CREATE TABLE TYPE_INFO
(
	TI_NUM int NOT NULL AUTO_INCREMENT,
	-- 야구, 축구, 헬스
	TI_NAME varchar(1000) NOT NULL COMMENT '야구, 축구, 헬스',
	TI_CODE varchar(4) NOT NULL,
	PRIMARY KEY (TI_NUM),
	UNIQUE (TI_NAME),
	UNIQUE (TI_CODE)
);


CREATE TABLE USER_INFO
(
	-- 회원번호
	UI_NUM int NOT NULL AUTO_INCREMENT COMMENT '회원번호',
	-- 회원 이름
	UI_NAME varchar(100) NOT NULL COMMENT '회원 이름',
	-- 회원 아이디
	UI_ID varchar(100) NOT NULL COMMENT '회원 아이디',
	-- 회원 비밀번호
	UI_PWD varchar(100) NOT NULL COMMENT '회원 비밀번호',
	-- 회원 전화번호
	UI_PHONE varchar(11) NOT NULL COMMENT '회원 전화번호',
	-- 회원 생일
	UI_BIRTH varchar(8) NOT NULL COMMENT '회원 생일',
	-- 회원 성별
	UI_GENDER varchar(1) NOT NULL COMMENT '회원 성별',
	-- 유저 이메일 
	UI_EMAIL varchar(100) COMMENT '유저 이메일 ',
	-- 회원생성일
	UI_CREDAT varchar(8) DEFAULT 'DATE_FORMAT(NOW(),''%Y%m%d'')' COMMENT '회원생성일',
	-- 회원 생성시간
	UI_CRETIM varchar(6) DEFAULT 'DATE_FORMAT(NOW(),''%H%i%s'')' COMMENT '회원 생성시간',
	-- 회원 수정일
	UI_LMODAT varchar(8) DEFAULT 'DATE_FORMAT(NOW(),''%Y%m%d'')' COMMENT '회원 수정일',
	-- 회원 수정시간
	UI_LMOTIM varchar(6) DEFAULT 'DATE_FORMAT(NOW(),''%H%i%s'')' COMMENT '회원 수정시간',
	-- 회원 등급
	UI_GRADE varchar(20) COMMENT '회원 등급',
	PRIMARY KEY (UI_NUM),
	UNIQUE (UI_ID)
);



/* Create Foreign Keys */

ALTER TABLE BOARD_FILE_INFO
	ADD FOREIGN KEY (BI_NUM)
	REFERENCES BOARD_INFO (BI_NUM)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE COUPON_INFO
	ADD FOREIGN KEY (CPTI_NUM)
	REFERENCES COUPON_TYPE_INFO (CPTI_NUM)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE COMMENT_INFO
	ADD FOREIGN KEY (ODI_NUM)
	REFERENCES ORDER_DETAIL_INFO (ODI_NUM)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE ORDER_DETAIL_INFO
	ADD FOREIGN KEY (OI_NUM)
	REFERENCES ORDER_INFO (OI_NUM)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE BOARD_INFO
	ADD FOREIGN KEY (PI_NUM)
	REFERENCES PRODUCT_INFO (PI_NUM)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE ORDER_DETAIL_INFO
	ADD FOREIGN KEY (PI_NUM)
	REFERENCES PRODUCT_INFO (PI_NUM)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE PRODUCT_FILE_INFO
	ADD FOREIGN KEY (PI_NUM)
	REFERENCES PRODUCT_INFO (PI_NUM)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE RECENT_INFO
	ADD FOREIGN KEY (PI_NUM)
	REFERENCES PRODUCT_INFO (PI_NUM)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE SHOPING_CART
	ADD FOREIGN KEY (PI_NUM)
	REFERENCES PRODUCT_INFO (PI_NUM)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE ROLE_MAP
	ADD FOREIGN KEY (RI_NUM)
	REFERENCES ROLE_INFO (RI_NUM)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE PRODUCT_INFO
	ADD FOREIGN KEY (STI_NUM)
	REFERENCES SUB_TYPE_INFO (STI_NUM)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE SUB_TYPE_INFO
	ADD FOREIGN KEY (TI_NUM)
	REFERENCES TYPE_INFO (TI_NUM)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE ADDR_INFO
	ADD FOREIGN KEY (UI_NUM)
	REFERENCES USER_INFO (UI_NUM)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE BOARD_INFO
	ADD FOREIGN KEY (UI_NUM)
	REFERENCES USER_INFO (UI_NUM)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE CHAT_TABLE
	ADD FOREIGN KEY (UI_NUM)
	REFERENCES USER_INFO (UI_NUM)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE COMMENT_INFO
	ADD FOREIGN KEY (UI_NUM)
	REFERENCES USER_INFO (UI_NUM)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE COUPON_INFO
	ADD FOREIGN KEY (UI_NUM)
	REFERENCES USER_INFO (UI_NUM)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE ORDER_DETAIL_INFO
	ADD FOREIGN KEY (UI_NUM)
	REFERENCES USER_INFO (UI_NUM)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE ORDER_INFO
	ADD FOREIGN KEY (UI_NUM)
	REFERENCES USER_INFO (UI_NUM)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE PRODUCT_INFO
	ADD FOREIGN KEY (UI_NUM)
	REFERENCES USER_INFO (UI_NUM)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE RECENT_INFO
	ADD FOREIGN KEY (UI_NUM)
	REFERENCES USER_INFO (UI_NUM)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE ROLE_MAP
	ADD FOREIGN KEY (UI_NUM)
	REFERENCES USER_INFO (UI_NUM)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE SHOPING_CART
	ADD FOREIGN KEY (UI_NUM)
	REFERENCES USER_INFO (UI_NUM)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


