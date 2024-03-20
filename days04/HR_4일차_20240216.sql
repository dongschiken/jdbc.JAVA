-- HR

-- ORA-00942: table or view does not exist  접근권한이 없어서 테이블을 못찾는다.
SELECT *
FROM arirang;

SELECT * 
FROM employees
WHERE salary =  ANY
               (SELECT salary 
                FROM employees
                WHERE department_id = 30);