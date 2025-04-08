/*
파일명 : Or14_1ViewStudy.sql

View(뷰)
설명 : View는 테이블로부터 생성된 가상의 테이블로 물리적으로는
    존재하지 않고 논리적으로만 존재하는 테이블이다.
    
--------------------------hr계정에서 학습합니다.-----------------------


select 쿼리문 식행시 해당 테이블이 존재하지 않는다면 "테이블 또는
뷰가 존재하지 않습니다"라는 오류 메세지가 뜨게된다. */
select * from memeber;

/*
View 생성
형식]
     create [or replace] view 뷰이름[(컬럼명N...)]
     as
     select 참조할컬럼명 from 참조할테이블명 where 조건N...
     group by
     order by 등
     모든 select문 가능함.



시나리오] hr계정의 사원테이블에서 담당업무가 ST_CLERK인 사원의 정보를
        조회할 수 있는 View를 생성하시오.
        출력항목 : 사원아이디, 이름, 직무아이디, 입사일, 부서아이디
*/
--1. 시나리오 조건에 맞는 select문 생성
select employee_id, first_name||' '||last_name, job_id,
hire_date, departmen_id
from employees where job_id = 'ST_CLERK';
--2. 구해진 select문을 토대로 뷰 생성
create or replace view v_st_clk(
    empid, fname, jid, hdate, depid)
as
    select employee_id, first_name||' '||last_name, job_id,
        hire_date, department_id
    from employees where job_id = 'ST_CLERK';
--3. view 확인
select * from v_st_clk;
--4. 데이터 사전에서 확인
select * from user_views;








/*
View 수정하기
    뷰 생성 문장에 or replace 만 추가하면된다.
    해당 뷰가 존재하면 수정되고, 만약 존재하지 않으면 새롭게 생성된다.
    따라서 최초로 뷰를 생성할때 사용해도 무방하다.

시나리오] 앞에서 생성한 뷰를 다음과 같이 수정하시오.
    기존 컬럼인 employee_id, first_name, job_id, hire_date, department_id를
    id, fname, jobid, hdate, deptid 로 수정하여 뷰를 생성하시오.
    

------위에서 했으므로 패스-------
*/

/*
퀴즈] 담당업무 아이디가 ST_MAN인 사원의/조건 사원번호, 이름, 이메일, 매니져아이디를/select
    조회할 수 있도록 작성하시오.
    뷰의 컬럼명은 e_id, name, email, m_id로 지정한다./뷰 컬럼명 단, 이름은 
    first_name과 last_name이 연결된 형태로 출력하시오./이름 합치기
	뷰명 : emp_st_man_view /뷰이름
*/
--1. select문 작성
select employee_id, first_name||' '||last_name, email, manager_id
from employees where job_id = 'ST_MAN';
--2. 뷰 생성
create or replace view emp_st_man_view(
    e_id, name, email, m_id)
as
    select employee_id, first_name||' '||last_name, email, manager_id
    from employees where job_id = 'ST_MAN';
--3. 뷰 확인
select * from emp_st_man_view;




/*
퀴즈] 사원번호, 이름, 연봉을 계산하여 출력
컬럼의 이름 emp_id, l_name, annual_sal
연봉계산식 (급여+(급여*보너스율))*12
뷰이름 : v_emp_salary
단, 연봉은 세자리마다 컴마가 삽입되어야 한다. 
*/
select employee_id, first_name||' '||last_name,
ltrim(to_char((salary + (salary * nvl(commission_pct, 0)) * 12), '999,000'))
from employees;


create or replace view v_emp_salary(
    사원번호, 이름, 연봉)
as
    select employee_id, first_name||' '||last_name,
    ltrim(to_char(((salary + (salary * nvl(commission_pct, 0)))* 12), '999,000'))
    from employees;

select * from v_emp_salary;




/*
-조인을 통한 View 생성
시나리오] 사원테이블과 부서테이블, 지역테이블을 조인하여 다음 조건에 맞는 
뷰를 생성하시오.
출력항목 : 사원번호, 전체이름, 부서번호, 부서명, 입사일자, 지역명
뷰의명칭 : v_emp_join
뷰의컬럼 : empid, fullname, deptid, deptname, hdate, locname
컬럼의 출력형태 : 
	fullname => first_name+last_name 
	hdate => 0000년00월00일
    locname => XXX주의 YYY (ex : Texas주의 Southlake)	
*/
--1
select employee_id, first_name||' '||last_name,
    department_id, department_name, 
    to_char(hire_date, 'yyyy"년 "mm"월 "dd"일"'),
    state_province||'주의 '||city
from employees
    inner join departments using(department_id)
    inner join locations using(location_id);

--2
create or replace view v_emp_join (
    사원번호, 전체이름, 부서번호, 부서명, 입사일자, 지역명)
as
    select employee_id, first_name||' '||last_name,
        department_id, department_name, 
        to_char(hire_date, 'yyyy"년 "mm"월 "dd"일"'),
        state_province||'주의 '||city
    from employees
        inner join departments using(department_id)
        inner join locations using(location_id);
        
        
        
create or replace view v_emp_join2 (
    empid, fullname, deptid, deptname, hdate, locname)
as
    select employee_id, first_name||' '||last_name,
        department_id, department_name, 
        to_char(hire_date, 'yyyy"년 "mm"월 "dd"일"'),
        state_province||'주의 '||city
    from employees
        inner join departments using(department_id)
        inner join locations using(location_id);

--3
select * from v_emp_join;
select * from v_emp_join2;























