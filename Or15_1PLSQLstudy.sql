/*
파일명 : Or15_1PLSQLstudy.sql
PL/SQL
설명 : 오라클에서 제공하는 프로그래밍 언어



PL/SQL(Procedural Language)
    일반 프로그래밍 언어에서 가지고 있는 요소를 모두 가지고 있으며
    DB업무를 처리하기 위해 최적화된 언어
------------------------ HR계정에서 학습합니다. ----------------------
--예제1] PL/SQL 맛보기
--화면상에 내용을 출력하고 싶을때 on으로 설정한다. off면 출력되지 않는다.
*/

/* 시나리오] 사원테이블에서 사원번호가 120인 사원의 이름과 
연락처를 출력하는 PL/SQL문을 작성하시오. */
--select문 작성
select first_name||' '||last_name, phone_number
from employees
where employee_id = 120;

declare
    fname varchar2(50);
    pnum varchar2(50);
begin
    select first_name||' '||last_name, phone_number
        into fname, pnum
    from employees
    where employee_id = 120;
    dbms_output.put_line(fname||' '||pnum);
end;
/
    
    


/*
시나리오] 부서번호 10인 사원의 사원번호, 급여, 부서번호를 가져와서 
아래 변수에 대입후 화면상에 출력하는 PL/SQL문을 작성하시오. 
단, 변수는 기존테이블의 자료형을 참조하는 '참조변수'로 선언하시오.
*/
declare
    ENo employees.employee_id%type;
    Sal employees.salary%type;
    DpN departments.department_id%type;
begin
    select employee_id, salary, department_id
        into ENo, Sal, Dpn
    from employees where department_id = 10;
    
    dbms_output.put_line(ENo||' '||Sal||' '||Dpn);
end;
/


/*
시나리오] 사원번호가 100인 사원의 레코드를 가져와서 emp_row변수에 전체컬럼을 저장한 후 화면에 다음 정보를 출력하시오.
단, emp_row는 사원테이블이 전체컬럼을 저장할 수 있는 참조변수로 선언해야한다. 
출력정보 : 사원번호, 이름, 이메일, 급여 */
  
declare
    emp_row employees%rowtype;
begin
    select *
        into emp_row
    from employees
    where employee_id = 100;
    dbms_output.put_line(emp_row.employee_id||' '||emp_row.first_name||' '||
                        emp_row.last_name||' '||emp_row.email||' '||emp_row.salary);
end;
/
  
  
/*
시나리오] 사원번호, 이름(first_name+last_name), 담당업무명을 저장할
수 있는 복합변수를 선언한 후, 100번 사원의 정보를 출력하는 
PL/SQL을 작성하시오.
*/

declare
    type emp_inf is record (
        EId employees.employee_id%type,
        FName varchar2(50),
        JId employees.job_id%type
        );
    rec3 emp_inf;
begin
    select employee_id, first_name||' '||last_name, job_id
        into rec3
    from employees where employee_id = 100;
    
    dbms_output.put_line(rec3.EId||' '||rec3.FName||' '||rec3.JId);
end;
/
  
  
  
  
  
  
  
  
  
    
    
    
    
    
    
    
    
    
    
    
