--dml
DESC BOOK;
SELECT * FROM BOOK;
SELECT BOOKNAME,PRICE FROM BOOK;
SELECT PUBLISHER FROM BOOK;
SELECT DISTINCT PUBLISHER FROM BOOK;
SELECT * 
FROM BOOK
WHERE PRICE < 10000;
--Q. 가격이 10000원 이상 20000원 이하인 도서를 검색하세요.
SELECT * FROM BOOK WHERE 10000 <= PRICE AND PRICE <= 20000;
--Q. 출판사가 굿스포츠, 혹은 대한미디어인 도서를 검색하세요.
SELECT * FROM BOOK WHERE PUBLISHER = '굿스포츠' OR PUBLISHER = '대한미디어';
SELECT * FROM BOOK WHERE PUBLISHER IN ('굿스포츠','대한미디어');
--Q. 출판사가 굿스포츠, 혹은 대한미디어가 아닌 도서를 검색하세요.
SELECT * FROM BOOK WHERE PUBLISHER NOT IN ('굿스포츠','대한미디어');
--Q. 도서이름에 축구가 포함된 출판사를 검색하세요.
select PUBLISHER from BOOK where BOOKNAME like '%축구%';
select * from BOOK where BOOKNAME like '%축구%';
--[과제] 도서이름의 왼쪽 두 번째 위치에 구라는 문자열을 갖는 도서를 검색하세요.
-- _은 특정 위치의 한개의 문자와 일치
-- %은 0개 이상의 문자와 일치
SELECT BOOKNAME,PUBLISHER
FROM BOOK
WHERE BOOKNAME LIKE'_구%';
--[과제] 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하세요.
SELECT * 
FROM BOOK
WHERE BOOKNAME LIKE '%축구%' AND PRICE >= 20000;

SELECT * 
FROM BOOK
ORDER BY BOOKNAME;

SELECT * 
FROM BOOK
ORDER BY BOOKNAME DESC;

--Q. 도서를 가격순으로 검색하고 가격이 같으면 이름순으로 검색하세요.
SELECT * FROM BOOK ORDER BY PRICE,BOOKNAME;
--Q. 도서를 가격의 내림차순으로 검색하고 만약 가격이 같다면 출판사의 오름차순으로 출력하세요.
select * from book
order by price Desc,publisher;

SELECT * FROM ORDERS;
SELECT SUM(SALEPRICE)
FROM ORDERS;

SELECT SUM(SALEPRICE) AS "총매출"
FROM ORDERS;

--Q.CUSTID 가 2번인 고객이 주문한 도서의 총판매액을 구하세요.
select sum(SALEPRICE) AS "총 판매액" from ORDERS where CUSTID=2;
SELECT SUM(SALEPRICE) AS TOTAL,
AVG(SALEPRICE) AS AVERAGE,
MIN(SALEPRICE) AS MINIMUM,
MAX(SALEPRICE) AS MAXIMUM
FROM ORDERS;

SELECT COUNT(*) FROM ORDERS;

--Q. CUSTID별 도서수량과 총판매액을 출력하세요.
SELECT CUSTID, COUNT(*) AS 도서수량, SUM(SALEPRICE) AS "총 판매액"
FROM ORDERS
GROUP BY CUSTID;

--Q. 가격이 8000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하세요. 단 두권 이상 구매한 고객에 한정함
SELECT CUSTID, COUNT(*) AS 도서수량
FROM ORDERS
WHERE SALEPRICE >= 8000
GROUP BY CUSTID
HAVING COUNT(*) >= 2;

SELECT * FROM CUSTOMER;

SELECT * 
FROM CUSTOMER, ORDERS
WHERE CUSTOMER.CUSTID = ORDERS.CUSTID
ORDER BY CUSTOMER.CUSTID;

--Q. 고객별로 주문한 모든 도서의 총 판매액을 구하고 고객이름별로 정렬하세요.
SELECT NAME, SUM(SALEPRICE)
FROM CUSTOMER,ORDERS
WHERE CUSTOMER.CUSTID = ORDERS.CUSTID
GROUP BY CUSTOMER.NAME
ORDER BY CUSTOMER.NAME;

--Q. 고객의 이름과 고객이 주문한 도서의 이름을 구하세요.
SELECT CUSTOMER.NAME, BOOK.BOOKNAME
FROM CUSTOMER,ORDERS,BOOK
WHERE CUSTOMER.CUSTID = ORDERS.CUSTID AND ORDERS.BOOKID= BOOK.BOOKID;

SELECT C.NAME, B.BOOKNAME
FROM CUSTOMER C,ORDERS O,BOOK B
WHERE C.CUSTID = O.CUSTID AND O.BOOKID= B.BOOKID;

--[과제] 가격이 20,000인 도서를 주문한 고객의 이름과 도서의 이름을 구하세요.
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE
FROM BOOK B, CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID AND O.BOOKID=B.BOOKID AND B.PRICE=20000;

--[과제] 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하세요.
--outer join 조인조건을 만족하지 못하더라도 해당 행을 나타냄
SELECT C.NAME, O.SALEPRICE
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID(+);
--[과제] 가장 비싼 도서의 이름을 출력하세요.
SELECT BOOKNAME
FROM BOOK
WHERE PRICE=(SELECT MAX(PRICE) FROM BOOK);
SELECT * FROM BOOK;

--[과제] 도서를 구매한 적이 있는 고객의 이름을 검색하세요.
SELECT NAME
FROM CUSTOMER
WHERE CUSTID IN (SELECT CUSTID FROM ORDERS);
--[과제] 대한미디어에서 출판한 도서를 구매한 고객의 이름을 출력하세요.
SELECT NAME
FROM CUSTOMER
WHERE CUSTID IN (SELECT CUSTID FROM ORDERS
WHERE BOOKID IN (SELECT BOOKID FROM BOOK
WHERE PUBLISHER = '대한미디어'));

-- 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오
select b1.bookname
from book b1
where b1.price > (select avg(b2.price) from book b2 where b2.publisher = b1.publisher);

-- 도서를 주문하지 않은 고객의 이름을 보이시오.
select name
from customer
minus
select name
from customer
where custid in(select custid from orders);

-- 주문이 있는 고객의 이름과 주소를 보이시오
select name, address
from customer
where custid in(select custid from orders);
-- customer 테이블에서 고객번호가 5인 고객의 주소를 '대한민국 부산'으로 변경하시오
update customer
set address = '대한민국 부산'
where custid = 5;

select * from customer;

--박세리 고객의 주소를 김연아 고객의 주소로 변경
update customer c1
set c1.address = (select c2.address from customer c2 where c2.name = '김연아')
where c1.name = '박세리';

select * from customer;

delete customer
where custid=5;

select abs(-78), abs(+78) from dual;
select round(4.875,1) from dual;

-- 고객별 평균 주문 금액을 백원 단위로 반올림한 값을 구하시오
select custid, round(avg(saleprice),-2) from orders group by custid;
-- 도서 제목에 '야구'가 포함된 도서를 '농구'로 변경한 후 도서 목록 가격을 출력
select * from book;

select bookid, replace(bookname, '야구','농구') bookname, price 
from book;

-- '굿스포츠'에서 출판한 도서의 제목과 제목의 글자 수, 바이트 수를 보이시오.
select bookname, length(bookname), lengthb(bookname) from book where publisher = '굿스포츠';

insert into customer values(5,'박세리','대한민국 대전','000-9000-0001');

select substr(name,1,1) 성, count(*) 인원수
from customer
group by substr(name,1,1);

select orderid, orderdate, orderdate+10 "confirm"
from orders;

select orderid,to_char(orderdate, 'yyyy-mm-dd dy'), custid, bookid
from orders
where orderdate=to_date(20200707,'yyyymmdd');

select sysdate, to_char(sysdate,'yyyy/mm/dd dy hh24:mi:ss') from dual;

select rownum "순번", custid, name, phone
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
WHERE custid IN(SELECT custid FROM customer WHERE address LIKE '%대한민국%');

SELECT orderid, saleprice
FROM orders
WHERE saleprice > ALL(SELECT saleprice FROM orders WHERE custid='3');

SELECT SUM(saleprice)
FROM orders od
WHERE EXISTS(SELECT * FROM customer cs WHERE address LIKE '%대한민국%' AND cs.custid=od.custid);

SELECT * FROM employees;

-- employees 테이블에서 commision_pct의 null 값 개수를 출력하세요
SELECT COUNT(*)
FROM employees
WHERE commission_pct is null;
-- employees 테이블에서 employee_id가 홀수 인것만 출력하세요
SELECT employee_id
FROM employees
WHERE MOD(employee_id,2) = 1;
-- job_id의 문자 길이를 구하세요
SELECT job_id, LENGTH(job_id) FROM employees;
-- job_id 별로 연봉합계, 연봉평균, 최고연봉, 최저연봉 출력
SELECT job_id, SUM(salary), AVG(salary), MAX(salary), MIN(salary) FROM employees GROUP BY job_id;
-- 입사일 6개월 후 첫번째 월요일을 직원이름별로 출력
SELECT first_name, last_name, TO_CHAR(ADD_MONTHS(hire_date,6)+MOD(9-TO_CHAR(ADD_MONTHS(hire_date,6),'d'),7),'yyyy/mm/dd') "6개월 후 월요일" ,TO_CHAR(ADD_MONTHS(hire_date,6)+MOD(9-TO_CHAR(ADD_MONTHS(hire_date,6),'d'),7),'dy')  "요일"  FROM employees;
-- job_id별로 연봉합계 연봉평균 최고연봉, 최저연봉 출력, 단 평균연봉이 5000 이상인 경우만 포함
SELECT job_id, SUM(salary), AVG(salary), MAX(salary), MIN(salary) FROM (SELECT * FROM employees WHERE salary > 5000) GROUP BY job_id;
-- 뷰 생성
CREATE VIEW vw_customer
AS SELECT *
FROM customer
WHERE address LIKE '%대한민국%';


