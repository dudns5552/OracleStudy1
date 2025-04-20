/*
파일명 : bankingJDBC.sql

테이블 생성
테이블명 : banking
컬럼 : 일련번호, 계좌번호, 이름, 잔액, 이자율
primary key, not null과 같은 제약조건 추가 
시퀀스 생성
시퀀스명 : seq_banking_idx
*/

create table banking (
    idx number(10) not null,
    accnum varchar2(50) primary key,
    name varchar2(50) not null,
    balance number(10) default 0 not null,
    inter number(5) default 0 not null
    );

create SEQUENCE seq_banking_idx
    increment by 1
    start with 1
    minvalue 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;


commit;

insert into banking values
    (seq_banking_idx.nextval, 111, 111, 5000, 2);

select * from banking;

--입금이 되는지 확인
update banking set balance = balance + (balance * (inter/100) + 5000)
    where accnum = '111';

select * from banking;



--출금 조건식 확인

--var wd number;
--var sn varchar2;


declare
    an banking.accnum%type;
    bal banking.balance%type;
    wd number;
    sn varchar2(50);
begin
    wd := &withdarw;
    sn := &accnum;
    select accnum, balance into an, bal from banking 
        where accnum = sn;

    if ( bal - wd) > 0 then
        bal := bal - wd;
        
        update banking set balance = bal
            where an = sn;
        
        dbms_output.put_line('출금이 완료되었습니다.');
    
    else
        dbms_output.put_line('잔고가 부족합니다.');
    end if;
end;
/
    




update banking set balance = balance - wd
where accnum = sn and balnace - wd > 0 ;
    
    

    
create or replace procedure pcd_bank_wd
    (
        bNum in varchar2,
        wd in varchar2,
        rs out number
    )
is
ba number(10);
begin
    
    select balance into ba from banking where accnum = bNum;
    
        if (ba - wd) > 0 then
            update banking set balance = (ba - wd) where accnum = bNum;
            rs := 1;
            commit;
        elsif ((ba - wd) < 0) then
            rs := 2;
            commit;
        end if;
end;
/

commit;


var ice varchar2(10);
execute pcd_bank_wd(1111, 1000, :ice);
print ice;
select * from banking;







--검색기능 고치기
SELECT * FROM banking where accnum = &number;

insert into banking (idx, accnum, name, balance, inter)
    values (seq_banking_idx.nextval, 3333, 'dddd', 10000, 2);




--삭제 프로시저 만들기
create or replace procedure pcd_bank_del
    (
        delNum in varchar2,
        rs out number
    )
is
an number;
begin
    rs := 0;
    select accnum into an from banking where accnum = delNum;
        
        if (an = delnum) then
            delete from banking where accnum = delNum;
            rs := 1;
            commit;
        end if;
end;
/


insert into banking values (seq_banking_idx.nextval, 4444, 4444, 10000, 2);
commit;
select * from banking;

var i number;
execute pcd_bank_del(4444, :i);
print i;




drop sequence seq_banking_idx;



select * from banking;






































