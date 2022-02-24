SELECT * FROM CUSTDEMO;
SELECT COUNT(*) FROM PURPROD;
SELECT * FROM PURPROD;

--2014 ~ 2015년 사이의 4개 회사 구매 데이터

ALTER TABLE PURPROD ADD YEAR NUMBER;
UPDATE PURPROD SET YEAR=substr(구매일자,1,4);
COMMIT;

ALTER TABLE PURPROD DROP COLUMN MONTH;

SELECT * FROM PURPROD;
COMMIT;
CREATE TABLE PURBYYEAR AS
SELECT 고객번호, YEAR, SUM(구매금액) 구매액
FROM PURPROD
GROUP BY 고객번호, YEAR
ORDER BY 고객번호;

SELECT * FROM PURBYYEAR;




CREATE TABLE pur_amt AS
SELECT 고객번호 cusno, sum(구매금액) puramt
FROM PURPROD
GROUP BY 고객번호 
ORDER BY 고객번호;

-- 구매 분석(매출 분석)
SELECT YEAR, ROUND(SUM(구매금액)) 총구매액, ROUND(AVG(구매금액)) 평균구매액
FROM PURPROD
GROUP BY YEAR;

-- 고객 속성
-- 성별, 연령별, 거주지별, 다양한 조합별
-- 경쟁사 이용 형태, 멤버십 이용, 온라인 채널에 대한 매출 특이성

-- 구매 행동 패턴의 변화
-- 다양한 고객 유형별 구매 증감, 상품 구매 패턴, 구매 형태(시간 , 장소 등)

-- 유통 환경에 대한 이해( 도메인)
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
