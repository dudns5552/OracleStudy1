/*
파일명 : Or11_1CstStudy.sql
제약조건
설명 : 테이블 생성시 필요한 여러가지 제약조건에 대해 학습한다.

* []는 생략이 가능하다. *

--Education 계정에서 학습합니다.


primary key : 기본키
- 참조무결성을 유지하기 위한 제약조건
- 하나의 테이블에 하나의 기본키만 설정할 수 있음
- 기본키로 설정된 컬럼은 중복된 값이나 null을 입력할 수 없음
- 주로 레코드 하나를 특정하기 위해 사용된다.


형식1] 인라인방식 : 컬럼 생성시 우측에 제약조건을 기술한다.
    create table 테이블명 (
        컬럼명 자료형(크기) [constraint 제약명] primary key
    );
    ※ [] 대괄호 부분은 생략이 가능하고, 생략시 제약명을 시스템이
        자동으로 부여한다.
*/















-----------------------------주말과제-------------------------------
/*
#해당 문제는 scott 계정을 사용합니다.

#Or11Constraint.sql 파일 아래에 연결해서 아래 문제를 풀어주세요.

1. emp 테이블의 구조를 복사하여 pr_emp_const 테이블을 만드시오. 복사된 테이블의 
사원번호 칼럼에 pr_emp_pk 라는 이름으로 primary key 제약조건을 지정하시오.
*/
create table pr_emp_const
as
select * from emp where 1 = 0;

alter table pr_emp_const add constraint pr_emp_pk
    primary key (empno);
    
select * from user_constraints;



/*
2. dept 테이블의 구조를 복사해서 pr_dept_const 테이블을 만드시오. 부서번호에
pr_dept_pk 라는 제약조건명으로 primary_key를 생성하시오.
*/
create table pr_dept_const
as
select * from dept where 1 = 0;

alter table pr_dept_const add constraint pr_dept_pk
    primary key (deptno);

select * from user_constraints;

/*
3. pr_dept_const 테이블에 존재하지 않는 부서의 사원이 배정되지 않도록
외래키 제약조건을 지정하되 제약조건 이름은 pr_emp_dept_fk 로 지정하시오.
*/
alter table pr_emp_const add constraint pr_emp_uk_deptno
    unique (deptno);
alter table pr_emp_const drop constraint pr_emp_uk_deptno;


alter table pr_emp_const add constraint pr_emp_dept_fk
    foreign key (deptno) references pr_dept_const (deptno);

select * from user_constraints;


/*
4. pr_emp_const 테이블의 comm 칼럼에 0보다 큰 값만을 입력할수 있도록 
제약조건을 지정하시오. 제약조건명은 지정하지 않아도 된다.
*/
alter table pr_emp_const add
 check (comm > 0);

select * from user_constraints;

/*
5. 위 3번에서는 두 테이블간에 외래키가 설정되어서 pr_dept_const 테이블에서 
레코드를 삭제할 수 없었다. 이 경우 부모 레코드를 삭제할 경우 자식까지 같이 
삭제될수 있도록 외래키를 지정하시오.
*/
alter table pr_emp_const constraint pr_emp_dept_fk
    foreign key (deptno) references pr_dept_const (deptno)
        on delete cascade;











