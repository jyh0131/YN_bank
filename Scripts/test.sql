use bank;
#사원 - 장현서

-- 노티스 
select * from notice n ;

-- 페이징 테스트
select dw, custname, accountnum, amount, accountbalance, accountTransDate from cust_dw_audit order by accountTransDate desc limit 0,10;
select c.custCode, c.custName, c.custCredit, accountNum, accountBalance, c.custDiv from customer c join bankbook b on c.custCode = b.custCode where substr(b.accountNum, 8,2) = "11" or "12" or "13" limit 0,8;

-- 송금 구현 위한테스트
select * from bankbook b ;
select c.custCode, c.custName, c.custCredit, accountNum, accountBalance, c.custDiv from customer c join bankbook b on c.custCode = b.custCode where c.custName like '%김%' and substr(accountNum, 8,2) = '11';
select b.accountNum, b.accountBalance, c.custCode,c.custName,p.planCode,p.planName from bankbook b left join customer c on b.custCode = c.custCode left join plan p on b.accountPlanCode = p.planCode where b.accountNum ='293133-11-000001';
select c.custCode, c.custName, c.custCredit, accountNum, accountBalance, c.custDiv from customer c join bankbook b on c.custCode = b.custCode where substr(b.accountNum, 8,2) = 11;
update bankbook set accountBalance = accountBalance+100 where accountNum ='293133-11-000001';
select c.custCode, c.custName, c.custCredit, accountNum, accountBalance, c.custDiv from customer c join bankbook b on c.custCode = b.custCode where c.custCode like '%C%';
desc transferringBankBook;
select * from transferringbankbook ;
select * from plan p ;
select dw, custname, accountnum, amount, accountbalance, accountTransDate from cust_dw_audit order by accountTransDate desc;
insert into transferringbankbook values
('265-13-021846','031','대구은행','연미주(그릇계모임)',100000),
('265-13-021846','011','농협','도연우',1000),
('265-13-021846','004','국민은행','정수진',2000000),
('265-13-021846','020','우리은행','마동성',100000000),
('265-13-021846','071','우체국','도하성',45000),
('010-4334-4321','090','카카오뱅크','성진우',1900000);

update transferringBankBook set balance = (balance+2) where accountnum ='265-13-021846' and bankcode='031';

select accountnum, bankcode, bankname, custname, balance from transferringbankbook where accountnum ='265-13-021846' and bankcode='031';
select * from employee e ;
select  * from performance p ;
select * from notice order by no desc;
select * from notice n2 ;
delete from employee where empCode ="B022";
select * from customer;
delete from customer where custCode ="C030";

select * from deleted_employee de ;
delete from employee where empCode= 'B021';
update employee set emppwd = 111 where `empName` ='test';

select e.empCode, e.empName, e.empTitle, count(if(p.custCode=null,0,p.custCode)) as perf , if(count(if(p.custCode=null,0,p.custCode))>=10,e.`empSalary`*0.1,0) as bonus, if(pl.`planDiv` ='V',vip,null) as vip, d.deptName
			from employee e left join performance p on e.`empCode` = p.`empCode`  left join customer c on p.`custCode`=c.`custCode` left join viptable v on p.`custCode`= v.vip left join department d on e.`deptNo` = d.`deptNo` left join plan pl on pl.`planCode` = p.`planCode`
			where d.deptName ='고객' group by e.`empCode`;

select  empCode, empName, empTitle, empAuth, empSalary, empTel, empId, empPwd, d.deptName, d.deptNo  from employee e left join department d on e.deptNo = d.deptNo where d.deptName='인사';
select  empCode, empName, empTitle, empAuth, empSalary, empTel, empId, empPwd, d.deptName, d.deptNo from employee e left join department d on e.deptNo = d.deptNo  where empName like '%장%';
select e.empCode, e.empName, e.empTitle, count(if(p.custCode=null,0,p.custCode)) as perf , if(count(if(p.custCode=null,0,p.custCode))>=10,e.`empSalary`*0.1,0) as bonus, if(p.`planCode`='A001',vip,null) as vip 
		from employee e left join performance p on e.`empCode` = p.`empCode`  left join customer c on p.`custCode`=c.`custCode` left join viptable v on p.`custCode`= v.vip
				where e.empName like '%황%' group by e.`empCode`;
			
select e.empCode, e.empName, e.empTitle, count(if(p.custCode=null,0,p.custCode)) as perf , if(count(if(p.custCode=null,0,p.custCode))>=10,e.`empSalary`*0.1,0) as bonus, if(pl.`planDiv` ='V',vip,null) as vip, d.deptName 
		from employee e left join performance p on e.`empCode` = p.`empCode`  left join customer c on p.`custCode`=c.`custCode` left join viptable v on p.`custCode`= v.vip left join department d on e.`deptNo` = d.`deptNo` 
		left join plan pl on pl.`planCode` = p.`planCode` where d.deptName ='고객' group by e.`empCode`;			

select * from employee e2 ;
select * from employee where empcode = 'B020';
select  empCode, empName, empTitle, empAuth, empSalary, empTel, empId, empPwd, d.deptName, d.deptNo, pic 
from employee e left join department d on e.deptNo = d.deptNo
where empCode='B020';
select empCode, empName, empTitle, empAuth, empSalary, empTel, empId, empPwd, d.deptName, d.deptNo, pic from employee e left join department d on e.deptNo = d.deptNo where empCode='B020';
-- 전체직원수
select count(*) from bank.employee;  -- 3출력
-- 부서별 직원수
select count(*) from bank.employee where deptNo =1; -- 1명
select count(*) from bank.employee where deptNo =2; -- 2명
-- 직급별 직원수(등급 같이 표시)
select concat(count(*),'명(',`empTitle`,')') as '직급별사원수(직책)' from bank.employee 
  group by `empTitle`;
 
 select count(`custCode`) , `empCode` , 
  from performance p
  group by `empCode`;
 
select * from viptable v ;
select * from ranking r ;
 
-- 사원업무 조회에서 사용 //건수는 10건 이상 되어야 보너스 발생 
select e.empCode, e.empName, e.empTitle, count(if(p.custCode=null,0,p.custCode)) as perf , if(count(if(p.custCode=null,0,p.custCode))>=10,e.`empSalary`*0.1,0) as bonus, pl.`planDetail` as pCode, pl.`planName` as pName
from employee e left join performance p on e.`empCode` = p.`empCode`  left join customer c on p.`custCode`=c.`custCode` left join viptable v on p.`custCode`= v.vip left join plan pl on pl.`planCode` = p.`planCode` 
where p.planCode ='A007'
group by e.`empCode`;


select e.empCode, e.empName, e.empTitle, count(if(p.custCode=null,0,p.custCode)) as perf , if(count(if(p.custCode=null,0,p.custCode))>=10,e.`empSalary`*0.1,0) as bonus, pl.`planDetail` as pCode, pl.`planName` as pName
from employee e left join performance p on e.`empCode` = p.`empCode`  left join customer c on p.`custCode`=c.`custCode` left join plan pl on pl.`planCode` = p.`planCode` 
where p.planCode ='A007'
group by e.`empCode`;

-- 1인 평균 급여액
select sum(empSalary) 
   from employee e ;
select (sum(empSalary))/(count(*))
   from employee e ;
  
-- 우수사원
create view ranking as select e.empCode, e.empName, e.empTitle, count(if(p.custCode=null,0,p.custCode)) as perf , if(count(if(p.custCode=null,0,p.custCode))>=10,e.`empSalary`*0.1,0) as bonus, pl.
from employee e left join performance p on e.`empCode` = p.`empCode`  left join customer c on p.`custCode`=c.`custCode` left join viptable v on p.`custCode`= v.vip left join plan pl on pl.`planCode` = p.`planCode` 
group by e.`empCode`;

select * from performance p ;

select * from ranking ;
select e.empCode, e.empName, e.empTitle, e.pic, r.perf, r.bonus  from employee e left join ranking r on e.`empCode` =r.empCode where e.`deptNo` =2 order by bonus desc, perf desc;

select  empCode, empName, empTitle, empAuth, empSalary, empTel, empId, empPwd, d.deptName, d.deptNo from employee e left join department d on e.deptNo = d.deptNo  
				 where empId='tototo';
				
select  empCode, empName, empTitle, empAuth, empSalary, empTel, empId, empPwd, d.deptName, d.deptNo 
			 from employee e left join department d on e.deptNo = d.deptNo
			where empName like '%황%' and empRetire=0;				
				
select  empCode, empName, empTitle, empAuth, empSalary, empTel, empId, empPwd, d.deptName, d.deptNo
				from employee e left join department d on e.deptNo = d.deptNo where empRetire =0
				order by empCode;				
				
select e.empCode, e.empName, e.empTitle, e.pic, r.perf, r.bonus  from employee e left join ranking r on e.`empCode` =r.empCode where e.`deptNo` =2 and empRetire =0 order by bonus desc, perf desc;				
				
select  empCode, empName, empTitle, empAuth, empSalary, empTel, empId, empPwd, d.deptName, d.deptNo
			from employee e left join department d on e.deptNo = d.deptNo 
			where empId='tototo' and empRetire =0;				
				
update employee set empRetire =1 where empCode ='A001';				
select  * from performance p ;

select e.empCode, e.empName , c.custCode, c.custName, p1.planCode, p1.planName
  from performance p left join plan p1 on p.planCode =p1.planCode left join employee e on p.empCode =e.empCode left join customer c on p.custCode =c.custCode where e.empCode='B007' ;

select  empCode, empName, empTitle, empAuth, empSalary, empTel, empId, empPwd, d.deptName, d.deptNo
			 from employee e left join department d on e.deptNo = d.deptNo 
			  order by empCode; 
 
select  empCode, empName, empTitle, empAuth, empSalary, empTel, empId, empPwd, d.deptName, d.deptNo, empRetire 
					from employee e left join department d on e.deptNo = d.deptNo
					where empTitle='부장' and empRetire =1;
			 
			 
			 
#고객 - 황하나
-- test 
select custCode, custName, custRank, custCredit, custAddr, custTel from customer;
select planCode, planDetail, planName, planDesc, planDiv from plan;
select * from plan;
delete from customer where custCode = "C008";

select c.custName, b.accountBalance from customer c left join bankbook b on c.custCode = b.custCode;
select  c.custCode, c.custName, b.accountNum , b.accountPlanCode, b.accountBalance from BankBook b left join customer c on b.custCode = c.custCode ;
select c.custCode, c.custName, b.accountNum, b.accountBalance from customer c left join bankbook b on c.custcode = b.custcode;
update BankBook set accountBalance = 5000300 where accountNum ="293133-11-000007"; 

select planCode, planDetail, planName, planDesc, planDiv from plan where planName like '%예금%';
select custName, accountNum, accountBalance from customer c left join bankbook b on c.custcode = b.custCode where custName = "김가나";

select (count(*) - (select count(*) from customer where custRank = "D")) from customer;
select count(*) from customer where custRank = "D"; 
select * from customer c ;

select * from card;
select * from bankbook;
select * from customer;
select * from plan;
select * from loan;
select * from Performance p ;
select * from viptable;

-- mysql 5.7 이상에서 group by 에러 처리

show variables like 'sql_mode';
set global sql_mode='STRICT_TRANS_TABLES';

-- 
select SUBSTRING_INDEX(SUBSTRING_INDEX(accountOpenDate, '-', 2), '-', -1) from bankbook where SUBSTRING_INDEX(SUBSTRING_INDEX(accountNum, '-', 2), '-', -1) ='11';

select * from cust_DW_audit;
desc cust_DW_audit ;
show triggers;

select c.custCode, c.custName, b.accountNum, b.accountBalance from customer c join bankbook b on c.custcode = b.custcode;

#BSGPD
select count(*) from customer where custRank = "B";

select * from bankbook;
select SUBSTRING_INDEX(SUBSTRING_INDEX(accountOpenDate, '-', 2), '-', -1) from bankbook where SUBSTRING_INDEX(SUBSTRING_INDEX(accountNum, '-', 2), '-', -1) ="11";

select  SUBSTRING_INDEX(SUBSTRING_INDEX(accountDate, '-', 2), '-', -1) from cust_dw_audit where dw ="입금";

select * from bankbook b ;
desc bankbook;
select * from cust_dw_audit cda ;
delete from cust_dw_audit where dw = "출금";
select * from loan;
select * from plan;

select count(*) from plan where planCode like 'A%';
select count(*) from plan where planDetail like 'AA%';
select count(*) from plan where planDetail like 'AB%';
select count(*) from plan where planDetail like 'AC%';
select count(*) from plan where planDetail like 'BA%';
select count(*) from plan where planDetail like 'BB%';
select count(*) from plan where planDetail like 'CA%';
select count(*) from plan where planDetail like 'CB%';
select count(*) from plan where planDetail like 'CC%';

select custCode, custName, custRank, custCredit, custAddr, custTel from customer where custCode = "C001";
select custCode, custName, custRank, custCredit, custAddr, custTel from customer where custTel = "123-1234-1234";

select * from plan;
select planCode, planDetail, planName, planDesc, planDiv from plan where planCode like "A%";
select planCode, planDetail, planName, planDesc, planDiv from plan where planDetail like "AB%";
select * from cust_DW_audit cda ;
select * from customer c join bankbook b on c.custCode = b.custCode where accountNum = "293133-11-000001";
select custName, accountNum, accountBalance from customer c join bankbook b on c.custcode = b.custCode where custName like "%김%";

-- 기본 스토리지 엔진 확인
select engine from information_schema.`ENGINES` where `SUPPORT` = 'DEFAULT';

select * from bankbook;
select * from cust_dw_audit cda ;

desc plan;
select * from plan;
select * from card;
select * from bankbook;
select c.custCode, c.custName, c.custRank, c.custCredit, accountNum, accountBalance, c.custDiv from customer c join bankbook b on c.custCode = b.custCode where substr(b.accountNum, 8,2) = "11" or "12" or "13";

select substr(accountNum, 8,2) from bankbook;
select substr(accountTransDate, 1, 10) from cust_dw_audit;
select * from cust_dw_audit where substr(accountTransDate, 1, 10) = "2020-04-06";
select * from card;
select cardBalance from card where custCode="C001" and accountNum ="293133-11-000001";
select * from loan;

desc bankbook;
select planCode, planDetail, planName, planDesc, planDiv from plan limit 0, 10;
select * from customer c join bankbook b on c.custCode = b.custCode;
select * from customer;
select * from bankbook;

#은행업무 - 박인선
select * from plan where planCode like 'A%';
select * from plan where planCode like 'B%';
select * from plan where planCode like 'C%';
#신용 카드 한도 조정
#1등급 : 10,000,000
#2등급 : 9,000,000
#3등급 : 8,000,000
#4등급 : 7,000,000
#5등급 : 6,000,000

#테이블을 위한 카드 SQL
select c.cardnum,cs.custname,p.planname,c.cardsecucode,c.cardissuedate,c.cardlimit,c.cardbalance from card c left join customer cs on c.custcode = cs.custcode left join plan p on p.planCode = c.plancode;
select * from plan;

select count(transDate) from cardinfo where custname = '김가나' and date(transdate) = date(now());
select custname,count(transDate) from cardinfo where custname = '김가나' and year(transDate) = year(now());
select replace(accountnum,'-1','-2') from bankbook where custcode = (select custcode from customer where custname = '김가나') and accountPlanCode = (select planCode from plan where planname = '휴면,해지계좌테스트용');

call make_dormant('김가나','휴면,해지계좌테스트용');
call make_termination('김가나','휴면,해지계좌테스트용');

select cs.custname,
(select count(plancode) from card where plancode = 'B001' and custcode = c.custcode) as 'check',
(select count(plancode) from card where plancode = 'B002' and custcode = c.custcode) as 'credit' 
from card c join customer cs on c.custcode = cs.custcode group by c.custcode;

select cs.custname,
(select count(loanplancode) from loan where loanplancode = 'C001' and custcode = l.custcode) as 'normal',
(select count(loanplancode) from loan where loanplancode = 'C002' and custcode = l.custcode) as 'credit',
(select count(loanplancode) from loan where loanplancode = 'C003' and custcode = l.custcode) as 'card'
from loan l join customer cs on l.custCode = cs.custcode group by l.custcode;

select * from changebankbookdormantinfo;
drop table changebankbookdormantinfo;
drop table changebankbookterminationinfo;

select accountnum from bankbook where custcode = (select custcode from customer where custname = '김가나') and `accountPlanCode` = 'A001' and (select substring(accountnum,8,1) from bankbook where custcode = (select custcode from customer where custname = '김가나') and `accountPlanCode` = 'A001') = '2';
select b.accountNum,c.custCode,c.custName,p.planCode,p.planName,b.accountOpenDate,b.accountInterest from bankbook b left join customer c on b.custCode = c.custCode left join plan p on b.accountPlanCode = p.planCode where b.accountNum like '%%';
select b.accountNum,c.custCode,c.custName,p.planCode,p.planName,b.accountOpenDate,b.accountInterest from bankbook b left join customer c on b.custCode = c.custCode left join plan p on b.accountPlanCode = p.planCode where c.custname like '%김%';
select b.accountNum,c.custCode,c.custName,p.planCode,p.planName,b.accountOpenDate,b.accountInterest from bankbook b left join customer c on b.custCode = c.custCode left join plan p on b.accountPlanCode = p.planCode where p.planname like '%직%';
select b.accountNum,c.custCode,c.custName,p.planCode,p.planName,b.accountOpenDate,b.accountInterest from bankbook b left join customer c on b.custCode = c.custCode left join plan p on b.accountPlanCode = p.planCode where accountnum like '%-11-%'; #예금
select b.accountNum,c.custCode,c.custName,p.planCode,p.planName,b.accountOpenDate,b.accountInterest from bankbook b left join customer c on b.custCode = c.custCode left join plan p on b.accountPlanCode = p.planCode where accountnum like '%-12-%'; #적금
select b.accountNum,c.custCode,c.custName,p.planCode,p.planName,b.accountOpenDate,b.accountInterest from bankbook b left join customer c on b.custCode = c.custCode left join plan p on b.accountPlanCode = p.planCode where accountnum like '%-13-%'; #마이너스

select * from card;
select c.cardnum,cs.custcode,cs.custname,p.plancode,p.planname,c.cardsecucode,c.cardissuedate,c.cardlimit,c.cardbalance from card c left join customer cs on c.custcode = cs.custcode left join plan p on p.planCode = c.plancode where p.planname = 'Easy 적립 카드';
select c.cardnum,cs.custcode,cs.custname,p.plancode,p.planname,c.cardsecucode,c.cardissuedate,c.cardlimit,c.cardbalance from card c left join customer cs on c.custcode = cs.custcode left join plan p on p.planCode = c.plancode where c.cardnum like '%331%'; #체크카드
select c.cardnum,cs.custcode,cs.custname,p.plancode,p.planname,c.cardsecucode,c.cardissuedate,c.cardlimit,c.cardbalance from card c left join customer cs on c.custcode = cs.custcode left join plan p on p.planCode = c.plancode where c.cardnum like '%332%'; #신용카드

select l.loanAccountNum,c.custName,p.planName,l.loanDate,l.loanInterest,l.loanBalance from loan l left join customer c on l.custCode = c.custCode left join plan p on l.loanPlanCode = p.planCode where l.loanaccountnum like '%13%'; #계좌번호검색
select l.loanAccountNum,c.custName,p.planName,l.loanDate,l.loanInterest,l.loanBalance from loan l left join customer c on l.custCode = c.custCode left join plan p on l.loanPlanCode = p.planCode where c.custname like '%김서%'; #고객이름
select l.loanAccountNum,c.custName,p.planName,l.loanDate,l.loanInterest,l.loanBalance from loan l left join customer c on l.custCode = c.custCode left join plan p on l.loanPlanCode = p.planCode where p.planname like '%프리%'; #상품명


select * from notice;



select * from employee;
select custname,if(substring(accountnum,9,1)=1,'예금',if(substring(accountnum,9,1)=2,'적금','마이너스')) as 'div',count(transDate) as 'count' from bankbookinfo where custname = '김서형' and date(transdate) = date(now()) group by accountnum;
select custname,if(substring(accountnum,9,1)=1,'예금',if(substring(accountnum,9,1)=2,'적금','마이너스')) as 'div',count(transDate) as 'count' from bankbookinfo where custname = '김서형' and week(transdate,1) = week(now(),1) group by accountnum;
select custname,if(substring(accountnum,9,1)=1,'예금',if(substring(accountnum,9,1)=2,'적금','마이너스')) as 'div',count(transDate) as 'count' from bankbookinfo where custname = '김서형' and month(transdate) = month(now()) group by accountnum;
select custname,if(substring(accountnum,9,1)=1,'예금',if(substring(accountnum,9,1)=2,'적금','마이너스')) as 'div',count(transDate) as 'count' from bankbookinfo where custname = '김서형' and year(transdate) = year(now()) group by accountnum;
select * from cardinfo;
select custname,if(substring(cardnum,7,1)=1,'체크카드','신용카드') as 'div',count(transDate) as 'count' from cardinfo where custname = '김가나' and date(transdate) = date(now()) group by cardnum;
select custname,if(substring(cardnum,7,1)=1,'체크카드','신용카드') as 'div',count(transDate) as 'count' from cardinfo where custname = '김가나' and week(transdate,1) = week(now(),1) group by cardnum;
select custname,if(substring(cardnum,7,1)=1,'체크카드','신용카드') as 'div',count(transDate) as 'count' from cardinfo where custname = '김가나' and month(transdate) = month(now()) group by cardnum;
select * from performance;

insert into bankbook values ('293133-11-000001','C001','A001',now(),0.10,0,'B001',0);

set autocommit = false;
insert into card values('2931331000000010','C001','A001',111,now(),null,null,(select empcode from employee where empname = '테스트'),'293133-11-000001');
update bankbook set connectchk = 1 where custcode = 'C001' and accountnum = '293133-11-000001';
update card set cardbalance = (select accountbalance from bankbook where accountnum = '293133-11-000001') where cardnum = '2931331000000010' and custcode = (select custcode from customer where custname = '김서형');
set autocommit = true;

delete from card;
update bankbook set connectchk = 0 where custcode = 'C001' and accountnum = '293133-11-000001';


create view bankbook_deposit_connect_to_card_info as select accountnum,custcode,connectchk from bankbook where substring(accountnum,8,2)='11' and connectchk = 0;
drop view bankbook_deposit_connect_to_card_info;
select * from customer;
select * from bankbook_deposit_connect_to_card_info;
select * from card;
delete from card;
select * from bankbookinfo;
desc card;
select custname,if(substring(cardnum,7,1)=1,'체크카드','신용카드') as 'div',count(transDate) as 'count' from cardinfo where year(transdate) = year(now()) group by cardnum;

select * from card;

update card set cardbalance = (select accountbalance from bankbook where accountnum = '293133-11-000001') where cardnum = '2931331000000010' and custcode = (select custcode from customer where custname = '김서형');
select * from card where custcode = (select custcode from customer where custname = '김서형') and cardnum = '2931331000000010';

desc bankbook;
desc card;
select * from bankbook;
select * from bankbook where accountDormant = 1;
select * from bankbook where accountTermination = 1;

select * from card;
select * from bankbook;
delete from card where custcode = 'C006';

select b.accountNum,c.custCode,c.custName,p.planCode,p.planName,b.accountOpenDate,b.accountInterest from bankbook b left join customer c on b.custCode = c.custCode left join plan p on b.accountPlanCode = p.planCode where accountnum like '%-11-%'
union select b.accountNum,c.custCode,c.custName,p.planCode,p.planName,b.accountOpenDate,b.accountInterest from bankbook b left join customer c on b.custCode = c.custCode left join plan p on b.accountPlanCode = p.planCode where accountnum like '%-12-%'
union select b.accountNum,c.custCode,c.custName,p.planCode,p.planName,b.accountOpenDate,b.accountInterest from bankbook b left join customer c on b.custCode = c.custCode left join plan p on b.accountPlanCode = p.planCode where accountnum like '%-13-%';

select b.accountNum,c.custCode,c.custName,p.planCode,p.planName,b.accountOpenDate,b.accountInterest from bankbook b left join customer c on b.custCode = c.custCode left join plan p on b.accountPlanCode = p.planCode where accountDormant = 0 and accountTermination = 0 and c.custDiv = 0;

select *from customer;

desc bankbookinfo;
select * from bankbook;
select * from plan;

select * from customer;

SET @@global.sql_mode= 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
SET @@session.sql_mode= 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
SHOW TABLE STATUS LIKE 'customer';
set names 'utf8';

desc customer;
select * from customer;
select custcode from customer where custname = '(주)에이스 테크놀로지';

desc bankbook;

select * from bankbook_deposit_connect_to_card_info;

update bankbook set accountopendate='2020-04-05 18:13:15',accountinterest='0.01' where custcode = 'B001';
select custname from customer;
select sum(accountBalance) from bankbook where accountnum like '%-11-%' or accountnum like '%-12-%'; #총 자본금(예금,적금 총액)
select sum(accountBalance) from bankbook where accountnum like '%-13-%'; #대출금(마이너스통장)
select sum(loanBalance) from loan; #대출금총합(대출)
select * from bank_totalBalance;
delete from loan where custcode = 'B001' and loanPlanCode = 'C007';
select * from bankbook where accountTermination = 1;

select
(select sum(accountbalance) from bankbook where accountnum like '%-11-%' and month(accountopendate) = 4) as 'deposit',
(select sum(accountbalance) from bankbook where accountnum like '%-12-%' and month(accountopendate) = 4) as 'saving', 
(select sum(accountbalance) from bankbook where accountnum like '%-13-%' and month(accountopendate) = 4) as 'minus', 
(select sum(cardBalance) from card where cardnum like '%331%' and month(cardissuedate) = 4) as 'checkcard', 
(select sum(cardLimit) from card where cardnum like '%332%' and month(cardissuedate) = 4) as 'creditcard', 
(select sum(loanBalance) from loan where loanAccountNum like '%-11-%' and month(loandate) = 4) as 'normalloan',
(select sum(loanBalance) from loan where loanAccountNum like '%-12-%' and month(loandate) = 4) as 'creditloan',
(select sum(loanBalance) from loan where loanAccountNum like '%-13-%' and month(loandate) = 4) as 'cardloan';
desc loan;
select * from loan;
delete from loan;
select * from performance;
delete from performance where plancode in ('C007','C008');
select b.accountNum,c.custCode,c.custName,p.planCode,p.planName,b.accountOpenDate,b.accountInterest from bankbook b left join customer c on b.custCode = c.custCode left join plan p on b.accountPlanCode = p.planCode;


select b.accountNum,c.custCode,c.custName,p.planCode,p.planName,b.accountOpenDate,b.accountInterest from bankbook b left join customer c on b.custCode = c.custCode left join plan p on b.accountPlanCode = p.planCode;


-- 송금 구현 위한테스트
select * from bankbook b ;
select b.accountNum, b.accountBalance, c.custCode,c.custName,p.planCode,p.planName from bankbook b left join customer c on b.custCode = c.custCode left join plan p on b.accountPlanCode = p.planCode where b.accountNum ='293133-11-000001';
select c.custCode, c.custName, c.custCredit, accountNum, accountBalance, c.custDiv from customer c join bankbook b on c.custCode = b.custCode where substr(b.accountNum, 8,2) = 11;
update bankbook set accountBalance = accountBalance+100 where accountNum ='293133-11-000001';
select loanaccountnum,custname,planname,loanstartdate,loandelaydate,loanexpiredate,loanmethod,loanround,loaninterest,loanbalance,loanrepayment from repayment r join customer c on r.custcode = c.custcode join plan p on r.loanplancode = p.plancode where loanaccountnum = '293133-11-000001';
desc repayment;

create view bank_totalBalance as select ((select sum(accountBalance) from bankbook where accountnum like '%-11-%' or accountnum like '%-12-%') + ifnull((select sum(loanBalance * loaninterest) from repayment),0)) as 'totalBankBookAmount', 
((select sum(accountBalance) from bankbook where accountnum like '%-13-%') + ifnull((select sum(loanBalance) from loan where loanExpired = 0),0)) as 'totalLoanAmount',
((select sum(accountBalance) from bankbook where accountnum like '%-11-%' or accountnum like '%-12-%') - ((select sum(accountBalance) from bankbook where accountnum like '%-13-%') + ifnull((select sum(loanBalance) from loan where loanExpired = 0),0))) as 'totalBankAmount';
select * from bank_totalbalance;
delete from repayment;
select * from repayment;
delete from loan;

select loanaccountnum,custname,planname,loanstartdate,loandelaydate,loanexpiredate,loanmethod,loanround,loaninterest,loanbalance,loanrepayment from repayment r join customer c on r.custcode = c.custcode join plan p on r.loanplancode = p.plancode where loanaccountnum = '293133-11-000001';
