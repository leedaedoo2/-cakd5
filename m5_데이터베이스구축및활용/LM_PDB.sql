SELECT * FROM CUSTDEMO;
SELECT COUNT(*) FROM PURPROD;
SELECT * FROM PURPROD;

--2014 ~ 2015�� ������ 4�� ȸ�� ���� ������

ALTER TABLE PURPROD ADD YEAR NUMBER;
UPDATE PURPROD SET YEAR=substr(��������,1,4);
COMMIT;

ALTER TABLE PURPROD DROP COLUMN MONTH;

SELECT * FROM PURPROD;
COMMIT;
CREATE TABLE PURBYYEAR AS
SELECT ����ȣ, YEAR, SUM(���űݾ�) ���ž�
FROM PURPROD
GROUP BY ����ȣ, YEAR
ORDER BY ����ȣ;

SELECT * FROM PURBYYEAR;




CREATE TABLE pur_amt AS
SELECT ����ȣ cusno, sum(���űݾ�) puramt
FROM PURPROD
GROUP BY ����ȣ 
ORDER BY ����ȣ;

-- ���� �м�(���� �м�)
SELECT YEAR, ROUND(SUM(���űݾ�)) �ѱ��ž�, ROUND(AVG(���űݾ�)) ��ձ��ž�
FROM PURPROD
GROUP BY YEAR;

-- �� �Ӽ�
-- ����, ���ɺ�, ��������, �پ��� ���պ�
-- ����� �̿� ����, ����� �̿�, �¶��� ä�ο� ���� ���� Ư�̼�

-- ���� �ൿ ������ ��ȭ
-- �پ��� �� ������ ���� ����, ��ǰ ���� ����, ���� ����(�ð� , ��� ��)

-- ���� ȯ�濡 ���� ����( ������)
drop table purprod;

SELECT A.SID
     , A.SERIAL#
     , A.STATUS
  FROM V$SESSION A
     , V$LOCK B
     , DBA_OBJECTS C
 WHERE A.SID         = B.SID
   AND B.ID1         = C.OBJECT_ID
   AND B.TYPE        = 'TM'
   AND C.OBJECT_NAME = 'PURPROD';
   
   ALTER SYSTEM KILL SESSION '981,13386';
   
   drop table purprod;
   
SELECT
X.SID,
X.USERNAME,
X.OSUSER,
X.PROCESS AS FG_PID,
Y.SPID BG_PID
FROM V$SESSION X, V$PROCESS Y
WHERE X.PADDR = Y.ADDR ;
