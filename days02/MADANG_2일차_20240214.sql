-- MADANG
SELECT *
FROM book;

SELECT *
FROM tabs;

DESC imported_book;
BOOKID       NUMBER       å id
BOOKNAME     VARCHAR2(40) å �̸�
PUBLISHER    VARCHAR2(40) ������
PRICE        NUMBER(8)    ���� 

SELECT *
FROM imported_book

DESC customer;

-- ���⼭�� 0���� �ٲٴ°͵� �����Ѱ� 0�� ���ڷ� ��ȯ�Ǿ� ������.
SELECT name "�̸�", NVL(phone, 0) "��ȭ��ȣ"
FROM customer;

