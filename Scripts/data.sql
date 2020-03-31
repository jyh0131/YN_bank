use bank;

#insert문
insert into department values
(1,'인사'),
(2,'고객');

insert into employee values
('A001','나인사','부장','HR',6000000,'010-1233-1111','HRid1',password('testforHR1'),1,null),
('A002','정아름','차장','HR',5000000,'010-5840-1111','HRid2',password('testforHR2'),1,null),
('A003','이상원','과장','HR',4000000,'010-1549-1111','HRid3',password('testforHR3'),1,null),
('A004','서지수','대리','HR',3000000,'010-3296-1111','HRid4',password('testforHR4'),1,null),
('A005','박민호','사원','HR',2000000,'010-1597-1111','HRid5',password('testforHR5'),1,null),
('A006','고희연','사원','HR',2000000,'010-6444-1111','HRid6',password('testforHR6'),1,null),
('A007','정윤호','사원','HR',2000000,'010-7423-1111','HR',password('HR'),1,null),
-- 고객팀
('B001','나지점','지점장','AD',10000000,'010-1234-1234','ADid',password('testforAD'),2,null),
('B002','장현서','부지점장','CS',8000000,'010-4444-7767','CSid1',password('testforCS'),2,null),
('B003','박인선','부장','CS',6000000,'010-2992-2222','CSid2',password('testforCS'),2,null),
('B004','황하나','차장','CS',5000000,'010-2222-1111','CSid3',password('testforCS'),2,null),
('B005','현재승','과장','CS',4000000,'010-2282-4848','CSid4',password('testforCS'),2,null),
('B006','황태원','대리','CS',3000000,'010-2902-5959','CS',password('CS'),2,null),
('B007','나고객','사원','CS',2000000,'010-5489-7346','CSid8',password('testforCS'),2,null),
('B008','테스트','지점장','AD',10000000,'010-1234-1234','111',password('111'),2,null),
('B009','아몬드','대리','CS',2000000,'010-1578-5436','CSid9',password('testforCS'),2,null),
('B010','장우주','사원','CS',2000000,'010-1258-8563','CSid10',password('testforCS'),2,null),
('B011','방송국','사원','CS',2000000,'010-6982-5312','CSid11',password('testforCS'),2,null),
('B012','서민지','사원','CS',2000000,'010-5734-1543','CSid12',password('testforCS'),2,null),
('B013','성시현','사원','CS',2000000,'010-9644-4321','CSid13',password('testforCS'),2,null),
('B014','민희영','사원','CS',2000000,'010-4231-3443','CSid14',password('testforCS'),2,null),
('B015','김다린','사원','CS',2000000,'010-3290-6431','CSid15',password('testforCS'),2,null),
('B016','최지원','사원','CS',2000000,'010-7323-4543','CSid16',password('testforCS'),2,null),
('B017','연소희','사원','CS',2000000,'010-4443-7345','CSid17',password('testforCS'),2,null),
('B018','주경미','사원','CS',2000000,'010-6424-3424','CSid18',password('testforCS'),2,null),
('B019','서연정','사원','CS',2000000,'010-3290-7134','CSid19',password('testforCS'),2,null),
('B020','차은우','사원','CS',2000000,'010-5834-8555','CSid20',password('testforCS'),2,null),
('B021','배소경','사원','CS',2000000,'010-3290-3343','CSid21',password('testforCS'),2,null),
('B022','김천경','사원','CS',2000000,'010-1385-4577','CSid22',password('testforCS'),2,null);

insert into customer values 
("C001", "김서형", "D", 1, "서울시 강남구 논현동", "010-7598-4533"), 
("C002", "김혜수", "D", 1, "서울시 강남구 역삼동", "010-9325-5412"),
("C003", "한지민", "D", 1, "서울시 강남구 청담동", "010-6325-5224"),
("C004", "장나라", "D", 1, "서울시 송파구 잠실동", "010-3257-6437"),
("C005", "공효진", "D", 1, "인천광역시 남구 주안동", "010-2578-3279"),
("C006", "김향기", "P", 2, "경기도 수원시 권선구 세류동", "010-7722-3140"),
("C007", "강소라", "P", 2, "경기도 용인시 처인구 마평동", "010-1325-0314"),
("C008", "한효주", "P", 2, "전주시 완산구 삼천동", "010-5972-2310"),
("C009", "박보영", "P", 2, "광주광역시 서구 치평동", "010-3652-1234"),
("C010", "한가인", "G", 3, "광주광역시 광산구 우산동", "010-7701-4322"),
("C011", "배두나", "G", 3, "부산광역시 동래구 안락동", "010-3265-1114"),
("C012", "김설현", "G", 3, "부산광역시 금정구 서동", "010-0311-1773"),
("C013", "박예진", "G", 3, "부산광역시 금정구 금사동", "010-8990-9314"),
("C014", "오연수", "G", 3, "부산광역시 부산진구 연지동", "010-5441-6593"),
("C015", "차은우", "S", 4, "부산광역시 남구 용당동", "010-6265-7891"),
("C016", "박지민", "S", 4, "부산광역시 영도구 동삼동", "010-6890-9835"),
("C017", "전정국", "S", 4, "제주시 애월읍", "010-3200-7925"),
("C018", "민윤기", "S", 4, "대구시 수성구 황금동", "010-3210-7900"),
("C019", "김태형", "S", 4, "대구시 수성구 범어동", "010-6040-1018"),
("C020", "정윤호", "B", 5, "대구시 수성구 만촌동", "010-4550-1766"),
("C021", "최창민", "B", 5, "대구시 달서구 성당동", "010-3468-7772"),
("C022", "한예슬", "B", 5, "대구시 서구 내당동", "010-1358-3165"),
("C023", "임예진", "B", 5, "대구시 중구 삼덕동", "010-3050-4700"),
("C024", "추자현", "B", 5, "대구시 달서구 두류동", "010-7894-1240"),
("C025", "손가인", "D", 1, "광주 광역시 광산구 신창동", "010-4538-1125"),
("C026", "문별이", "G", 3, "전주시 덕진구 진북동", "010-4211-0004"),
("C027", "김용선", "G", 3, "전주시 완산구 서신동", "010-3389-4710"),
("C028", "김고은", "S", 4, "울산광역시 남구 신정동", "010-3758-8588"),
("C029", "차예련", "S", 4, "울산광역시 남구 신정1동", "010-3334-0089"),
("C030", "김정은", "S", 4, "울산광역시 북구 효문동", "010-9797-1131");

insert into plan values("A001", "AA001", "슈퍼정기예금", "가입자 맞춤형 다기능 정기예금", "V"), -- VIP / 예금
					   ("A002", "AB001", "주거래 DREAM 적금", "거래에 따라 우대하는 주거래 고객 맞춤형 적금", "V"), -- VIP/적금
					   ("A003", "AC001", "행복 사업 통장", "사업 첫 시작을 위한 마이너스 통장", "V"), -- VIP/마이너스통장
					   ("B001", "BA001", "S20 체크카드", "스무살의 첫 시작", "V"), -- VIP/체크카드
					   ("B002", "BB001", "Deep Dream Platinum", "주거래 고객을 위한 플래티넘 신용카드", "V"), -- VIP/신용카드
					   ("C001", "CA001", "전세자금 대출", "주택에 전세로 입주하는 고객을 위한 일반대출", "V"), -- VIP/일반대출
					   ("C002", "CB001", "프리미엄 론", "신용 우량 회원을 위한 간편한 대출", "V"), -- VIP/신용대출
					   ("C003", "CC001", "스피드론", "서류없는 빠른 카드 대출", "V"), -- VIP/카드대출
					   ("A004", "AA002", "e편한 정기예금", "만기일을 자유롭게 설계하는 예금", "N"), -- 일반/예금
					   ("A005", "AB002", "첫급여 DREAM 적금", "첫 급여 이체 적금", "N"), -- 일반/적금
					   ("A006", "AC002", "YN 샐러리론", "직장인을 위한 우대 마이너스 통장", "N"), -- 일반/마이너스통장
					   ("B003", "BA002", "YNx카카오 체크카드", "대학생을 위한 카카오페이와 연동되는 체크카드", "N"), -- 일반/체크카드
					   ("B004", "BB002", "디데이 신용카드", "디데이마다 제휴사 할인쿠폰이 제공되는 신용카드", "N"), -- 일반/신용카드
					   ("C004", "CA002", "패밀리 대출", "YN은행 임직원을 위한 무서류 일반대출", "N"), -- 일반/일반대출
					   ("C005", "CB002", "아파트 소유자 대출", "본인명의 아파트 소유자를 위한 신용 대출", "N"), -- 일반/신용대출
					   ("C006", "CC002", "YN Go Anywhere", "refresh 여행을 위한 빠른 카드 대출", "N"); -- 일반/카드대출						   			   				   

insert into bankbook values
('293133-11-000001','C001','A001',now(),0.15,0,'B007',1),
('293133-12-000002','C001','A002',now(),0.10,0,'B007',0),
('293133-13-000003','C001','A003',now(),0.01,0,'B007',0),
('293133-11-000004','C002','A001',now(),0.15,0,'B007',1),
('293133-12-000005','C002','A002',now(),0.10,0,'B007',0),
('293133-13-000006','C002','A003',now(),0.01,0,'B008',0);

insert into card values
('2931331000000010','C001','B001',111,now(),null,(select accountbalance from bankbook where custcode = 'C001' and accountnum = '293133-11-000001'),'B008','293133-11-000001'),
('2931332000000020','C001','B002',222,now(),10000000,null,'B008',null),
('2931331000000030','C002','B001',333,now(),null,(select accountbalance from bankbook where custcode = 'C002' and accountnum = '293133-11-000004'),'B007','293133-11-000004'),
('2931332000000040','C002','B002',444,now(),10000000,null,'B007',null),
('2931332000000050','C003','B002',555,now(),10000000,null,'B001',null),
('2931332000000060','C004','B002',666,now(),10000000,null,'B001',null),
('2931332000000070','C005','B002',777,now(),10000000,null,'B002',null);

insert into loan values
('293133-11-000001','C001','C001',now(),0.05,100000000,'B007'),
('293133-12-000002','C001','C002',now(),0.06,100000000,'B007'),
('293133-13-000003','C001','C003',now(),0.07,100000000,'B007'),
('293133-11-000004','C002','C001',now(),0.05,100000000,'B008'),
('293133-12-000005','C002','C002',now(),0.06,100000000,'B008'),
('293133-13-000006','C002','C003',now(),0.07,100000000,'B008'),
('293133-11-000007','C003','C001',now(),0.05,100000000,'B008'),
('293133-12-000008','C003','C002',now(),0.06,100000000,'B008'),
('293133-13-000009','C003','C003',now(),0.07,100000000,'B008');

insert into performance values
('A001','B007','C001'),('A002','B007','C001'),('A003','B007','C001'),('A001','B007','C002'),('A002','B007','C002'),
('A003','B008','C002'),('B001','B008','C001'),('B002','B008','C001'),('B001','B007','C002'),('B002','B007','C002'),
('C001','B007','C001'),('C002','B007','C001'),('C003','B007','C001'),('C001','B008','C002'),('C002','B008','C002'),
('C003','B008','C002'),('C001','B008','C003'),('C002','B008','C003'),('C003','B008','C003'),('C002','A001','C002'),
('B002','B001','C003'),('B002','B001','C004');


#통장 테이블 
#statistic table 생성
drop view if exists vipTable;  
create view vipTable as select custCode as vip from customer c where `custRank`="D";

#우수사원 패널
create view ranking as select e.empCode, e.empName, e.empTitle, count(if(p.custCode=null,0,p.custCode)) as perf , if(count(if(p.custCode=null,0,p.custCode))>=10,e.`empSalary`*0.1,0) as bonus, if(p.`planCode`='A001',vip,null) as vip
from employee e left join performance p on e.`empCode` = p.`empCode`  left join customer c on p.`custCode`=c.`custCode` left join viptable v on p.`custCode`= v.vip
group by e.`empCode`;

#예금계좌 정보
create view bankbook_deposit_connect_to_card_info as select accountnum,custcode,connectchk from bankbook where substring(accountnum,9,1)='1' and connectchk = 0;

insert into notice(subject,writer,write_date,content) 
values("코로나19 다 함께 이겨냅시다!","작성자",now(),"YN BANK 직원 어려분 코로나 19 때문에 은행이 부도 위기에 처했지만, 여러분의 노고만이 회사를 살리는 유일한 길입니다. 저희 은행은 절대 직원 여러분을 버리지 않습니다. 다들 심기일전하여 코로나 19를 극복하고, YN BANK를 전세계 1위 은행으로 발돋움하게 노력합시다");


drop trigger if exists deleted_emp_trigger;
delimiter $
 create trigger deleted_emp_trigger
 before delete on employee
 for each row 
 begin 
	 insert into deleted_employee (`empCode` ,`empName` ,`empTitle` ,`empTel` ,`deptNo` )values(old.empCode, old.empName, old.empTitle, old.empTel, old.deptNo);
 end $
delimiter ;

-- 입금/출금 기능 
drop trigger if exists tri_after_update_BankBook;
delimiter $$
create trigger tri_after_update_BankBook
  	after update on BankBook
   for each row 
   begin
	  if(old.accountBalance < new.accountBalance) then
     	 insert into cust_DW_audit values
      		("입금", 
      		(select custName from customer where custCode = new.custCode), 
      		new.accountNum,
      		(new.accountBalance - old.accountBalance),
      		new.accountBalance,
      		Now()
      		);
      else
     	 insert into cust_DW_audit values
      		("출금", 
      		(select custName from customer where custCode = new.custCode), 
      		new.accountNum,
      		(old.accountBalance - new.accountBalance),
      		new.accountBalance,
      		Now()
      		);
      end if;
   end $$
delimiter ;


-- 통계 조회를 위해서 미리 넣어두는 데이터
insert into cust_DW_audit values("입금", "김서형", "293133-11-000001", 100, 100, now());
insert into cust_DW_audit values("출금", "김서형", "293133-11-000001", 100, 0, now());

#bankbook -- card 
#카드 잔액->통장 잔액
drop procedure if exists change_bankbalance;
delimiter !
create procedure change_bankbalance(
	in in_custcode varchar(4),
	in in_cardbalance bigint,
	in in_accountnum char(16)
)
begin
	update bankbook set accountbalance = in_cardbalance where custcode = in_custcode and accountnum = in_accountnum;
end!
delimiter ;

## 통장잔액 -> 카드 잔액
drop procedure if exists change_cardbalance;

delimiter !
create procedure change_cardbalance(
	in in_custname varchar(5),
	in in_accountbalance bigint,
	in in_accountnum char(16)
)
begin
	update card set cardbalance = in_accountbalance where custcode = (select custcode from customer where custname = in_custname) and accountnum = in_accountnum;
end!
delimiter ;

##카드 수정이되면 카드 거래실적 (통계)
drop trigger if exists tri_update_card;
delimiter $
create trigger tri_update_card
after update on card
for each row 
begin 
	insert into cardinfo values((select custname from customer where custcode = new.custcode),new.cardnum,now());
end $
delimiter ;

## 통장이 수정되면  통장 정보 테이블로  통장 거래실적 (통계)
drop trigger if exists tri_update_bankbook;
delimiter $
create trigger tri_update_bankbook
after update on bankbook
for each row 
begin 
	insert into bankbookInfo values((select custname from customer where custcode = new.custcode),new.accountnum,now());
end $
delimiter ;

##휴면 계좌 전환
drop procedure if exists make_dormant;

delimiter !
create procedure make_dormant(
	in p_custname char(5),
	in p_planname char(20)
)
begin
	declare d_accountnum char(16);
	declare d_custname char(5);
	set d_accountnum = (select replace(accountnum,'-1','-2') from bankbook where custcode = (select custcode from customer where custname = p_custname) and accountPlanCode = (select planCode from plan where planname = p_planname));
	set d_custname = p_custname;
	insert into changebankbookdormantinfo values(d_custname,d_accountnum,now());
end!
delimiter ;

## 해지계좌
drop procedure if exists make_termination;

delimiter !
create procedure make_termination(
	in p_custname char(5),
	in p_planname char(20)
)
begin
	declare d_accountnum char(16);
	declare d_custname char(5);
	set d_accountnum = (select replace(accountnum,'-1','-3') from bankbook where custcode = (select custcode from customer where custname = p_custname) and accountPlanCode = (select planCode from plan where planname = p_planname));
	set d_custname = p_custname;
	insert into changebankbookterminationinfo values(d_custname,d_accountnum,now());
end!
delimiter ;

## 공지사항 삭제했을 때 번호 리셋
drop procedure if exists reset_autoincrement_notice

delimiter !
create procedure reset_autoincrement_notice()
begin
	ALTER TABLE notice AUTO_INCREMENT=1;
	SET @COUNT = 0;
	UPDATE notice SET no = @COUNT:=@COUNT+1;
end!
delimiter ;

## 통장 추가했을 때 실적 테이블
drop trigger if exists tri_insert_bankbook_performance;
delimiter $
create trigger tri_insert_bankbook_performance
after insert on bankbook
for each row 
begin 
	insert into performance values(new.accountplancode,new.empcode,new.custcode);
end $
delimiter ;

##통장 삭제될 때 실적 테이블에도 삭제
drop trigger if exists tri_delete_bankbook_performance;
delimiter $
create trigger tri_delete_bankbook_performance
before delete on bankbook
for each row 
begin 
	delete from performance where plancode = old.accountplancode and empcode = old.empcode and custcode = old.custcode;
end $
delimiter ;

##카드 추가할 때 실적 테이블 추가 
drop trigger if exists tri_insert_card_performance;
delimiter $
create trigger tri_insert_card_performance
after insert on card
for each row 
begin 
	insert into performance values(new.plancode,new.empcode,new.custcode);
end $
delimiter ;

##카드 삭제할 때 실적 테이블에서 삭제 
drop trigger if exists tri_delete_card_performance;
delimiter $
create trigger tri_delete_card_performance
before delete on card
for each row 
begin 
	delete from performance where plancode = old.plancode and empcode = old.empcode and custcode = old.custcode;
end $
delimiter ;

##대출 추가할 때 실적 테이블 추가 
drop trigger if exists tri_insert_loan_performance;
delimiter $
create trigger tri_insert_loan_performance
after insert on loan
for each row 
begin 
	insert into performance values(new.loanplancode,new.empcode,new.custcode);
end $
delimiter ;

##대출 삭제할 때 실적 테이블에서 삭제 
drop trigger if exists tri_delete_loan_performance;
delimiter $
create trigger tri_delete_loan_performance
before delete on loan
for each row 
begin 
	delete from performance where plancode = old.loanplancode and empcode = old.empcode and custcode = old.custcode;
end $
delimiter ;