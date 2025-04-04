/***
파일명 : Or09Join.sql
테이블조인
설명 : 2개 이상의 테이블을 동싱 참조하여 데이터를 인출해야 할때
        사용하는 SQL문
***/

--hr계정으로 학습

/*
1] inner join (내부조인)
    - 가장 많이 사용하는 조인문으로 테이블간에 연결조건을 모두 만족하는
        레코드를 검색할때 사용한다.
    - 일반적으로 기본키(Primary key)와 외래키(Foreign key)를 사용하여 
        join하는 경우가 대부분이다.
    - 2개의 테이블에 동일한 이름의 컬림이 존재해야하고, 이 경우 
        '테이블명.컬럼명' 과 같이 기술한다.
        
형식1](표준방식)
    select 컬럼1, 컬럼2...
    from 테이블1 inner join 테이블2
        on 테이블1.기본키컬럼 = 테이블2.외래키컬럼
    where 조건1 and 조건2 ...
*/

/*
시나리오] 사원테이블과 부서테이블을 조인하여 각 직원이 어떤부서에서
    근무하는지 출력하시오. 단, 표준방식으로 작성하시오.
    출력결과 : 사원아이디, 이름1, 이름2, 이메일, 부서번호, 부서명
*/

select
    employee_id, first_name, last_name, email,
    department_id, department_name
from employees inner join departments
    on employees.department_id = departments.department_id;
/* 위의 첫번째 쿼리문을 실행하면 열의 정의가 애매하다는 에러가 발생된다.
부서번호를 뜻하는 department_id가 양쪽 테이블 모두에 존재하므로 어떤 
테이블에서 가져와 인출해야할지 명시해야한다. */

--따라서 부서번호에 인출할 테이블명을 추가해준다.
select
    employee_id, first_name, last_name, email,
    employees.department_id, department_name
from employees inner join departments
    on employees.department_id = departments.department_id;
/* 실행결과에서는 소속된 부서가 없는 1명을 제외한 나머지 106명의
레코드가 인출된다. 즉 inner join은 조인한 테이블 양쪽에 만족되는
레코드를 대상으로 인출하게 된다.*/


--as(알리아스)를 통해 테이블에 별칭을 부여하면 쿼리문이 간단해진다.
select
    employee_id, first_name, last_name, email,
    Emp.department_id, department_name
from employees Emp inner join departments Dep
    on Emp.department_id = Dep.department_id;





--3개 이상의 테이블 조인하기
/*
시나리오] seattle(시애틀)에 위치한 부서에서 근무하는 직원의 정보를
    출력하는 쿼리문을 작성하시오. 단 표준방식으로 작성하시오. 
    출력결과] 사원이름, 이메일, 부서아이디, 부서명, 담당업무아이디, 
        담당업무명, 근무지역
    위 출력결과는 다음 테이블에 존재한다. 
    -사원테이블 : 사원이름, 이메일, 부서아이디, 담당업무아이디
    -부서테이블 : 부서아이디(참조), 부서명, 지역일련번호(참조)
    -담당업무테이블 : 담당업무명, 담당업무아이디(참조)
    -지역테이블 : 근무부서, 지역일련번호(참조)
*/
--1. 지역 테이블을 통해 seattle이 위치한 레코드의 일련번호를 확인
select * from locations where city = initcap('seattle');
--지역 일련번호가 1700인 것을 확인

--2. 지역 일련번호를 통해 부서테이블의 레코드 확인
select * from departments where location_id = 1700;
--21개의 부서가 있는 것을 확인

--3. 부서일련번호를 통해 사원테이블의 레코드를 확인한다.
select * from employees where department_id = 10; --1명 확인
select * from employees where department_id = 30; --6명 확인

--4. 담당업무 확인(구매담당 업무)
select * from jobs where job_id = 'PU_MAN'; --Purchasing Manager
select * from jobs where job_id = 'PU_CLERK'; --Purchasing Clerk

--5. join 쿼리문 작성
/* 양쪽 테이블에 동시에 존재하는 컬럼인 경우에는 반드시 테이블명이나
별칭을 명시해야한다. */
select 
    first_name 이름, last_name 성, email 메일주소,
    departments.department_id 부서코드, department_name 부서명,
    city 시, state_province 주,
    jobs.job_id 업무코드, job_title 업무명
from locations 
    inner join departments
        on locations.location_id =
            departments.location_id
    inner join employees
        on employees.department_id =
            departments.department_id
    inner join jobs
        on jobs.job_id =
            employees.job_id
where city = initcap('seattle');


--테이블의 별칭을 사용하면 쿼리문을 간단하게 만들수 있다.
select 
    first_name 이름, last_name 성, email 메일주소,
    D.department_id 부서코드, department_name 부서명,
    city 시, state_province 주,
    J.job_id 업무코드, job_title 업무명
from locations L
    inner join departments D
        on L.location_id =
            D.location_id
    inner join employees E
        on E.department_id =
            D.department_id
    inner join jobs J
        on J.job_id =
            E.job_id
where city = initcap('seattle');



/*
형식2] 오라클 방식
    select 컬럼1, 컬럼2...
    from 테이블1, 테이블2...
    where
        테이블1.기본키컬럼 = 테이블2.외래키컬럼
        and 조건1 or 조건2 ..;
표준방식에서 사용한 inner join과 on을 제거하고 조인의 조건을
where절에 표기하는 방식이다.
*/


/*
시나리오] 사원테이블과 부서테이블을 조인하여 각 직원이 어떤부서에서
    근무하는지 출력하시오. 단, 오라클방식으로 작성하시오.
    출력결과 : 사원아이디, 이름1, 이름2, 이메일, 부서번호, 부서명
*/

select
    employee_id, first_name, last_name, email,
    Emp.department_id, department_name
from employees Emp, departments Dep
    where Emp.department_id = Dep.department_id;


/*
시나리오] seattle(시애틀)에 위치한 부서에서 근무하는 직원의 정보를
    출력하는 쿼리문을 작성하시오. 단 오라클방식으로 작성하시오. 
    출력결과] 사원이름, 이메일, 부서아이디, 부서명, 담당업무아이디, 
        담당업무명, 근무지역
    위 출력결과는 다음 테이블에 존재한다. 
    -사원테이블 : 사원이름, 이메일, 부서아이디, 담당업무아이디
    -부서테이블 : 부서아이디(참조), 부서명, 지역일련번호(참조)
    -담당업무테이블 : 담당업무명, 담당업무아이디(참조)
    -지역테이블 : 근무부서, 지역일련번호(참조)
*/
select 
    first_name 이름, last_name 성, email 메일주소,
    D.department_id 부서코드, department_name 부서명,
    city 시, state_province 주,
    J.job_id 업무코드, job_title 업무명
from locations L, departments D, employees E, jobs J
where 
    L.location_id = D.location_id and
    E.department_id = D.department_id and
    J.job_id = E.job_id and
    lower(city) = 'seattle';















