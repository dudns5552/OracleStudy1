/*
파일명 : Or16_1SPstudy.sql
#해당 문제는 education 계정을 사용합니다.
#Or16SubProgram.sql 파일 아래에 연결해서 아래 문제를 풀어주세요.

▣ 테이블생성
아래와 같은 테이블을 생성하시오. 
◈ 상품코드관리 : sh_product_code
컬럼명          자료형     설명
p_code          숫자형 상품코드. PK
category_name   문자형 카테고리명


◈ 상품관리 : sh_goods
컬럼명      자료형     설명
g_idx       숫자형     상품일련번호. PK
goods_name  문자형     상품명
goods_price 숫자형     상품가격
regidate    날짜형     등록일
p_code      숫자형     상품코드. sh_product_code 테이블의 p_code 를 참조하는 FK


◈ 상품관리 : sh_goods_log
컬럼명         자료형         설명
log_idx         숫자형         로그일련번호. PK
goods_name      문자형         상품명
goods_idx       숫자형         상품일련번호
p_action        문자형         로그액션 
                            입력시 : ‘Insert’ , 삭제시 : ‘Delete’ 입력
                            (check제약조건 적용)
*/






-- 상품코드관리 테이블 생성
create table sh_product_code(
    p_code number(20) primary key,
    category_name varchar2(50));

alter table sh_product_code modify category_name varchar2(50);
    
comment on column sh_product_code.p_code is '상품코드, PK';
comment on column sh_product_code.category_name is '카테고리명';
    
    
    
    
--상품관리 테이블 생성
create table sh_goods (
g_idx number(20) primary key,
goods_name varchar2(50),
goods_price number(20),
regidate date,
p_code number(20)
);

alter table sh_goods add foreign key (p_code)
REFERENCES sh_product_code (p_code);

comment on column sh_goods.g_idx is '상품일련번호, PK';
comment on column sh_goods.goods_name is '상품명';
comment on column sh_goods.goods_price is '상품가격';
comment on column sh_goods.regidate is '등록일';
comment on column sh_goods.p_code is '상품코드, sh_product_code 테이블의 p_code를 참조하는 FK';
    
    
    
    
--상품관리 로그 테이블 생성
create table sh_goods_log(
log_idx     number(20) primary key,
goods_name  varchar2(50),
goods_idx   number(20),
p_action    varchar2(10) check(p_action in('Insert', 'Delete'))
);
    
comment on column sh_goods_log.log_idx is '로그일련번호, PK';
comment on column sh_goods_log.goods_name is '상품명';
comment on column sh_goods_log.goods_idx is '상품일련번호';
comment on column sh_goods_log.p_action is '로그액션 
입력시 : ‘Insert’ , 삭제시 : ‘Delete’ 입력(check제약조건 적용)
';
    
    
    
    
    
    
/*
▣ 시퀀스 생성
앞에서 생성한 3개의 테이블에서 사용할 시퀀스를 생성하시오. 
테이블 당 하나씩의 시퀀스를 생성하는 것을 권장하나, 여기서는 하나만 생성하여 사용한다. 
시퀀스명 : seq_total_idx
증가치, 시작, 최소값 : 1로 지정
최대값, 사이클(cycle), 캐시(cache) : 사용하지 않음
*/

create sequence seq_total_idx
    INCREMENT by 1
    START with 1
    MINVALUE 1
    NOMAXVALUE
    NOCYCLE
    nocache;
    







/*
▣ 더미데이터 입력
아래 설명에 따라 적당한 레코드를 입력하시오. 

sh_product_code  테이블
앞에서 생성한 시퀀스를 이용해서 3~5개 정도의 상품코드 레코드를 입력한다.
예)  가전, 도서, 의류 등
*/
drop SEQUENCE seq_total_idx;
delete from sh_product_code;

insert into sh_product_code (p_code, category_name)
values (seq_total_idx.nextval, '가전');
insert into sh_product_code (p_code, category_name)
values (seq_total_idx.nextval, '도서');
insert into sh_product_code (p_code, category_name)
values (seq_total_idx.nextval, '의류');
insert into sh_product_code (p_code, category_name)
values (seq_total_idx.nextval, '음식');
insert into sh_product_code (p_code, category_name)
values (seq_total_idx.nextval, '문구');

select * from sh_product_code;






/*
sh_goods 테이블
앞에서 생성한 시퀀스를 이용해서 5~10개 정도의 상품 레코드를 입력한다. 
예) 냉장고, 세탁기 / 사피엔스, 총균쇠 / 롱패딩, 레깅스, 청바지 등
가격과 등록일은 본인이 적당히 정하면 된다. 
단, 상품은 상품코드와 일치해야 한다. 
예) 가전 - 냉장고 / 도서 - 총균쇠
*/
insert into sh_goods (g_idx, goods_name, goods_price, regidate, p_code)
values (seq_total_idx.nextval, '냉장고', 3000, '2021-12-21', 1);
insert into sh_goods (g_idx, goods_name, goods_price, regidate, p_code)
values (seq_total_idx.nextval, '세탁기', 1500, '2022-02-22', 1);
insert into sh_goods (g_idx, goods_name, goods_price, regidate, p_code)
values (seq_total_idx.nextval, '사피엔스', 10, '2020-02-20', 2);
insert into sh_goods (g_idx, goods_name, goods_price, regidate, p_code)
values (seq_total_idx.nextval, '총균쇠', 11, '2000-01-01', 2);
insert into sh_goods (g_idx, goods_name, goods_price, regidate, p_code)
values (seq_total_idx.nextval, '롱패딩', 400, '2024-12-01', 3);
insert into sh_goods (g_idx, goods_name, goods_price, regidate, p_code)
values (seq_total_idx.nextval, '레깅스', 50, '2024-10-25', 3);
insert into sh_goods (g_idx, goods_name, goods_price, regidate, p_code)
values (seq_total_idx.nextval, '청바지', 100, '2025-04-01', 3);
insert into sh_goods (g_idx, goods_name, goods_price, regidate, p_code)
values (seq_total_idx.nextval, '수박', 8, '2024-08-21', 4);
insert into sh_goods (g_idx, goods_name, goods_price, regidate, p_code)
values (seq_total_idx.nextval, '만두', 5, '2025-04-11', 4);
insert into sh_goods (g_idx, goods_name, goods_price, regidate, p_code)
values (seq_total_idx.nextval, '볼펜', 1, '2018-02-18', 5);








/*
sh_goods_log 테이블
별도로 입력하지 않는다. 
*/


commit;








/*
상품수정 및 삭제
프로시저 작성후 CallableStatement객체를 사용하여 호출하도록 한다. 

상품수정
프로시저명 : ShopUpdateGoods
In파라미터 : 상품명, 가격, 제품코드, 수정할 상품의 일련번호
Out파라미터 : 레코드 수정 결과(1 혹은 0)
호출할 Java클래스 : UpdateShop
*/

create or replace procedure ShopUpdateGoods 
            (
            g_name in varchar2,
            g_price in number,
            g_code in number,
            idx in number,
            returnval out number 
            )
is
begin
    update sh_goods set
        goods_name = g_name, 
        goods_price = g_price, 
        p_code = g_code
        where g_idx = idx;
    if sql%found then
        returnval := sql%rowcount;
        commit;
    else
        returnval := 0;
    end if;
end;
/

commit;

var test50 varchar2(50);
execute ShopUpdateGoods ('배', 3, 4, 16, :test50);
print test50;

select * from sh_goods;





/*
상품삭제
프로시저명 : ShopDeleteGoods
In파라미터 : 삭제할 상품의 일련번호
Out파라미터 : 레코드 삭제 결과(1 혹은 0)
호출할 Java클래스 : DeleteShop
*/

create or replace procedure ShopDeleteGoods (
    g_name in varchar2,
    returnVal out varchar2
    )
is
begin
    delete from sh_goods where goods_name = g_name;
    
    if SQL%Found then
        returnVal := 'SUCCESS';
        commit;
    else
        returnVal := 'FAIL';
    end if;
end;
/


commit;

var test50 varchar2(50);
execute ShopUpdateGoods ('배', 3, 4, 16, :test50);
print test50;

select * from sh_goods;





/*
 트리거생성
상품관리 테이블에 데이터가 입력/삭제 되었을때 로그테이블[goods_log]에 내역이 남도록 하는 
트리거를 작성하시오. 
트리거명 : shop_log_trigger
상품입력시 : Insert
상품삭제시 : Delete
업데이트는 제외하고, 트리거는 1개로 작성한다. 2개로 작성하지 않는다.

LOG_IDX
GOODS_NAME
GOODS_IDX
P_ACTION
*/
create or replace trigger shop_log_trigger
    after 
    insert or delete
    on sh_goods
    for each row
begin
    if inserting then
        insert into sh_goods_log (LOG_IDX, GOODS_NAME, GOODS_IDX, P_ACTION)
        values (seq_total_idx.nextval, 
                    :new.goods_name, 
                    :new.g_idx, 
                    'Insert');
    elsif deleting then
        insert into sh_goods_log(LOG_IDX, GOODS_NAME, GOODS_IDX, P_ACTION)
        values (seq_total_idx.nextval, 
                :old.goods_name, 
                :old.g_idx, 
                'Delete');
    end if;
end;
/

drop trigger shop_log_trigger;

delete from sh_goods where goods_name = '배';



commit;


















