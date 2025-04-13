/*
파일명 : Or10_1SQStudy.sql
*/

-------------------------------------HR계정으로 학습하세요---------------------------






/*
단일행 서브쿼리
형식]
    select * from 테이블명 where 컬럼 =(
        sleect 컬럼 from 테이블명 where 조건
        );
        ※괄호안의 서브쿼리는 반드시 하나의 결과를 인출해야 한다.
*/





/*
시나리오] 사원테이블에서 전체사원의 평균급여보다 낮은 급여를 받는 사원들을 
추출하여 출력하시오.
    출력항목 : 사원번호, 이름, 이메일, 연락처, 급여
*/
--1단계 평균급여를 확인한다.
select round(avg(salary)) from employees;
--2단계 구해진 값에 상응하는 데이터를 확인한다.
select * from employees
where salary < 6462;
--3단계 시나리오 조건에 맞는 서브쿼리를 작성한다.
select employee_id, first_name, last_name, email, phone_number, salary
from employees
where
    salary < (select avg(salary) from employees);    
    
    
/*
시나리오] 전체 사원중 급여가 가장적은 사원의 이름과 급여를 출력하는 
서브쿼리문을 작성하시오.
출력항목 : 이름1, 이름2, 이메일, 급여
*/
--1. 최저급여 구하기 (결과 : 2100)
select min(salary) from employees;
--2. 구해진 최저급여(2100)을 받는 사람을 구하기
select * from employees where salary = 2100;
--3. 시나리오 조건에 맞는 서브쿼리문 작성
select first_name, last_name, email, salary from employees
where salary = (select min(salary) from employees);

    

/*
시나리오] 평균급여보다 많은 급여를 받는/ 사원들의 명단을 조회할수 있는 
서브쿼리문을 작성하시오.
출력내용 : 이름1, 이름2, 담당업무명, 급여
※ 담당업무명은 jobs 테이블에 있으므로 join해야 한다. 
*/
--1. 평균급여 구하기
select avg(salary) from employees;
--2. 담당업무명을 갖는 테이블과 조인하기
select * from employees inner join jobs
    using(job_id);
--3. 시나리오 조건에 맞는 서브쿼리문 작성하기
select first_name, last_name, job_title, salary
from employees inner join jobs
    using(job_id)
where salary > (select avg(salary) from employees);
    
    



    
    
    
    
    
    
    
/*
복수행 서브쿼리
형식]
    select * from 테이블명 where 컬럼 in (
        select 컬럼 from 테이블명 where 조건
    );
※ 괄호안의 서브쿼리는 2개 이상의 결과를 인출해야 한다.
※ 경우에 따라 1개의 결과가 나오더라도 에러가 발생하진 않는다.
*/





/*
시나리오] 담당업무별로 가장 높은 급여를 받는 사원의 명단을 조회하시오.
    출력목록 : 사원아이디, 이름, 담당업무아이디, 급여
*/
--1. 담당업무별 가장높은 급여 확인하기
select job_id, max(salary) from employees
group by job_id; 

--2. 1.의 쿼리문을 조건으로 서브쿼리 작성
select employee_id, first_name, last_name, job_id, salary
from employees
where (job_id, salary) 
    in(select job_id, max(salary) from employees
    group by job_id);
/***********in 쓸때 조심하자 in은 등호(=)가 들어가지 않는다***********/
















/*
복수행 연산자 : any (or과 유사)
    메인퀄의 비교조건이 서브쿼리의 검색결과와 하나 이상 일치하면
    true가 되는 연산자. 즉 하나의 조건만 만족하면 해당 레코드를 인출한다.


복수행 연산자 : all (and와 유사)
    메인쿼리의 비교조건이 서브쿼리의 검색결과와 모두 일치해야
    레코드를 인출한다.


시나리오] 전체 사원중에서 부서번호가 20인 사원들의 급여보다 높은 급여를
    받는 직원들을 인출하는 서브쿼리문을 작성하시오. 단 둘 중 하나만
    만족하더라도 인출하시오. 
*/
--1. 부서번호 20인 사원들의 급여를 확인 (결과 : 6000, 13000)
select salary from employees where department_id = 20;
--2. 확인한 결과를 조건으로 쿼리문 작성
select * from employees where salary > 6000 or salary > 13000;
--3. 결과를 바탕으로 서브쿼리문 작성 및 검증
select * from employees 
where salary >
    any(select salary from employees
    where department_id = 20);

--4. all문으로 변환
--4-2
select * from employees where salary > 6000 and salary > 13000;
--4-3
select * from employees 
where salary >
    all(select salary from employees
    where department_id = 20);
















/*
rownum : 테이블에서 레코드를 조회한 순서대로 순번이 부여되는 가상의
    컬럼을 말한다. 해당 컬럼은 모든 테이블에 논리적으로 존재한다.

 레코드를 정렬없이 모든 레코드를 가져와서 rownum을 부여한다.
이 경우 rownum은 순서대로 인출된다. */
select employee_id, first_name, rownum from employees;
/* 이름이나 사원번호를 통해 정렬하면 rownum이 섞여서 나오기도 하고
순서대로 나오기도 한다. */
select employee_id, first_name, rownum 
    from employees order by first_name;
select employee_id, first_name, rownum 
    from employees order by employee_id;
/*
rownum을 우리가 정렬한 순서대로 재부여하기 위해 서브쿼리를 사용한다.
from 절에는 테이블이 위치해야 하지만, 아래의 서브쿼리에서는 사원
테이블의 전체레코드를 대상으로 하되 이름으로 정렬된 상태로 레코드를
인출하기 때문에 테이블을 대체 할 수 있다.
또한 정렬된 상태에서 rownum을 부여하므로 순차적인 순번이 된다.
*/
select first_name, rownum from
    (select * from employees order by first_name asc);

/*
이름을 기준으로 정렬된 레코드에 rownum을 부여했으므로 where절에
아래와 같은 조건을 부여해서 구간을 결정할 수 있다. */
select * from
    (select tb.*, rownum from
        (select * from employees order by first_name asc) tb) 
where rownum >= 1 and rownum <= 10;
--where rownum between 1 and 10;

--rownum에 별칭을 부여해서 조건으로 사용한다.
select * from
    (select tb.*, rownum rNum from
        (select * from employees order by first_name asc) tb) 
--where rNum >= 1 and rNum <= 10;
--where rNum >= 11 and rNum <= 20;
where rNum between 21 and 30;
--구간을 정할때는 between을 사용해도 된다.


--------------------------주말 과제 ------------------------------------
/**************************scott계정****************************/

/*
01.사원번호가 7782인 사원과 담당 업무가 같은 사원을 표시
(사원이름과 담당 업무)하시오.
*/

select empno, ename, job from emp where empno = 7782;


select * from emp 
where JOB = (select job from emp where empno = 7782);





/*
02.사원번호가 7499인 사원보다 급여가 많은 사원을 표시(사원이름과 담당 업무)하시오.
*/
select sal from emp where empno = 7499;

select * from emp where sal > (select sal from emp where empno = 7499);



/*
03.최소 급여를 받는 사원의 이름, 담당 업무 및 급여를 표시하시오(그룹함수 사용).
*/
select empno, ename, job, sal from emp where sal = (select min(sal) from emp);




/*
04.평균 급여가 가장 적은 직급(job)/과 평균 급여를 표시하시오.
*/
select job, avg(sal) from emp group by job;



/*이해가 잘 안감 ㅡㅡ*/
select job, avg(sal)
from emp group by job
having 
    avg(sal) = (
        select min(asal) from (
                    select job, avg(sal) as asal from emp group by job));



/*
05.각부서의 최소 급여를 받는 사원의 이름, 급여, 부서번호를 표시하시오.
*/

select ename, sal, deptno
from emp
where sal in(select min(sal) from emp group by deptno);



/*
06.담당 업무가 분석가(ANALYST)인 사원보다 급여가 적으면서 업무가 분석가(ANALYST)가 아닌
사원들을 표 시(사원번호, 이름, 담당업무, 급여)하시오.
*/
select * from emp where not job = 'ANALYST';

select sal from emp where job = 'ANALYST';

select empno, ename, job, sal from (select * from emp where not job = 'ANALYST')
where sal < (select sal from emp where job = 'ANALYST');





/*
07.이름에 K가 포함된 사원과 같은 부서에서 일하는 사원의 사원번호와 이름을 표시하는 
질의를 작성하시오
*/
select job from emp where ename like '%K%';

select empno, ename from emp where deptno in(select deptno from emp where ename like '%K%');

/*
08.부서 위치가 DALLAS인 사원의 이름과 부서번호 및 담당 업무를 표시하시오.
*/
select ename, deptno, job from emp inner join dept using(deptno) 
where loc = 'DALLAS';



/*
09.평균 급여 보다 많은 급여를 받고/ 이름에 K가 포함된 사원과 /같은 부서에서 
근무하는 사원의 사원번호, 이름, 급여를 표시하시오.
*/
select deptno from emp where ename like '%K%';

select empno, ename, sal from emp where sal > (select avg(sal) from emp) and
deptno in(select deptno from emp where ename like '%K%');


/*
10.담당 업무가 MANAGER인 사원이 소속된 부서와 동일한 부서의 사원을 표시하시오.
*/
select * from emp where deptno in(select deptno from emp where job = 'MANAGER');




/*
11.BLAKE와 동일한 부서에 속한 사원의 이름과 입사일을 표시하는 
질의를 작성하시오(단. BLAKE는 제외)
*/
select ename, hiredate from (select * from emp where not ename = 'BLAKE')
where deptno = (select deptno from emp where ename = 'BLAKE');

