--  SYS
	SELECT *
--	FROM all_users;
	FROM dba_users;
    
    -- v$�� ������ ����
    select a.spid, b.name, c.server, c.type
    from v$process a, v$bgprocess b, v$session c
    where b.PADDR(+) = a.ADDR AND a.ADDR = c.PADDR
    AND b.NAME is NULL;
    -- ���̺����̽� ��ȸ(Ȯ��) --

    -- ���̺� �����̽� ��ȸ    
    SELECT *
    FROM dba_data_files;
    
    -- ���̺� �����̽� ��ȸ / ���̺� �����̽� �̸��� ���¸� ���
    SELECT tablespace_name,status 
    FROM dba_tablespaces;
    
    GRANT CONNECT, RESOURCE TO SCOTT;
    
