-- HR

-- ORA-00942: table or view does not exist  ���ٱ����� ��� ���̺��� ��ã�´�.
SELECT *
FROM arirang;

SELECT * 
FROM employees
WHERE salary =  ANY
               (SELECT salary 
                FROM employees
                WHERE department_id = 30);