-- Active: 1695730306959@@127.0.0.1@3308@db_school
#创建数据库 
 CREATE DATABASE db_school
 DEFAULT CHARACTER SET GB2312
 DEFAULT COLLATE GB2312_chinese_ci;

 ALTER DATABASE db_school
 DEFAULT CHARACTER SET gb2312
 DEFAULT COLLATE gb2312_chinese_ci;

 USE db_school
 CREATE TABLE tb_student
 (
    studentNo CHAR(10) NOT NULL UNIQUE,
    studentName VARCHAR(20)NOT NULL,
    sex CHAR(2),
    birthday DATE,
    native VARCHAR(20),
    nation VARCHAR(10),
    classNo CHAR(6)
 ) ENGINE=InnoDB;


 CREATE TABLE tb_student1
 (
    studentNo INT(10) NOT NULL UNIQUE AUTO_INCREMENT,
    studentName VARCHAR(20)NOT NULL,
    sex CHAR(2),
    birthday DATE,
    native VARCHAR(20),
    nation VARCHAR(10),
    classNo CHAR(6)
 ) ENGINE=InnoDB;

 CREATE TABLE tb_student2
 (
    studentNo CHAR(10) NOT NULL UNIQUE,
    studentName VARCHAR(20)NOT NULL,
    sex CHAR(2),
    birthday DATE,
    native VARCHAR(20),
    nation VARCHAR(10) DEFAULT'汉',
    classNo CHAR(6)
 ) ENGINE=InnoDB;

 DROP TABLE tb_student;
 CREATE TABLE db_school.tb_student
 (
    studentNo CHAR(10),
    studentName VARCHAR(20)NOT NULL,
    sex CHAR(2) NOT NULL,
    birthday DATE,
    native VARCHAR(20),
    nation VARCHAR(10) DEFAULT'汉',
    classNo CHAR(6),
    CONSTRAINT PK_student PRIMARY KEY(studentNo)
 ) ENGINE=InnoDB;

CREATE TABLE tb_class
(
   classNo CHAR(6) PRIMARY KEY,
   className VARCHAR(20) NOT NULL  UNIQUE,
   department VARCHAR(30) NOT NULL,
   grade SMALLINT,
   classNum TINYINT
)ENGINE=InnoDB;

DROP TABLE tb_class;

CREATE TABLE tb_class
(
   classNo CHAR(6) PRIMARY KEY,
   className VARCHAR(20) NOT NULL,
   department VARCHAR(30) NOT NULL,
   grade SMALLINT,
   classNum TINYINT,
   CONSTRAINT UQ_class UNIQUE(className)
)ENGINE=InnoDB;

CREATE TABLE tb_course
(
   courseNo CHAR(6),
   courseName VARCHAR(20) NOT NULL,
   credit INT NOT NULL,
   courseHour INT NOT NULL,
   term CHAR(2),
   priorCourse CHAR(6),
   CONSTRAINT PK_course PRIMARY KEY(courseNo),
   CONSTRAINT FK_course FOREIGN KEY(priorCourse)
   REFERENCES tb_course(courseNo),
   CONSTRAINT CK_course CHECK(credit=courseHour/16)
)ENGINE=InnoDB;

CREATE TABLE tb_score
(
   studentNo CHAR(10),
   courseNo CHAR(6),
   score FLOAT CHECK(score>=0 AND score<=100),
   CONSTRAINT PK_score PRIMARY KEY(studentNo,courseNo),
   CONSTRAINT FK_score1 FOREIGN KEY(studentNo)
   REFERENCES tb_student(studentNo),
   CONSTRAINT FK_score2 FOREIGN KEY(courseNo)
   REFERENCES tb_course(courseNo)
)ENGINE=InnoDB;

CREATE DATABASE db_sp
DEFAULT CHARACTER SET GB2312
DEFAULT COLLATE GB2312_chinese_ci;

CREATE TABLE S 
(
   SNO CHAR(5),
   SNAME VARCHAR(20) NOT NULL UNIQUE,
   STATUS SMALLINT,
   CITY VARCHAR(20),
   CONSTRAINT PK_S PRIMARY KEY (SNO),
   CONSTRAINT CK_S CHECK(CITY != 'London' OR STATUS=20)
)ENGINE=InnoDB;

CREATE TABLE P 
(
   PNO CHAR(5),
   PNAME VARCHAR(15) NOT NULL,
   COLOR VARCHAR(10) CHECK(COLOR IN ('Red','Yellow','Green','Blue')),
   WEIGHT INT,
   CONSTRAINT PK_P PRIMARY KEY (PNO) 
)ENGINE=InnoDB;

CREATE TABLE SP
(
   SNO CHAR(5),
   PNO CHAR(5),
   QTY INT,
   CONSTRAINT PK_SPJ PRIMARY KEY (SNO,PNO),
   CONSTRAINT FK_SPJ1 FOREIGN KEY (SNO)  REFERENCES S (SNO),
   CONSTRAINT FK_SPJ2 FOREIGN KEY (PNO)  REFERENCES P (PNO)
)ENGINE=InnoDB;
 
SELECT classNo,department,className 
FROM tb_class;

SELECT DISTINCT department 
FROM tb_class;

SELECT * 
FROM tb_course;

SELECT studentName,sex,'Age:',YEAR(NOW())-YEAR(birthday) 
FROM tb_student;

SELECT studentName AS 姓名,sex 性别,YEAR(NOW())-YEAR(birthday) 年龄 
FROM tb_student;

SELECT courseName,credit,courseHour 
FROM tb_course 
WHERE courseHour>=64;

SELECT studentNo,studentName,native,nation 
FROM tb_student 
WHERE nation!='汉' and sex ='男';

SELECT studentName,sex,birthday 
FROM tb_student 
WHERE birthday BETWEEN '1996-01-01'AND'1996-12-31';

SELECT studentName,sex,birthday 
FROM tb_student 
WHERE birthday NOT BETWEEN '1996-01-01'AND'1996-12-31';

SELECT * 
FROM tb_student 
WHERE native IN ('北京','天津','上海');

SELECT * 
FROM tb_student 
WHERE native NOT IN ('北京','天津','上海');

SELECT studentNo,studentName,classNo 
FROM tb_student 
WHERE studentName LIKE  '李%';

SELECT studentNo,studentName,classNo 
FROM tb_student 
WHERE studentName NOT LIKE  '李%';

SELECT studentNo,studentName,classNo 
FROM tb_student 
WHERE studentName LIKE  '%明%';

SELECT studentNo,studentName,classNo 
FROM tb_student 
WHERE studentName LIKE  '李__';

SELECT * 
FROM tb_course 
WHERE courseName LIKE '%#_%'ESCAPE '#';

SELECT * 
FROM tb_course 
WHERE courseName REGEXP '系统';

SELECT * 
FROM tb_course 
WHERE courseName LIKE '%系统%';

SELECT * 
FROM tb_course 
WHERE courseName REGEXP '管理|信息|系统';

SELECT * 
FROM tb_course 
WHERE priorCourse IS NULL;

SELECT * 
FROM tb_course 
WHERE term=2 AND courseHour>=32;

SELECT studentName,native,nation 
FROM tb_student 
WHERE (native='北京' OR native='湖南')AND nation != '汉' AND sex='男';

SELECT studentName,birthday,native 
FROM tb_student 
ORDER BY birthday DESC; 

SELECT * 
FROM tb_score 
WHERE score>90 
ORDER BY courseNo,score DESC;

SELECT studentNo,courseNo,score 
FROM tb_score 
ORDER BY score DESC LIMIT 4,6;

SELECT COUNT(*) 
FROM tb_course;

SELECT COUNT(DISTINCT studentNo)
FROM tb_score;

SELECT AVG(score),MAX(score)
FROM tb_score 
WHERE courseNo='21004';

SELECT courseNo,COUNT(studentNo) 
FROM tb_score 
GROUP BY courseNo;

SELECT studentNo,COUNT(*)选课门数,AVG(score)平均分,MAX(score)最高分 
FROM tb_score 
GROUP BY studentNo;

SELECT studentNo,COUNT(*)选课门数,AVG(score)平均分,MAX(score)最高分 
FROM tb_score 
GROUP BY studentNo 
HAVING AVG(score)>=90;

SELECT studentNo,COUNT(*)课程数 
FROM tb_score 
WHERE score>88 
GROUP BY studentNo 
HAVING COUNT(*)>=2;

SELECT AVG(score)平均分 
FROM tb_score 
HAVING AVG(score)>=80;

SELECT * 
FROM tb_student,tb_score;

SELECT tb_student.*,tb_score.* 
FROM tb_student,tb_score 
WHERE tb_student.studentNo=tb_score.studentNo;

SELECT studentNo,studentName,native,tb_student.classNo,className 
FROM tb_student,tb_class 
WHERE tb_student.classNo=tb_class.classNo AND department='会计学院';

SELECT a.studentNo,studentName,score
FROM tb_student a,tb_course b,tb_score c
WHERE a.studentNo=c.studentNo AND b.courseNo=c.courseNo
AND courseName='程序设计';

SELECT b.courseNo,courseName,score
FROM tb_student a,tb_course b,tb_score c
WHERE a.studentNo=c.studentNo AND b.courseNo=c.courseNo
AND studentName='江山';

SELECT c1.*
FROM tb_course c1,tb_course c2 
WHERE c1.credit=c2.credit AND c2.courseName='数据库';

SELECT a.studentNo,studentName,sex,classNo,courseNo,score 
FROM tb_student a LEFT OUTER JOIN tb_score b
ON a.studentNo=b.studentNo;

SELECT a.studentNo,studentName,sex,classNo,courseNo,score 
FROM tb_student a RIGHT OUTER JOIN tb_score b
ON a.studentNo=b.studentNo;

SELECT studentName
FROM tb_student
WHERE tb_student.studentNo IN(SELECT DISTINCT tb_score.studentNo FROM tb_score);

SELECT DISTINCT studentName
FROM tb_student,tb_score
WHERE tb_student.studentNo=tb_score.studentNo;

SELECT studentName
FROM tb_student
WHERE tb_student.studentNo NOT IN (SELECT DISTINCT tb_score.studentNo FROM tb_score);

SELECT c1.*
FROM tb_student c1,tb_student c2 
WHERE c1.native=c2.native AND c2.studentName='王一敏';

SELECT c1.*
FROM tb_student c1,tb_student c2 
WHERE c1.classNo=c2.classNo AND c2.studentName='李明';

SELECT c1.*
FROM tb_course c1,tb_course c2 
WHERE c1.priorCourse=c2.priorCourse AND c2.courseName='程序设计';

SELECT c1.*
FROM tb_student c1,tb_student c2 
WHERE YEAR(c1.birthday)=YEAR(c2.birthday) AND c2.studentName='王林';

SELECT c1.*
FROM tb_student c1,tb_student c2 
WHERE c1.nation=c2.nation AND c2.studentName='张晓勇';

SELECT studentNo,studentName
FROM tb_student
WHERE classNo =
(SELECT classNo FROM tb_class
WHERE className='计算机14-1班');

SELECT studentNo,studentName
FROM tb_student c1,tb_class c2 
WHERE c1.classNo=c2.classNo AND c2.className='计算机14-1班';

SELECT studentNo,studentName,classNo
FROM tb_student s1 
WHERE classNo=
(SELECT classNo FROM tb_student s2
WHERE studentName='刘涛') AND studentName!= '刘涛';

SELECT s1.studentNo,s1.studentName,s1.classNo
FROM tb_student s1,tb_student s2
WHERE s1.classNo=s2.classNo AND s2.studentName = '刘涛' AND s1.studentName!= '刘涛';

SELECT studentName,YEAR(birthday)
FROM tb_student
WHERE sex='男'AND YEAR(birthday)>ANY(
   SELECT YEAR(birthday) FROM tb_student WHERE sex='女'
);

SELECT studentName,YEAR(birthday)
FROM tb_student
WHERE sex='男'AND YEAR(birthday)> (
    SELECT MIN(YEAR(birthday)) FROM tb_student WHERE sex = '女'
);

SELECT studentName,YEAR(birthday)
FROM tb_student
WHERE sex='男'AND YEAR(birthday)>ALL(
   SELECT YEAR(birthday) FROM tb_student WHERE sex='女'
);

SELECT studentName,YEAR(birthday)
FROM tb_student
WHERE sex='男'AND YEAR(birthday)> (
    SELECT MAX(YEAR(birthday)) FROM tb_student WHERE sex = '女'
);

SELECT studentName
FROM tb_student a 
WHERE EXISTS
(
   SELECT * FROM tb_score b 
   WHERE a.studentNo=b.studentNo AND courseNo='31002' 
);

SELECT studentName
FROM tb_student 
WHERE studentNo IN (
   SELECT studentNo
   FROM tb_score
   WHERE courseNo='31002'
);

SELECT studentName
FROM tb_student a 
WHERE NOT EXISTS
(
   SELECT * FROM tb_score b 
   WHERE a.studentNo=b.studentNo AND courseNo='31002' 
);

SELECT studentName
FROM tb_student 
WHERE studentNo NOT IN (
   SELECT studentNo
   FROM tb_score
   WHERE courseNo='31002'
);

SELECT studentName
FROM tb_student x
WHERE NOT EXISTS(
   SELECT * FROM tb_course c 
   WHERE NOT EXISTS(
      SELECT * FROM tb_score
      WHERE studentNo=x.studentNo
      AND courseNo=c.courseNo
   )
);

SELECT studentName
FROM tb_student a 
WHERE EXISTS
(
   SELECT * FROM tb_score b 
   WHERE a.studentNo=b.studentNo AND b.score >= 85
);

SELECT studentNo
FROM tb_score,tb_course
WHERE tb_score.courseNo=tb_course.courseNo AND courseName='管理学'
UNION
SELECT studentNo
FROM tb_score,tb_course
WHERE tb_score.courseNo=tb_course.courseNo AND courseName='计算机基础';

SELECT studentNo
FROM tb_score,tb_course
WHERE tb_score.courseNo=tb_course.courseNo AND courseName='管理学'
UNION ALL
SELECT studentNo
FROM tb_score,tb_course
WHERE tb_score.courseNo=tb_course.courseNo AND courseName='计算机基础';

SELECT studentNo
FROM tb_score,tb_course
WHERE tb_score.courseNo=tb_course.courseNo AND courseName='计算机基础'
AND studentNo IN (
   SELECT studentNo
   FROM tb_score,tb_course
   WHERE tb_score.courseNo=tb_course.courseNo AND courseName='管理学'
);

SELECT studentNo
FROM tb_score,tb_course
WHERE tb_score.courseNo=tb_course.courseNo AND courseName='计算机基础'
AND studentNo NOT IN (
   SELECT studentNo
   FROM tb_score,tb_course
   WHERE tb_score.courseNo=tb_course.courseNo AND courseName='管理学'
);

SELECT DISTINCT SNO FROM SP WHERE PNO = 'P1';

SELECT * FROM SP WHERE QTY BETWEEN 300 AND 500;


SELECT DISTINCT S.SNO,SNAME FROM S JOIN SP JOIN P 
ON S.SNO=SP.SNO AND SP.PNO=P.PNO 
WHERE P.COLOR='Red';

SELECT PNO,PNAME FROM P WHERE WEIGHT<=15 AND PNO IN 
(
   SELECT PNO FROM SP WHERE SNO IN 
   (
     SELECT SNO FROM S WHERE CITY='Paris' 
   )
);

SELECT DISTINCT PNAME FROM P,SP,S 
WHERE S.SNO = SP.SNO AND SP.PNO = P.PNO AND CITY='London';

SELECT SNAME FROM S 
WHERE SNO NOT IN 
(
   SELECT SNO FROM SP JOIN P 
   ON SP.PNO=P.PNO
   WHERE COLOR = 'Red'
);

SELECT PNAME FROM P 
WHERE NOT EXISTS
(
   SELECT * FROM SP 
   WHERE SP.PNO = P.PNO AND SNO = 'S3'
);

SELECT SNAME FROM S JOIN SP 
ON S.SNO=SP.SNO 
WHERE PNO = 'P1' AND S.SNO IN 
(
   SELECT SNO FROM SP WHERE PNO = 'P2'
);

SELECT PX.PNO,PX.PNAME
FROM P PX JOIN P PY 
ON PX.COLOR = PY.COLOR
WHERE PY.PNAME ='Nut'AND PX.PNAME != 'Nut';

SELECT SNAME FROM S 
WHERE NOT EXISTS
(
   SELECT * FROM P 
   WHERE NOT EXISTS
   (
      SELECT * FROM SP 
      WHERE S.SNO=SP.SNO AND SP.PNO=P.PNO
   )
);

SELECT DISTINCT PNO FROM SP WHERE SNO = 'S5';

SELECT * FROM P WHERE WEIGHT BETWEEN 12 AND 15;

SELECT DISTINCT S.SNO,SNAME FROM S JOIN SP JOIN P 
ON S.SNO=SP.SNO AND SP.PNO=P.PNO 
WHERE S.CITY='London';

SELECT SNO,SNAME FROM S WHERE STATUS<=20 AND SNO IN 
(
   SELECT SNO FROM SP WHERE PNO IN 
   (
     SELECT PNO FROM P WHERE COLOR='Green' 
   )
);

SELECT DISTINCT PNAME FROM P,SP,S 
WHERE S.SNO = SP.SNO AND SP.PNO = P.PNO AND CITY != 'London';

SELECT SNAME FROM S 
WHERE SNO NOT IN 
(
   SELECT SNO FROM SP JOIN P 
   ON SP.PNO=P.PNO
   WHERE COLOR = 'Blue'
);

SELECT SNAME FROM S 
WHERE NOT EXISTS
(
   SELECT * FROM SP 
   WHERE SP.SNO = S.SNO AND SNO = 'S1'
);

SELECT P.PNO,PNAME FROM P JOIN SP 
ON P.PNO=SP.PNO
WHERE SP.SNO='S3' OR SP.SNO='S4';

SELECT SNO,SNAME FROM S
WHERE S.CITY = 
(
   SELECT S.CITY FROM S 
   WHERE SNAME='Clark'
)AND SNAME != 'Clark';

SELECT PNAME FROM P 
WHERE NOT EXISTS
(
   SELECT * FROM S 
   WHERE NOT EXISTS
   (
      SELECT * FROM SP 
      WHERE S.SNO=SP.SNO AND SP.PNO=P.PNO
   )
);

DROP TABLE db_school.tb_student1;

 CREATE TABLE tb_student1
 (
    studentNo CHAR(10) PRIMARY KEY,
    studentName VARCHAR(20)NOT NULL,
    sex CHAR(2) NOT NULL,
    birthday DATE,
    native VARCHAR(20),
    nation VARCHAR(10) DEFAULT'汉',
    classNo CHAR(6)
 ) ENGINE=InnoDB;

 INSERT INTO db_school.tb_student1(studentNo,studentName,sex,birthday,native,nation,classNo)
 SELECT studentNo,studentName,sex,birthday,native,nation,classNo
 FROM tb_student;

 INSERT INTO tb_student1
 VALUES('20231030032','黄蒋逸','男','2004-10-29','浙江','汉','CS1401');

 REPLACE INTO tb_student1(studentNo,studentName,sex,birthday,native,nation,classNo)
 VALUES ('2013110101','张珊','女','1997-01-01','云南','汉','AC1301');

 INSERT INTO tb_student1(studentNo,studentName,sex)
 VALUES('2014310104','陈卓卓','女'),('2014310105','马丽','女'),('2014310106','许江','男');

 UPDATE db_school.tb_student1
 SET studentName = '张三',native = '湖北',nation = '汉'
 WHERE studentNo='2014210101';

 UPDATE tb_score
 SET score=score*1.02;

 UPDATE tb_course
 SET courseHour=courseHour+16;

 DELETE FROM tb_student1 WHERE studentNo='2014310104';

  DELETE FROM tb_student1 WHERE studentNo
  NOT IN
   (
     SELECT studentNo FROM tb_score
   );

DELETE FROM db_school.tb_student1;

TRUNCATE db_school.tb_class;

UPDATE db_sp.p
SET WEIGHT=WEIGHT*1.2
WHERE COLOR='Blue';

DELETE FROM db_sp.s WHERE STATUS IS NULL;

DELETE FROM db_sp.p WHERE NOT EXISTS
(
   SELECT * FROM db_sp.sp 
   WHERE db_sp.p.pno=db_sp.sp.pno
);

SHOW INDEX FROM tb_student\G;

SHOW INDEX FROM tb_score\G;

CREATE VIEW v_student AS
SELECT * FROM tb_student WHERE sex='女';

CREATE VIEW v_score_avg AS
SELECT studentNo,AVG(score) AS avg_score
FROM tb_score
GROUP BY studentNo
ORDER BY studentNo;