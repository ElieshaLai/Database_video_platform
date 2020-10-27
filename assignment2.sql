/* Author: 
Hsiao-Hsuan (Eliesha) Lai
UTEID: hl28394*/

/* All drop should be wriiten before creating */

---DROP tables
DROP TABLE "Billing_address";
DROP TABLE"Card";
DROP TABLE "CC";
DROP TABLE"Video_topic";
DROP TABLE "subscribe";
DROP TABLE"topic";
DROP TABLE "comments";
DROP TABLE "Video";
DROP TABLE "Browsers";




---create tables
CREATE TABLE "Browsers" (
  "Browsers_id" NUMBER,
  "first_name" varchar (50) NOT NULL,
  "middle_name" varchar (50),
  "last_name" varchar (50) NOT NULL,
   "current_date" DATE DEFAULT SYSDATE,
  "birthdate" DATE NOT NULL,
  "email" varchar (60) UNIQUE,
  "CC_Flag" CHAR(1) DEFAULT 'N',
  CONSTRAINT Browsers_pk PRIMARY KEY ("Browsers_id"),
  CONSTRAINT email_length_check CHECK (LENGTH("email")>=7) ,
  CONSTRAINT age_check_constraint CHECK (("current_date" - "birthdate") >= 13)
);


CREATE TABLE "CC" (
  "CC_id" NUMBER,
  "Browsers_id" NUMBER,
  "username" varchar (50) NOT NULL,
  "first_name" varchar (50) NOT NULL,
  "middle_name" varchar (50),
  "last_name" varchar (50) NOT NULL,
  "email" varchar (60) UNIQUE,
  "phone" CHAR (12) NOT NULL,
  "address" varchar (100) NOT NULL,
  "Country" varchar (20) NOT NULL,
  "State" CHAR (2) NOT NULL,
  "tier" varchar (15) DEFAULT 'free' ,
  CONSTRAINT cc_pk PRIMARY KEY ("CC_id"),
  CONSTRAINT email_length_check2 CHECK (LENGTH("email")>=7), 
  CONSTRAINT browser_id_fk FOREIGN KEY ("Browsers_id") REFERENCES "Browsers" ("Browsers_id")
);


CREATE TABLE "Video" (
  "video_id" NUMBER,
  "video_title" varchar(100) NOT NULL,
  "video_subtitle" varchar(100) NOT NULL,
  "topic" varchar(50) NOT NULL,
  "date_uploaded" DATE NOT NULL,
  "video_size" NUMBER NOT NULL,
  "views" NUMBER DEFAULT 0,
  "likes" NUMBER DEFAULT 0,
  "revenue" NUMBER DEFAULT 0,
  CONSTRAINT video_pk PRIMARY KEY ("video_id"),
 CONSTRAINT likes_check CHECK ("likes">=0),  ---I think likes can't be negative in any circumstances so do views, so I added these two check constraint
 CONSTRAINT views_check CHECK ("views">=0) 
);

CREATE TABLE "topic" (
  "topic_id" NUMBER,
  "topic_name" varchar(100) NOT NULL,
  "topic_description" varchar(1000) NOT NULL ,
  CONSTRAINT topic_pk PRIMARY KEY ("topic_id")
);

CREATE TABLE "subscribe" (
  "subscribe_id" NUMBER,
  "Browsers_id" NUMBER,
  "topic_id" NUMBER,
  CONSTRAINT subscribe_pk PRIMARY KEY ("subscribe_id"),
  CONSTRAINT Browsers_id_fk1 FOREIGN KEY ("Browsers_id") REFERENCES "Browsers" ("Browsers_id"),
  CONSTRAINT topic_id_fk2 FOREIGN KEY ("topic_id") REFERENCES "topic" ("topic_id")
);


CREATE TABLE "comments" (
  "comment_id" NUMBER,
  "Browsers_id" NUMBER ,
  "video_id" NUMBER,
  "content" varchar(1000) NOT NULL,
 CONSTRAINT comment_pk PRIMARY KEY ("comment_id"),
 CONSTRAINT Browsers_id_fk FOREIGN KEY ("Browsers_id") REFERENCES "Browsers" ("Browsers_id"),
 CONSTRAINT video_id_fk FOREIGN KEY ("video_id") REFERENCES "Video" ("video_id")
);



CREATE TABLE "Video_topic" (
  "vtop_id" NUMBER,
  "video_id" NUMBER,
  "topic_id" NUMBER,
  CONSTRAINT vtop_pk PRIMARY KEY  ("vtop_id"),
  CONSTRAINT video_id_fk3 FOREIGN KEY ("video_id") REFERENCES "Video" ("video_id"),
  CONSTRAINT topic_id_fk FOREIGN KEY ("topic_id") REFERENCES "topic" ("topic_id")

);


CREATE TABLE "Card" (
  "card_id" NUMBER,
  "CC_id" NUMBER,
  "card_num" varchar(50) NOT NULL,
  "type" varchar(10) NOT NULL,
  "expiration_date" DATE NOT NULL,
  "security_code" CHAR(3) NOT NULL,--- I believe security code is always three digits, so I changed the data type to char(3)
  CONSTRAINT card_pk PRIMARY KEY ("card_id"),
  CONSTRAINT cc_id_fk FOREIGN KEY ("CC_id") REFERENCES "CC" ("CC_id")
);

CREATE TABLE "Billing_address" (
  "card_id" NUMBER,
  "add_id" NUMBER,
  "address" varchar(100) NOT NULL,
  "city" varchar(30) NOT NULL,
  "state" CHAR (2) NOT NULL,
  "zip" CHAR(5) NOT NULL,
  CONSTRAINT add_pk PRIMARY KEY("add_id"),
  CONSTRAINT card_id_fk FOREIGN KEY ("card_id") REFERENCES "Card" ("card_id")
);

---DROP SEQUENCE
DROP SEQUENCE Browsers_id_sequence;
DROP SEQUENCE CC_id_sequence;
DROP SEQUENCE topic_id_sequence;
DROP SEQUENCE video_id_sequence;
DROP SEQUENCE comment_id_sequence;
DROP SEQUENCE card_id_sequence;
DROP SEQUENCE topic_video_id_sequence;
DROP SEQUENCE topic_user_id_sequence;

---CREATE SEQUENCE
CREATE SEQUENCE Browsers_id_sequence
START WITH 1000000
INCREMENT BY 1;  

CREATE SEQUENCE CC_id_sequence
START WITH 1000000
INCREMENT BY 1;  

CREATE SEQUENCE topic_id_sequence
START WITH 1000
INCREMENT BY 1;  

CREATE SEQUENCE video_id_sequence
START WITH 1000
INCREMENT BY 1;  

CREATE SEQUENCE comment_id_sequence
START WITH 1000
INCREMENT BY 1;  

CREATE SEQUENCE card_id_sequence
START WITH 1000000
INCREMENT BY 1;  

CREATE SEQUENCE topic_video_id_sequence
START WITH 1000
INCREMENT BY 1; 

CREATE SEQUENCE topic_user_id_sequence
START WITH 1000
INCREMENT BY 1; 

---INSERT
/*insert six users*/
alter session set nls_date_format='yyyy/mm/dd';

INSERT INTO "Browsers" ("Browsers_id",  "first_name","last_name", "birthdate","email","CC_Flag") 
VALUES  (Browsers_id_sequence.NEXTVAL, 'John','Smith','1988/12/23', '566@gmail.com','Y');
COMMIT;

INSERT INTO "Browsers" ("Browsers_id",  "first_name","middle_name","last_name", "birthdate","email","CC_Flag") 
VALUES  (Browsers_id_sequence.NEXTVAL, 'Kaye','Martha','Johnson','1968/02/17', 'kmj0217@gmail.com','Y');
COMMIT;

INSERT INTO "Browsers" ("Browsers_id",  "first_name","middle_name","last_name", "birthdate","email","CC_Flag") 
VALUES  (Browsers_id_sequence.NEXTVAL, 'Hunter','Ray','Lee','1996/07/05', 'jkwe22@gmail.com','Y');
COMMIT;

INSERT INTO "Browsers" ("Browsers_id",  "first_name","last_name", "birthdate","email","CC_Flag") 
VALUES  (Browsers_id_sequence.NEXTVAL, 'Cameron','Davis','2003/01/28', 'ddk87@gmail.com','Y');
COMMIT;

INSERT INTO "Browsers" ("Browsers_id",  "first_name","last_name", "birthdate","email") 
VALUES  (Browsers_id_sequence.NEXTVAL, 'Jack','Lin','1994/03/19', 'ler@gmail.com');
COMMIT;

INSERT INTO "Browsers" ("Browsers_id",  "first_name","last_name", "birthdate","email") 
VALUES  (Browsers_id_sequence.NEXTVAL, 'Catlin','Moore','2002/06/02', 'cmtt23@gmail.com');
COMMIT;


/*insert four CC users*/
INSERT INTO "CC" ("CC_id","Browsers_id", "username", "first_name", "last_name", "email" ,"phone", "address" ,"Country", "State") 
VALUES  (CC_id_sequence.NEXTVAL,1000000, 'ul437', 'John','Smith','123@gmail.com', '723-399-7644','8749 Wood Hollow','United States', 'TX');
COMMIT;

INSERT INTO "CC" ("CC_id", "Browsers_id", "username", "first_name","middle_name", "last_name", "email" ,"phone", "address" ,"Country", "State") 
VALUES  (CC_id_sequence.NEXTVAL,1000001, 'doglover', 'Kaye','Martha','Johnson','553@gmail.com', '923-369-7674','123 Riverband','United States', 'VA');
COMMIT;

INSERT INTO "CC" ("CC_id","Browsers_id",  "username", "first_name","middle_name", "last_name", "email" ,"phone", "address" ,"Country", "State") 
VALUES  (CC_id_sequence.NEXTVAL,1000002, 'applepie', 'Hunter','Ray','Lee','yehs3@gmail.com', '439-309-2844','19134 McDougall','United States', 'CA');
COMMIT;

INSERT INTO "CC" ("CC_id", "Browsers_id", "username", "first_name", "last_name", "email" ,"phone", "address" ,"Country", "State") 
VALUES  (CC_id_sequence.NEXTVAL,1000003, 'kk1833', 'Cameron','Davis','cd1833@gmail.com', '373-379-9304','677 heaven road','United States', 'TX');
COMMIT;

/*insert credit card*/
alter session set nls_date_format='mm/yy';

INSERT INTO "Card" ("card_id", "CC_id", "card_num", "type", "expiration_date", "security_code") 
VALUES  (card_id_sequence.NEXTVAL,1000000, '4866 8908 4356 0987', 'Visa','07/25' , '373');
COMMIT;

INSERT INTO "Card" ("card_id", "CC_id", "card_num", "type", "expiration_date", "security_code") 
VALUES  (card_id_sequence.NEXTVAL,1000000, '8934 0593 3345 6723','Mastercard', '02/23' , '097');
COMMIT;

INSERT INTO "Card" ("card_id", "CC_id", "card_num", "type", "expiration_date", "security_code") 
VALUES  (card_id_sequence.NEXTVAL,1000001, '9604 4955 6565 9345','Mastercard', '05/24' , '618');
COMMIT;

INSERT INTO "Card" ("card_id", "CC_id", "card_num", "type", "expiration_date", "security_code") 
VALUES  (card_id_sequence.NEXTVAL,1000002, '2334 8399 2365 8594','Visa', '10/25' , '203');
COMMIT;




/*insert four videos*/
INSERT INTO "Video" ("video_id","video_title","video_subtitle","topic", "date_uploaded", "video_size",  "views" ,"likes" , "revenue" )
VALUES ( video_id_sequence.NEXTVAL,'Relaxing Piano 100 SONGS Collection','Subscribe me', 'Music',sysdate,'5','245','30','100');
COMMIT;

select TO_CHAR("date_uploaded", 'YYYY-MM-DD HH24:MI:SS') from "Video"; ---The result of date uploaded.

INSERT INTO "Video" ("video_id","video_title","video_subtitle","topic", "date_uploaded", "video_size" )
VALUES ( video_id_sequence.NEXTVAL,'Nothing','Nothing special in this video', 'Life',sysdate,'3');
COMMIT;


INSERT INTO "Video" ("video_id","video_title","video_subtitle","topic", "date_uploaded", "video_size",  "views" ,"likes" , "revenue" )
VALUES ( video_id_sequence.NEXTVAL,'Intro to Machine Learning','You will learn basic concepts of machine learning in this video', 'Data Science',sysdate,'10','700000','500000','10000');
COMMIT;

INSERT INTO "Video" ("video_id","video_title","video_subtitle","topic", "date_uploaded", "video_size",  "views" ,"likes" , "revenue" )
VALUES ( video_id_sequence.NEXTVAL,'Mexican-American War','Learn from the past withme. If you like my video, please subscribe', 'History',sysdate,'5','63470','32090','2000');
COMMIT;

/* insert four comments in linking table*/
INSERT INTO "comments" ("comment_id","Browsers_id","video_id","content")
VALUES ( comment_id_sequence.NEXTVAL,1000004, 1002,'It is a very useful video. But if you already from data science background, propably too easy for you.');
COMMIT;

INSERT INTO "comments" ("comment_id","Browsers_id","video_id","content")
VALUES ( comment_id_sequence.NEXTVAL,1000005, 1000,'I listen to this whenever I feel stressed. The piano is really relaxing.');
COMMIT;

INSERT INTO "comments" ("comment_id","Browsers_id","video_id","content")
VALUES ( comment_id_sequence.NEXTVAL,1000002, 1000,'I fell asleep when I listen to these songs studying lol.');
COMMIT;

INSERT INTO "comments" ("comment_id","Browsers_id","video_id","content")
VALUES ( comment_id_sequence.NEXTVAL,1000003, 1003,'It is a very useful video. But if you already from data science background, propably too easy for you.');
COMMIT;

/*four different topics of video*/
INSERT INTO "topic" ("topic_id", "topic_name","topic_description")
VALUES ( topic_id_sequence.NEXTVAL,'Music', 'Any type of music, jazz,classical, hip-hop etc..' );
COMMIT;

INSERT INTO "topic" ("topic_id", "topic_name","topic_description")
VALUES ( topic_id_sequence.NEXTVAL,'Life','Including news and daily life sharing.');
COMMIT;

INSERT INTO "topic" ("topic_id", "topic_name","topic_description")
VALUES ( topic_id_sequence.NEXTVAL,'History','Stories about the past, having educational meaning.');
COMMIT;

INSERT INTO "topic" ("topic_id", "topic_name","topic_description")
VALUES ( topic_id_sequence.NEXTVAL,'Movie','You can share a trailer and movie reviews.');
COMMIT;

INSERT INTO "topic" ("topic_id", "topic_name","topic_description")
VALUES ( topic_id_sequence.NEXTVAL,'Data Science','The Sexiest Job of the 21st Century');
COMMIT;

--- optional part
/* topic video linking table*/
INSERT INTO "Video_topic" ("vtop_id", "video_id","topic_id")
VALUES ( topic_video_id_sequence.NEXTVAL,1000,1000 );
COMMIT;

INSERT INTO "Video_topic" ("vtop_id", "video_id","topic_id")
VALUES ( topic_video_id_sequence.NEXTVAL,1001,1001 );
COMMIT;

INSERT INTO "Video_topic" ("vtop_id", "video_id","topic_id")
VALUES ( topic_video_id_sequence.NEXTVAL,1002,1004 );
COMMIT;

INSERT INTO "Video_topic" ("vtop_id", "video_id","topic_id")
VALUES ( topic_video_id_sequence.NEXTVAL,1003,1002 );
COMMIT;

/* topic user linking table- subscribe*/
INSERT INTO "subscribe" ("subscribe_id", "Browsers_id","topic_id")
VALUES ( topic_user_id_sequence.NEXTVAL,1000000,1004 );
COMMIT;

INSERT INTO "subscribe" ("subscribe_id", "Browsers_id","topic_id")
VALUES ( topic_user_id_sequence.NEXTVAL,1000000,1000 );
COMMIT;

INSERT INTO "subscribe" ("subscribe_id", "Browsers_id","topic_id")
VALUES ( topic_user_id_sequence.NEXTVAL,1000002,1004 );
COMMIT;

INSERT INTO "subscribe" ("subscribe_id", "Browsers_id","topic_id")
VALUES ( topic_user_id_sequence.NEXTVAL,1000004,1002 );
COMMIT;

---Indexes
/*Best to add indexes on columns: 
1. Frequently used in joins
2. Frequently used in searches
3. Has a UNIQUE constraint
4. Not update a lot*/

CREATE INDEX cc_username_ix
ON "CC" ("username");

CREATE INDEX cc_state_ix
ON "CC" ("State");

CREATE INDEX cc_country_ix
ON "CC" ("Country");







