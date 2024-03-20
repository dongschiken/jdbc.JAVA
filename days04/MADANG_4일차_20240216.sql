-- MADANG


SELECT MAX(saleprice)
FROM orders
WHERE custid = 3;

SELECT orderid, custid, saleprice
FROM orders
WHERE saleprice > ALL ( SELECT saleprice
                     FROM orders
                     WHERE custid = 3);
                    -- ALL�� ���� �������������� ���� ��� ��ο� �񱳸� �Ѵ�. 6000, 12000, 13000�� ��κ��� saleprice�� ũ��??


SELECT orderid, custid, saleprice
FROM orders
WHERE saleprice > ANY ( SELECT saleprice
                     FROM orders
                     WHERE custid = 3);     
                      -- ANY�� ���� �������������� ���� ��� ��ο� �񱳸� �Ѵ�. 6000, 12000, 13000�� �߿� �ϳ��� ū�� �ִ�?
-- SOME, ANY : �ּ��� �Ѱ��� ������ ������ ��µȴ�.

-- ALL : ���������� ��� ����� �� 

-- EXISTS ���� 4-16
SELECT SUM(saleprice) sum , AVG(saleprice) avg, MAX(saleprice) max, MIN(saleprice) min
FROM orders;


SELECT custid
FROM customer
WHERE address LIKE '���ѹα�%';

SELECT sum(saleprice)
FROM orders
WHERE custid IN (2, 3, 5);

SELECT *
FROM customer;
