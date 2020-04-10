-- 내 스키마
DROP SCHEMA IF EXISTS bank;

-- 내 스키마
CREATE SCHEMA bank;

-- 통장
CREATE TABLE bank.BankBook (
	accountNum         char(16) NOT NULL COMMENT '계좌번호', -- 계좌번호
	custCode           char(4)  NOT NULL COMMENT '고객코드', -- 고객코드
	accountPlanCode    char(4)  NOT NULL COMMENT '통장상품코드', -- 통장상품코드
	accountOpenDate    DATETIME NOT NULL COMMENT '계좌개설일', -- 계좌개설일
	accountInterest    FLOAT    NOT NULL COMMENT '이자율', -- 이자율
	accountBalance     BIGINT   NOT NULL COMMENT '잔액', -- 잔액
	accountDormant     TINYINT  NULL     COMMENT '휴면여부', -- 휴면여부
	accountTermination TINYINT  NULL     COMMENT '해지여부', -- 해지여부
	empCode            char(4)  NOT NULL COMMENT '사원코드', -- 사원코드
	connectChk         TINYINT  NULL     COMMENT '연결여부' -- 연결여부
)
COMMENT '통장';

-- 통장
ALTER TABLE bank.BankBook
	ADD CONSTRAINT PK_BankBook -- 통장 기본키
		PRIMARY KEY (
			accountNum -- 계좌번호
		);

-- 사원
CREATE TABLE bank.Employee (
	empCode   char(4)     NOT NULL COMMENT '사원코드', -- 사원코드
	empName   VARCHAR(20) NULL     COMMENT '사원이름', -- 사원이름
	empTitle  VARCHAR(10) NULL     COMMENT '사원직책', -- 사원직책
	empAuth   char(2)     NULL     COMMENT '사원권한', -- 사원권한
	empSalary INTEGER     NULL     COMMENT '사원월급', -- 사원월급
	empTel    char(13)    NULL     COMMENT '사원연락처', -- 사원연락처
	empId     varchar(12) NULL     COMMENT '사원아이디', -- 사원아이디
	empPwd    varchar(41) NULL     COMMENT '사원비밀번호', -- 사원비밀번호
	deptNo    INTEGER     NOT NULL COMMENT '부서번호', -- 부서번호
	pic       LONGBLOB    NULL     COMMENT '사원사진', -- 사원사진
	empRetire TINYINT     NULL     COMMENT '퇴사여부' -- 퇴사여부
)
COMMENT '사원';

-- 사원
ALTER TABLE bank.Employee
	ADD CONSTRAINT PK_Employee -- 사원 기본키
		PRIMARY KEY (
			empCode -- 사원코드
		);

-- 부서
CREATE TABLE bank.Department (
	deptNo   INTEGER     NOT NULL COMMENT '부서번호', -- 부서번호
	deptName VARCHAR(10) NULL     COMMENT '부서이름' -- 부서이름
)
COMMENT '부서';

-- 부서
ALTER TABLE bank.Department
	ADD CONSTRAINT PK_Department -- 부서 기본키
		PRIMARY KEY (
			deptNo -- 부서번호
		);

-- 고객
CREATE TABLE bank.Customer (
	custCode   char(4)     NOT NULL COMMENT '고객코드', -- 고객코드
	custName   VARCHAR(20) NULL     COMMENT '고객이름', -- 고객이름
	custCredit INTEGER(1)  NULL     COMMENT '고객신용등급', -- 고객신용등급
	custAddr   varchar(50) NULL     COMMENT '고객주소', -- 고객주소
	custTel    char(13)    NULL     COMMENT '고객연락처', -- 고객연락처
	custDiv    TINYINT     NULL     COMMENT '고객구분' -- 고객구분
)
COMMENT '고객';

-- 고객
ALTER TABLE bank.Customer
	ADD CONSTRAINT PK_Customer -- 고객 기본키
		PRIMARY KEY (
			custCode -- 고객코드
		);

-- 고객상품
CREATE TABLE bank.Plan (
	planCode   char(4)      NOT NULL COMMENT '상품코드', -- 상품코드
	planDetail char(5)      NOT NULL COMMENT '상품세부코드', -- 상품세부코드
	planName   VARCHAR(30)  NULL     COMMENT '상품이름', -- 상품이름
	planDesc   varchar(100) NULL     COMMENT '상품설명', -- 상품설명
	planDiv    char(2)      NULL     COMMENT '상품구분코드' -- 상품구분코드
)
COMMENT '고객상품';

-- 고객상품
ALTER TABLE bank.Plan
	ADD CONSTRAINT PK_Plan -- 고객상품 기본키
		PRIMARY KEY (
			planCode -- 상품코드
		);

-- 대출
CREATE TABLE bank.Loan (
	loanAccountNum char(16) NOT NULL COMMENT '대출계좌번호', -- 대출계좌번호
	custCode       char(4)  NOT NULL COMMENT '고객코드', -- 고객코드
	loanPlanCode   char(4)  NOT NULL COMMENT '대출상품코드', -- 대출상품코드
	loanStartDate  DATETIME NULL     COMMENT '대출시작날짜', -- 대출시작날짜
	loanDelayDate  DATETIME NULL     COMMENT '대출거치일자', -- 대출거치일자
	loanExpireDate DATETIME NULL     COMMENT '대출만료일자', -- 대출만료일자
	loanMethod     char(1)  NULL     COMMENT '대출상환방식', -- 대출상환방식
	loanInterest   FLOAT    NULL     COMMENT '대출이자율', -- 대출이자율
	loanBalance    BIGINT   NULL     COMMENT '대출잔액', -- 대출잔액
	loanExtended   TINYINT  NULL     COMMENT '대출연장여부', -- 대출연장여부
	loanExpired    TINYINT  NULL     COMMENT '대출완료여부', -- 대출완료여부
	empCode        char(4)  NULL     COMMENT '사원코드' -- 사원코드
)
COMMENT '대출';

-- 대출
ALTER TABLE bank.Loan
	ADD CONSTRAINT PK_Loan -- 대출 기본키
		PRIMARY KEY (
			loanAccountNum -- 대출계좌번호
		);

-- 카드
CREATE TABLE bank.Card (
	cardNum       char(16) NOT NULL COMMENT '카드번호', -- 카드번호
	custCode      char(4)  NOT NULL COMMENT '고객코드', -- 고객코드
	planCode      char(4)  NOT NULL COMMENT '상품코드', -- 상품코드
	cardSecuCode  char(3)  NOT NULL COMMENT '카드보안코드', -- 카드보안코드
	cardIssueDate DATETIME NULL     COMMENT '카드발급일', -- 카드발급일
	cardLimit     INTEGER  NULL     COMMENT '카드한도', -- 카드한도
	cardBalance   BIGINT   NULL     COMMENT '카드잔액', -- 카드잔액
	empCode       char(4)  NULL     COMMENT '사원코드', -- 사원코드
	accountNum    char(16) NULL     COMMENT '계좌번호' -- 계좌번호
)
COMMENT '카드';

-- 카드
ALTER TABLE bank.Card
	ADD CONSTRAINT PK_Card -- 카드 기본키
		PRIMARY KEY (
			cardNum -- 카드번호
		);

-- 실적
CREATE TABLE bank.Performance (
	planCode char(4) NOT NULL COMMENT '상품코드', -- 상품코드
	empCode  char(4) NOT NULL COMMENT '사원코드', -- 사원코드
	custCode char(4) NOT NULL COMMENT '고객코드' -- 고객코드
)
COMMENT '실적';

-- 실적
ALTER TABLE bank.Performance
	ADD CONSTRAINT PK_Performance -- 실적 기본키
		PRIMARY KEY (
			planCode, -- 상품코드
			empCode,  -- 사원코드
			custCode  -- 고객코드
		);

-- 입출금
CREATE TABLE bank.cust_DW_audit (
	dw               varchar(5)  NULL COMMENT '입출금', -- 입출금
	custname         VARCHAR(20) NULL COMMENT '고객이름', -- 고객이름
	accountnum       char(16)    NULL COMMENT '계좌번호', -- 계좌번호
	amount           int(20)     NULL COMMENT '거래금액', -- 거래금액
	accountbalance   BIGINT      NULL COMMENT '계좌잔액', -- 계좌잔액
	accountTransDate DATETIME    NULL COMMENT '거래일자' -- 거래일자
)
COMMENT '입출금';

-- 카드 정보
CREATE TABLE bank.cardInfo (
	custname    VARCHAR(20) NULL COMMENT '고객이름', -- 고객이름
	cardnum     char(16)    NULL COMMENT '카드번호', -- 카드번호
	transDate   DATETIME    NULL COMMENT '거래일자', -- 거래일자
	cardBalance BIGINT      NULL COMMENT '카드잔액' -- 카드잔액
)
COMMENT '카드 정보';

-- 통장정보
CREATE TABLE bank.bankbookinfo (
	custname   VARCHAR(20) NULL COMMENT '고객이름', -- 고객이름
	accountnum char(16)    NULL COMMENT '계좌번호', -- 계좌번호
	transdate  DATETIME    NULL COMMENT '거래일자' -- 거래일자
)
COMMENT '통장정보';

-- 공지사항
CREATE TABLE bank.notice (
	no         INTEGER     NOT NULL COMMENT '번호', -- 번호
	subject    varchar(30) NULL     COMMENT '제목', -- 제목
	writer     VARCHAR(20) NULL     COMMENT '작성자', -- 작성자
	write_date DATETIME    NULL     COMMENT '작성일', -- 작성일
	content    TEXT        NULL     COMMENT '내용' -- 내용
)
COMMENT '공지사항';

-- 공지사항
ALTER TABLE bank.notice
	ADD CONSTRAINT PK_notice -- 공지사항 기본키
		PRIMARY KEY (
			no -- 번호
		);

ALTER TABLE bank.notice
	MODIFY COLUMN no INTEGER NOT NULL AUTO_INCREMENT COMMENT '번호';

-- 상환
CREATE TABLE bank.Repayment (
	loanAccountNum char(16) NULL COMMENT '대출계좌번호', -- 대출계좌번호
	custCode       char(4)  NULL COMMENT '고객코드', -- 고객코드
	loanPlanCode   char(4)  NULL COMMENT '대출상품코드', -- 대출상품코드
	loanStartDate  DATETIME NULL COMMENT '대출시작날짜', -- 대출시작날짜
	loanDelayDate  DATETIME NULL COMMENT '대출거치일자', -- 대출거치일자
	loanExpireDate DATETIME NULL COMMENT '대출만료일자', -- 대출만료일자
	loanMethod     char(1)  NULL COMMENT '대출상환방식', -- 대출상환방식
	loanRound      INTEGER  NULL COMMENT '대출상환회차', -- 대출상환회차
	loanInterest   FLOAT    NULL COMMENT '대출이자율', -- 대출이자율
	loanBalance    BIGINT   NULL COMMENT '대출잔액', -- 대출잔액
	loanRepayment  INTEGER  NULL COMMENT '상환금액' -- 상환금액
)
COMMENT '상환';

-- 타행송금정보
CREATE TABLE bank.transferringBankBook (
	accountnum char(16)    NULL COMMENT '계좌번호', -- 계좌번호
	bankcode   char(3)     NULL COMMENT '은행코드', -- 은행코드
	bankname   varchar(20) NULL COMMENT '은행명', -- 은행명
	custname   VARCHAR(20) NULL COMMENT '고객명', -- 고객명
	balance    BIGINT      NULL COMMENT '잔액' -- 잔액
)
COMMENT '타행송금정보';

-- 통장
ALTER TABLE bank.BankBook
	ADD CONSTRAINT FK_Customer_TO_BankBook -- 고객 -> 통장
		FOREIGN KEY (
			custCode -- 고객코드
		)
		REFERENCES bank.Customer ( -- 고객
			custCode -- 고객코드
		);

-- 통장
ALTER TABLE bank.BankBook
	ADD CONSTRAINT FK_Plan_TO_BankBook -- 고객상품 -> 통장
		FOREIGN KEY (
			accountPlanCode -- 통장상품코드
		)
		REFERENCES bank.Plan ( -- 고객상품
			planCode -- 상품코드
		);

-- 통장
ALTER TABLE bank.BankBook
	ADD CONSTRAINT FK_Employee_TO_BankBook -- 사원 -> 통장
		FOREIGN KEY (
			empCode -- 사원코드
		)
		REFERENCES bank.Employee ( -- 사원
			empCode -- 사원코드
		);

-- 사원
ALTER TABLE bank.Employee
	ADD CONSTRAINT FK_Department_TO_Employee -- 부서 -> 사원
		FOREIGN KEY (
			deptNo -- 부서번호
		)
		REFERENCES bank.Department ( -- 부서
			deptNo -- 부서번호
		);

-- 대출
ALTER TABLE bank.Loan
	ADD CONSTRAINT FK_Customer_TO_Loan -- 고객 -> 대출
		FOREIGN KEY (
			custCode -- 고객코드
		)
		REFERENCES bank.Customer ( -- 고객
			custCode -- 고객코드
		);

-- 대출
ALTER TABLE bank.Loan
	ADD CONSTRAINT FK_Plan_TO_Loan -- 고객상품 -> 대출
		FOREIGN KEY (
			loanPlanCode -- 대출상품코드
		)
		REFERENCES bank.Plan ( -- 고객상품
			planCode -- 상품코드
		);

-- 대출
ALTER TABLE bank.Loan
	ADD CONSTRAINT FK_Employee_TO_Loan -- 사원 -> 대출
		FOREIGN KEY (
			empCode -- 사원코드
		)
		REFERENCES bank.Employee ( -- 사원
			empCode -- 사원코드
		);

-- 카드
ALTER TABLE bank.Card
	ADD CONSTRAINT FK_Customer_TO_Card -- 고객 -> 카드
		FOREIGN KEY (
			custCode -- 고객코드
		)
		REFERENCES bank.Customer ( -- 고객
			custCode -- 고객코드
		);

-- 카드
ALTER TABLE bank.Card
	ADD CONSTRAINT FK_Plan_TO_Card -- 고객상품 -> 카드
		FOREIGN KEY (
			planCode -- 상품코드
		)
		REFERENCES bank.Plan ( -- 고객상품
			planCode -- 상품코드
		);

-- 카드
ALTER TABLE bank.Card
	ADD CONSTRAINT FK_Employee_TO_Card -- 사원 -> 카드
		FOREIGN KEY (
			empCode -- 사원코드
		)
		REFERENCES bank.Employee ( -- 사원
			empCode -- 사원코드
		);

-- 카드
ALTER TABLE bank.Card
	ADD CONSTRAINT FK_BankBook_TO_Card -- 통장 -> 카드
		FOREIGN KEY (
			accountNum -- 계좌번호
		)
		REFERENCES bank.BankBook ( -- 통장
			accountNum -- 계좌번호
		);

-- 실적
ALTER TABLE bank.Performance
	ADD CONSTRAINT FK_Customer_TO_Performance -- 고객 -> 실적
		FOREIGN KEY (
			custCode -- 고객코드
		)
		REFERENCES bank.Customer ( -- 고객
			custCode -- 고객코드
		);

-- 실적
ALTER TABLE bank.Performance
	ADD CONSTRAINT FK_Employee_TO_Performance -- 사원 -> 실적
		FOREIGN KEY (
			empCode -- 사원코드
		)
		REFERENCES bank.Employee ( -- 사원
			empCode -- 사원코드
		);

-- 실적
ALTER TABLE bank.Performance
	ADD CONSTRAINT FK_Plan_TO_Performance -- 고객상품 -> 실적
		FOREIGN KEY (
			planCode -- 상품코드
		)
		REFERENCES bank.Plan ( -- 고객상품
			planCode -- 상품코드
		);