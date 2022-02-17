--dml
DESC BOOK;
SELECT * FROM BOOK;
SELECT BOOKNAME,PRICE FROM BOOK;
SELECT PUBLISHER FROM BOOK;
SELECT DISTINCT PUBLISHER FROM BOOK;
SELECT * 
FROM BOOK
WHERE PRICE < 10000;
--Q. ������ 10000�� �̻� 20000�� ������ ������ �˻��ϼ���.
SELECT * FROM BOOK WHERE 10000 <= PRICE AND PRICE <= 20000;
--Q. ���ǻ簡 �½�����, Ȥ�� ���ѹ̵���� ������ �˻��ϼ���.
SELECT * FROM BOOK WHERE PUBLISHER = '�½�����' OR PUBLISHER = '���ѹ̵��';
SELECT * FROM BOOK WHERE PUBLISHER IN ('�½�����','���ѹ̵��');
--Q. ���ǻ簡 �½�����, Ȥ�� ���ѹ̵� �ƴ� ������ �˻��ϼ���.
SELECT * FROM BOOK WHERE PUBLISHER NOT IN ('�½�����','���ѹ̵��');
--Q. �����̸��� �౸�� ���Ե� ���ǻ縦 �˻��ϼ���.
select PUBLISHER from BOOK where BOOKNAME like '%�౸%';
select * from BOOK where BOOKNAME like '%�౸%';
--[����] �����̸��� ���� �� ��° ��ġ�� ����� ���ڿ��� ���� ������ �˻��ϼ���.
-- _�� Ư�� ��ġ�� �Ѱ��� ���ڿ� ��ġ
-- %�� 0�� �̻��� ���ڿ� ��ġ
SELECT BOOKNAME,PUBLISHER
FROM BOOK
WHERE BOOKNAME LIKE'_��%';
--[����] �౸�� ���� ���� �� ������ 20,000�� �̻��� ������ �˻��ϼ���.
SELECT * 
FROM BOOK
WHERE BOOKNAME LIKE '%�౸%' AND PRICE >= 20000;

SELECT * 
FROM BOOK
ORDER BY BOOKNAME;

SELECT * 
FROM BOOK
ORDER BY BOOKNAME DESC;

--Q. ������ ���ݼ����� �˻��ϰ� ������ ������ �̸������� �˻��ϼ���.
SELECT * FROM BOOK ORDER BY PRICE,BOOKNAME;
--Q. ������ ������ ������������ �˻��ϰ� ���� ������ ���ٸ� ���ǻ��� ������������ ����ϼ���.
select * from book
order by price Desc,publisher;

SELECT * FROM ORDERS;
SELECT SUM(SALEPRICE)
FROM ORDERS;

SELECT SUM(SALEPRICE) AS "�Ѹ���"
FROM ORDERS;

--Q.CUSTID �� 2���� ���� �ֹ��� ������ ���Ǹž��� ���ϼ���.
select sum(SALEPRICE) AS "�� �Ǹž�" from ORDERS where CUSTID=2;
SELECT SUM(SALEPRICE) AS TOTAL,
AVG(SALEPRICE) AS AVERAGE,
MIN(SALEPRICE) AS MINIMUM,
MAX(SALEPRICE) AS MAXIMUM
FROM ORDERS;

SELECT COUNT(*) FROM ORDERS;

--Q. CUSTID�� ���������� ���Ǹž��� ����ϼ���.
SELECT CUSTID, COUNT(*) AS ��������, SUM(SALEPRICE) AS "�� �Ǹž�"
FROM ORDERS
GROUP BY CUSTID;

--Q. ������ 8000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���ϼ���. �� �α� �̻� ������ ���� ������
SELECT CUSTID, COUNT(*) AS ��������
FROM ORDERS
WHERE SALEPRICE >= 8000
GROUP BY CUSTID
HAVING COUNT(*) >= 2;

SELECT * FROM CUSTOMER;

SELECT * 
FROM CUSTOMER, ORDERS
WHERE CUSTOMER.CUSTID = ORDERS.CUSTID
ORDER BY CUSTOMER.CUSTID;

--Q. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ� ���̸����� �����ϼ���.
SELECT NAME, SUM(SALEPRICE)
FROM CUSTOMER,ORDERS
WHERE CUSTOMER.CUSTID = ORDERS.CUSTID
GROUP BY CUSTOMER.NAME
ORDER BY CUSTOMER.NAME;

--Q. ���� �̸��� ���� �ֹ��� ������ �̸��� ���ϼ���.
SELECT CUSTOMER.NAME, BOOK.BOOKNAME
FROM CUSTOMER,ORDERS,BOOK
WHERE CUSTOMER.CUSTID = ORDERS.CUSTID AND ORDERS.BOOKID= BOOK.BOOKID;

SELECT C.NAME, B.BOOKNAME
FROM CUSTOMER C,ORDERS O,BOOK B
WHERE C.CUSTID = O.CUSTID AND O.BOOKID= B.BOOKID;

--[����] ������ 20,000�� ������ �ֹ��� ���� �̸��� ������ �̸��� ���ϼ���.
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE
FROM BOOK B, CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID AND O.BOOKID=B.BOOKID AND B.PRICE=20000;

--[����] ������ �������� ���� ���� �����Ͽ� ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� ���ϼ���.
--outer join ���������� �������� ���ϴ��� �ش� ���� ��Ÿ��
SELECT C.NAME, O.SALEPRICE
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID(+);
--[����] ���� ��� ������ �̸��� ����ϼ���.
SELECT BOOKNAME
FROM BOOK
WHERE PRICE=(SELECT MAX(PRICE) FROM BOOK);
SELECT * FROM BOOK;

--[����] ������ ������ ���� �ִ� ���� �̸��� �˻��ϼ���.
SELECT NAME
FROM CUSTOMER
WHERE CUSTID IN (SELECT CUSTID FROM ORDERS);
--[����] ���ѹ̵��� ������ ������ ������ ���� �̸��� ����ϼ���.
SELECT NAME
FROM CUSTOMER
WHERE CUSTID IN (SELECT CUSTID FROM ORDERS
WHERE BOOKID IN (SELECT BOOKID FROM BOOK
WHERE PUBLISHER = '���ѹ̵��'));

-- ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ������ ���Ͻÿ�
select b1.bookname
from book b1
where b1.price > (select avg(b2.price) from book b2 where b2.publisher = b1.publisher);

-- ������ �ֹ����� ���� ���� �̸��� ���̽ÿ�.
select name
from customer
minus
select name
from customer
where custid in(select custid from orders);

-- �ֹ��� �ִ� ���� �̸��� �ּҸ� ���̽ÿ�
select name, address
from customer
where custid in(select custid from orders);
-- customer ���̺��� ����ȣ�� 5�� ���� �ּҸ� '���ѹα� �λ�'���� �����Ͻÿ�
update customer
set address = '���ѹα� �λ�'
where custid = 5;

select * from customer;

--�ڼ��� ���� �ּҸ� �迬�� ���� �ּҷ� ����
update customer c1
set c1.address = (select c2.address from customer c2 where c2.name = '�迬��')
where c1.name = '�ڼ���';

select * from customer;

delete customer
where custid=5;

select abs(-78), abs(+78) from dual;
select round(4.875,1) from dual;

-- ���� ��� �ֹ� �ݾ��� ��� ������ �ݿø��� ���� ���Ͻÿ�
select custid, round(avg(saleprice),-2) from orders group by custid;
-- ���� ���� '�߱�'�� ���Ե� ������ '��'�� ������ �� ���� ��� ������ ���
select * from book;

select bookid, replace(bookname, '�߱�','��') bookname, price 
from book;

-- '�½�����'���� ������ ������ ����� ������ ���� ��, ����Ʈ ���� ���̽ÿ�.
select bookname, length(bookname), lengthb(bookname) from book where publisher = '�½�����';

insert into customer values(5,'�ڼ���','���ѹα� ����','000-9000-0001');

select substr(name,1,1) ��, count(*) �ο���
from customer
group by substr(name,1,1);

select orderid, orderdate, orderdate+10 "confirm"
from orders;

select orderid,to_char(orderdate, 'yyyy-mm-dd dy'), custid, bookid
from orders
where orderdate=to_date(20200707,'yyyymmdd');

select sysdate, to_char(sysdate,'yyyy/mm/dd dy hh24:mi:ss') from dual;

select rownum "����", custid, name, phone
from customer
where rownum <=2;

select orderid, saleprice
from orders
where saleprice <= (select avg(saleprice) from orders);

SELECT orderid, custid, saleprice
FROM orders md
WHERE saleprice > (SELECT AVG(saleprice) FROM orders so WHERE md.custid = so.custid);

SELECT SUM(saleprice)
FROM orders
WHERE custid IN(SELECT custid FROM customer WHERE address LIKE '%���ѹα�%');

SELECT orderid, saleprice
FROM orders
WHERE saleprice > ALL(SELECT saleprice FROM orders WHERE custid='3');

SELECT SUM(saleprice)
FROM orders od
WHERE EXISTS(SELECT * FROM customer cs WHERE address LIKE '%���ѹα�%' AND cs.custid=od.custid);

SELECT * FROM employees;

-- employees ���̺��� commision_pct�� null �� ������ ����ϼ���
SELECT COUNT(*)
FROM employees
WHERE commission_pct is null;
-- employees ���̺��� employee_id�� Ȧ�� �ΰ͸� ����ϼ���
SELECT employee_id
FROM employees
WHERE MOD(employee_id,2) = 1;
-- job_id�� ���� ���̸� ���ϼ���
SELECT job_id, LENGTH(job_id) FROM employees;
-- job_id ���� �����հ�, �������, �ְ���, �������� ���
SELECT job_id, SUM(salary), AVG(salary), MAX(salary), MIN(salary) FROM employees GROUP BY job_id;
-- �Ի��� 6���� �� ù��° �������� �����̸����� ���
SELECT first_name, last_name, TO_CHAR(ADD_MONTHS(hire_date,6)+MOD(9-TO_CHAR(ADD_MONTHS(hire_date,6),'d'),7),'yyyy/mm/dd') "6���� �� ������" ,TO_CHAR(ADD_MONTHS(hire_date,6)+MOD(9-TO_CHAR(ADD_MONTHS(hire_date,6),'d'),7),'dy')  "����"  FROM employees;
-- job_id���� �����հ� ������� �ְ���, �������� ���, �� ��տ����� 5000 �̻��� ��츸 ����
SELECT job_id, SUM(salary), AVG(salary), MAX(salary), MIN(salary) FROM (SELECT * FROM employees WHERE salary > 5000) GROUP BY job_id;
-- �� ����
CREATE VIEW vw_customer
AS SELECT *
FROM customer
WHERE address LIKE '%���ѹα�%';


