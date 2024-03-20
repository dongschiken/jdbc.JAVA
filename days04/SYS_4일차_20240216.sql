-- SYS

SELECT *
FROM dba_tables
WHERE owner = 'SCOTT';

-- ���� ������ �ƴ� ���̺��� �����ϰ� �������� �� ��Ű�� ���� �ٿ�����Ѵ�.
-- scott.emp : SCOTT�� emp���̺��� ����ϰڴ�.
SELECT *
FROM arirang;

-- SYNONYM ARIRANG��(��) �����Ǿ����ϴ�.
CREATE PUBLIC SYNONYM arirang
FOR scott.emp;

-- SYNONYM ����
DROP PUBLIC SYNONYM arirang;

SELECT *
FROM all_SYNONYMS
WHERE synonym_name = 'ARIRANG';