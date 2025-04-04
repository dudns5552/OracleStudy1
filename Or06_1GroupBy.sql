--06_1GroupBy 공부
-- 전체직원의 급여의 합계를 인출하시오.

select sum(salary),
    trim(to_char(sum(salary), '$999,000')) 전체직원급여합계 from employees;

--10번 부서에서 근무하는 사원들의 급여 합계는 얼마인지 인출하시오.
select ltrim(to_char(sum(salary), '$999,000')) "10번부서급여합계"
from employees
where department_id = 10;


--전체사원의 평균급여는 얼마인지 인출하시오.
select ltrim(to_char(avg(salary), '$999,000.00'))
from employees;

--영업팀(SALES)의 평균급여는 얼마인가요??
--1단계 세일즈팀 부서코드 알아내기
select *
from departments
where upper(department_name) = 'SALES';

--2단계 부서코드80의 급여평균값을 구한다.
select ltrim(to_char(avg(salary), '$999,000.0'))
from employees
where department_id = 80;

--전체 사원 중 급여가 가장 적은 직원은 누구인가요??
--1단계 최저급여를 구한다.
select  salary
from employees
group by salary
order by salary;

--2단계 최저급여를 조건으로 사람을 구한다.
select first_name, last_name, salary
from employees
where salary = 2100;



--사원테이블에서 각 부서별 급여의 합계는 얼마인가요??
select department_id, sum(salary)
from employees
group by department_id
order by department_id;


/*
퀴즈] 사원테이블에서 각 부서별 사원수와 평균급여는 얼마인지 출력하는 
쿼리문을 작성하시오. 
출력결과 : 부서번호, 급여총합, 사원총합, 평균급여
출력시 부서번호를 기준으로 오름차순 정렬하시오. 
*/
select department_id 부서번호, sum(salary) 급여총합, count(*)사원총합, 
ltrim(to_char(avg(salary), '$999,000')) 평균급여
from employees
group by department_id
order by department_id;








