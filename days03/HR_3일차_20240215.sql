-- HR

DESC employees;

SELECT first_name, last_name, first_name ||' '||last_name "NAME"
FROM employees;

SELECT *
FROM tabs;


-- [NOT] LIKE SQL ������ ����
-- ������ ���� ��ġ ���� üũ�ϴ� ������
-- ���ϵ� ī�� ( %, _ ) ��ȣ�� �̷��� �ΰ��� ��� ����
-- % : 0 ~ ���� ���� ����
-- _ : �� ���� ����
-- ���ϵ� ī�带 �Ϲ� ����ó�� ����Ϸ��� ESCAPE �ɼ��� ����϶�...

SELECT last_name, salary 
FROM employees
WHERE last_name LIKE 'R%'
ORDER BY salary;


SELECT last_name, salary 
FROM employees
WHERE last_name = 'R%'
ORDER BY salary;


SELECT last_name, salary 
FROM employees
-- R�� �����ϰ� �� �ڿ� ���ڰ� 3�� ���� �� Rajs
WHERE last_name LIKE 'R___'  --  �� underscore(_)�� 3����
ORDER BY salary;

