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















