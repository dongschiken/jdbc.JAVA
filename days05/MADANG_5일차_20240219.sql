-- MADNAG

SELECT *
FROM orders;



SELECT EXTRACT(month FROM orderdate) "month", -- 3. �׷�ȭ ��Ų ������ �ֹ��� Ƚ�� üũ 
COUNT(orderdate) "Orders"
FROM orders -- 1. �ֹ����̺���
GROUP BY EXTRACT(month FROM orderdate) -- 2. orderdate�� ���� �ٲ㼭 ������ �׷������
ORDER BY 'Orders' DESC; -- 4. �ֹ� Ƚ�� ���� desc


DESC orders;

