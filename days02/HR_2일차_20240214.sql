-- HR ������ �����ϰ� �ִ� ���̺� ������ ��ȸ
SELECT *
FROM tabs;







-- 1) REGIONS
DESC regions; -- "��� ����"�� ������ �ִ� ���̺�
REGION_ID   NOT NULL NUMBER       ���� not null
REGION_NAME          VARCHAR2(25) ���ڿ�
SELECT *
FROM regions;


-- 2) COUNTRIES
DESC countries; -- "���� ����"�� ������ �ִ� ���̺�
COUNTRY_ID   NOT NULL CHAR(2)      ���� id
COUNTRY_NAME          VARCHAR2(40) ���� ��
REGION_ID             NUMBER       ��� id��
SELECT *
FROM countries; 


-- 3) LOCATIONS -- "��ġ ����"�� ������ �ִ� ���̺�
DESC locations;
LOCATION_ID    NOT NULL NUMBER(4)    ��ġ ��ȣ 
STREET_ADDRESS          VARCHAR2(40) �ּ�
POSTAL_CODE             VARCHAR2(12) ���� ��ȣ
CITY           NOT NULL VARCHAR2(30) ����
STATE_PROVINCE          VARCHAR2(25) ��
COUNTRY_ID              CHAR(2)     ���� id
SELECT *
FROM locations;


-- 4) DEPARTMENTS -- "�μ� ����"�� ������ �ִ� ���̺� (�μ���ȣ, �μ���, ������ id, ��ġ id)
SELECT *
FROM departments;


-- 5) JOBS -- "���� ����"�� ������ �ִ� ���̺� ( ���� ID, ���� �̸�, �ּ� ���, �ִ� ���)
SELECT *
FROM jobs;


-- 6) EMPLOYEES -- "��� ����"�� ������ �ִ� ���̺� (��� ID, ��� ��, �̸�, �̸��� �޴��� ��ȣ...)
SELECT *
FROM employees;


-- 7) JOB_HISTORY -- "���� ����" ������ ������ �ִ� ���̺� 
DESC job_history;
EMPLOYEE_ID   NOT NULL NUMBER(6)    ��� id
START_DATE    NOT NULL DATE         ���� ��¥
END_DATE      NOT NULL DATE         ������ ��¥
JOB_ID        NOT NULL VARCHAR2(10) ���� id
DEPARTMENT_ID          NUMBER(4)    �μ� id
SELECT *
FROM job_history;


SELECT *
FROM employees
WHERE employee_id = 101;

DESC employees;
--ORA-01722: invalid number
-- ���� �߻��ϸ� � �κп��� ���� ������ ���������� �˷��ֱ�
-- ����Ŭ ������ ���ڿ� �Ǵ� ��¥ �տ� ' ' �� ���δ�. (" " ��� X)
-- ���ڿ� ���� ������ : ||
-- ���ڿ� ���� �Լ� : CONCAT
SELECT  employee_id, 
--        first_name, last_name,
--        first_name || ' ' || last_name name,
        CONCAT (CONCAT(  first_name , ' ' ) ,last_name) AS "NAME",
        hire_date
FROM    employees;


SELECT '�̸���'|| last_name || '�̰�, ������ ' || job_id || ' �̴�.'
FROM employees;


SELECT *
FROM employees;
-- ���� ���̺��� �����ȣ, ����̸�, �Ի����� �÷��� ���

