-- HR
SELECT commission_pct
FROM employees;
--
SELECT count(*) 
FROM employees 
WHERE commission_pct IS NOT NAN;

SELECT count(*) 
FROM employees 
WHERE commission_pct IS NOT NULL;


-- ���� : 1000�ڸ� ���� *�Ѱ��� ��ڴ�.
SELECT last_name, RPAD(' ',ROUND(salary/1000)+1, '*') "Salary"
    , salary
    , salary/1000 a
FROM employees
WHERE department_id = 80
ORDER BY last_name, "Salary";


select last_name, employee_id, hire_date -- �̸�, id, �Ի糯¥ �÷� ����
    ,   EXTRACT(year FROM hire_date) hire_year
from employees -- 1. employees ���̺���
where EXTRACT(year FROM hire_date) > 1998   -- 1998�� ���� �Ի��� ��� hire_date���� year�� �����ͼ�
order by hire_date;     -- hire_date�� �������� ASC����

SELECT '12'
    , TO_NUMBER('12')
    , 100 - '12'    -- ���ڿ��� ���ڸ� ���� ���ڷ� ��ȯ
    , '100' - '12'  -- ���ڿ��� ���ڸ� ���� ���ڷ� ��ȯ
FROM dual;


