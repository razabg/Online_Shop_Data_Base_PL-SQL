prompt PL/SQL Developer Export Tables for user C##RAZ@XE
prompt Created by razab on יום ראשון 11 אוגוסט 2024
set feedback off
set define off

prompt Creating BUYERS...
create table BUYERS
(
  buyer_id   INTEGER not null,
  buyer_name VARCHAR2(200) not null,
  email      VARCHAR2(255) not null,
  phone      VARCHAR2(20) not null,
  address    VARCHAR2(200) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table BUYERS
  add primary key (BUYER_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table BUYERS
  add constraint LEN_OF_BUYER_ID
  check (length(buyer_id) >= 4);

prompt Creating CATEGORIES...
create table CATEGORIES
(
  category_id   INTEGER not null,
  category_name VARCHAR2(35) not null,
  information   VARCHAR2(50)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CATEGORIES
  add primary key (CATEGORY_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CATEGORIES
  add constraint CHECK_INFORMATION_EMPTY
  check (information IS NOT NULL);

prompt Creating ORDERS...
create table ORDERS
(
  order_id   INTEGER not null,
  order_date DATE not null,
  buyer_id   INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ORDERS
  add primary key (ORDER_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ORDERS
  add foreign key (BUYER_ID)
  references BUYERS (BUYER_ID);
alter table ORDERS
  add constraint CHECK_ORDER_DATE_SINCE_2023
  check (order_date >= DATE '2023-01-01');

prompt Creating INCLUDE_PRODUCTS...
create table INCLUDE_PRODUCTS
(
  order_id   INTEGER not null,
  product_id INTEGER not null,
  quantity   INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table INCLUDE_PRODUCTS
  add primary key (ORDER_ID, PRODUCT_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table INCLUDE_PRODUCTS
  add foreign key (ORDER_ID)
  references ORDERS (ORDER_ID);

prompt Creating ORDERDETAILS...
create table ORDERDETAILS
(
  order_id        INTEGER not null,
  delivery_method VARCHAR2(20) not null,
  tracking_number VARCHAR2(20) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ORDERDETAILS
  add primary key (ORDER_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ORDERDETAILS
  add foreign key (ORDER_ID)
  references ORDERS (ORDER_ID);

prompt Creating PRODUCTS...
create table PRODUCTS
(
  product_id     INTEGER not null,
  product_name   VARCHAR2(200) not null,
  status         VARCHAR2(20),
  price          NUMBER(10,2) not null,
  category_id    INTEGER not null,
  stock          INTEGER,
  available_date DATE
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PRODUCTS
  add primary key (PRODUCT_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PRODUCTS
  add foreign key (CATEGORY_ID)
  references CATEGORIES (CATEGORY_ID);

prompt Creating REVIEWS...
create table REVIEWS
(
  review_id    INTEGER not null,
  rating       NUMBER(10,1),
  comment_text VARCHAR2(2000),
  review_date  DATE not null,
  product_id   INTEGER not null,
  buyer_id     INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table REVIEWS
  add primary key (REVIEW_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table REVIEWS
  add foreign key (BUYER_ID)
  references BUYERS (BUYER_ID);

prompt Creating SELLERS...
create table SELLERS
(
  seller_name VARCHAR2(20) not null,
  seller_id   INTEGER not null,
  phone       VARCHAR2(20) not null,
  address     VARCHAR2(30) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SELLERS
  add primary key (SELLER_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating SELL...
create table SELL
(
  seller_id  INTEGER not null,
  product_id INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SELL
  add primary key (SELLER_ID, PRODUCT_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SELL
  add foreign key (SELLER_ID)
  references SELLERS (SELLER_ID);

prompt Disabling triggers for BUYERS...
alter table BUYERS disable all triggers;
prompt Disabling triggers for CATEGORIES...
alter table CATEGORIES disable all triggers;
prompt Disabling triggers for ORDERS...
alter table ORDERS disable all triggers;
prompt Disabling triggers for INCLUDE_PRODUCTS...
alter table INCLUDE_PRODUCTS disable all triggers;
prompt Disabling triggers for ORDERDETAILS...
alter table ORDERDETAILS disable all triggers;
prompt Disabling triggers for PRODUCTS...
alter table PRODUCTS disable all triggers;
prompt Disabling triggers for REVIEWS...
alter table REVIEWS disable all triggers;
prompt Disabling triggers for SELLERS...
alter table SELLERS disable all triggers;
prompt Disabling triggers for SELL...
alter table SELL disable all triggers;
prompt Disabling foreign key constraints for ORDERS...
alter table ORDERS disable constraint SYS_C008645;
prompt Disabling foreign key constraints for INCLUDE_PRODUCTS...
alter table INCLUDE_PRODUCTS disable constraint SYS_C008667;
prompt Disabling foreign key constraints for ORDERDETAILS...
alter table ORDERDETAILS disable constraint SYS_C008662;
prompt Disabling foreign key constraints for PRODUCTS...
alter table PRODUCTS disable constraint SYS_C008680;
prompt Disabling foreign key constraints for REVIEWS...
alter table REVIEWS disable constraint SYS_C008652;
prompt Disabling foreign key constraints for SELL...
alter table SELL disable constraint SYS_C008656;
prompt Deleting SELL...
delete from SELL;
commit;
prompt Deleting SELLERS...
delete from SELLERS;
commit;
prompt Deleting REVIEWS...
delete from REVIEWS;
commit;
prompt Deleting PRODUCTS...
delete from PRODUCTS;
commit;
prompt Deleting ORDERDETAILS...
delete from ORDERDETAILS;
commit;
prompt Deleting INCLUDE_PRODUCTS...
delete from INCLUDE_PRODUCTS;
commit;
prompt Deleting ORDERS...
delete from ORDERS;
commit;
prompt Deleting CATEGORIES...
delete from CATEGORIES;
commit;
prompt Deleting BUYERS...
delete from BUYERS;
commit;
prompt Loading BUYERS...
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (9999, 'Omero Hackett', 'ohackett0@globo.com', '768-751-2311', '70 Eastlawn Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10000, 'Ronald Kennerley', 'rkennerley1@latimes.com', '348-486-0041', '238 Del Sol Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10001, 'Janek Hundell', 'jhundell2@google.com.br', '118-350-3220', '21697 Straubel Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10002, 'Danell Jeness', 'djeness3@barnesandnoble.com', '635-177-1340', '2 Eagan Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10003, 'Monika Scallon', 'mscallon4@exblog.jp', '280-711-3391', '4 Paget Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10004, 'Mathilda Nyssens', 'mnyssens5@51.la', '106-717-1994', '22593 Melby Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10005, 'Paul Quincee', 'pquincee6@eventbrite.com', '369-141-6106', '14 Northport Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10006, 'Carter Cesconi', 'ccesconi7@privacy.gov.au', '263-638-7327', '3600 Wayridge Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10007, 'Xever Spadelli', 'xspadelli8@simplemachines.org', '304-428-1475', '37 Surrey Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10008, 'Traver Cosser', 'tcosser9@washington.edu', '290-555-8727', '54355 Eagle Crest Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10009, 'Aurthur Ennew', 'aennewa@over-blog.com', '242-769-4745', '380 Buhler Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10010, 'Kissee Suttaby', 'ksuttabyb@ca.gov', '552-424-8256', '3873 Mayfield Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10011, 'Friedrick Mack', 'fmackc@google.pl', '636-610-5533', '578 Sutteridge Road');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10012, 'Louisette Po', 'lpod@stumbleupon.com', '921-120-1240', '1 Mallory Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10013, 'Godfree Gavey', 'ggaveye@cargocollective.com', '836-623-2801', '0807 Gale Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10014, 'Bjorn Loram', 'bloramf@spotify.com', '829-617-2737', '444 Emmet Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10015, 'Reg Gosart', 'rgosartg@narod.ru', '575-550-5426', '12117 Coolidge Park');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10016, 'Clim Cassely', 'ccasselyh@hugedomains.com', '626-217-9523', '564 Bluejay Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10017, 'Pebrook Cultcheth', 'pcultchethi@google.co.jp', '691-368-1749', '44 Harbort Park');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10018, 'Pepito Elener', 'pelenerj@typepad.com', '607-101-9410', '32129 Gina Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10019, 'Corly Peaseman', 'cpeasemank@bloglines.com', '603-862-8127', '2084 Banding Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10020, 'Tedman Hagwood', 'thagwoodl@opensource.org', '747-951-7941', '0 Arkansas Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10021, 'Jeramie Trundler', 'jtrundlerm@imgur.com', '105-417-4031', '74 Utah Way');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10022, 'Wolfgang Burnell', 'wburnelln@columbia.edu', '360-678-6279', '14157 Schiller Circle');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10023, 'Jamesy Hought', 'jhoughto@google.com.au', '603-785-4970', '72067 Ridge Oak Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10024, 'Avivah Stoggles', 'astogglesp@opensource.org', '766-402-6097', '27 Oriole Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10025, 'Wally Elrick', 'welrickq@blogtalkradio.com', '860-389-8723', '5 Commercial Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10026, 'Lara Sallinger', 'lsallingerr@xing.com', '504-577-4248', '0 Derek Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10027, 'Bear Farrier', 'bfarriers@icio.us', '762-971-6897', '9131 Sutteridge Circle');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10028, 'Letisha Cuppitt', 'lcuppittt@unicef.org', '867-659-1341', '6 Randy Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10029, 'Byrom Casbourne', 'bcasbourneu@eepurl.com', '287-942-1181', '3945 David Center');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10030, 'Cesya Slaymaker', 'cslaymakerv@instagram.com', '691-896-6898', '09521 Eastlawn Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10031, 'Garwood Brands', 'gbrandsw@vkontakte.ru', '324-561-9648', '04 Bartelt Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10032, 'Colline Gossage', 'cgossagex@nationalgeographic.com', '320-919-9610', '545 Helena Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10033, 'Cedric Cregg', 'ccreggy@hubpages.com', '140-100-9901', '904 Buhler Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10034, 'Elton Bickerdyke', 'ebickerdykez@artisteer.com', '111-364-8950', '91 Coleman Road');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10035, 'Germayne Trahar', 'gtrahar10@amazon.com', '851-572-9938', '74004 New Castle Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10036, 'Cass Bum', 'cbum11@weather.com', '486-159-9682', '140 Parkside Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10037, 'Davita Baumann', 'dbaumann12@google.com.hk', '265-351-7086', '62738 Spohn Park');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10038, 'Verge Osband', 'vosband13@purevolume.com', '900-367-9837', '442 Mayer Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10039, 'Reed Rawood', 'rrawood14@slideshare.net', '458-639-3275', '29951 Bultman Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10040, 'Andria Larvent', 'alarvent15@ocn.ne.jp', '960-754-4707', '9 Miller Center');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10041, 'Consalve Cammiemile', 'ccammiemile16@berkeley.edu', '401-206-2723', '3631 Pierstorff Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10042, 'Hall O''Cooney', 'hocooney17@telegraph.co.uk', '823-343-3767', '104 Kim Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10043, 'Alister Dudek', 'adudek18@harvard.edu', '465-988-1056', '5185 Clemons Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10044, 'Maximilianus Alfuso', 'malfuso19@csmonitor.com', '606-197-4891', '1370 Bellgrove Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10045, 'Corbin Lightfoot', 'clightfoot1a@craigslist.org', '432-170-7387', '60561 Kropf Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10046, 'Kalina Atkins', 'katkins1b@prweb.com', '164-597-3270', '798 Fairview Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10047, 'Gustavus Beacock', 'gbeacock1c@pen.io', '960-503-0019', '41 Londonderry Circle');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10048, 'Lee Ohlsen', 'lohlsen1d@sciencedirect.com', '654-378-7519', '87673 Karstens Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10049, 'Dara Quilliam', 'dquilliam1e@webeden.co.uk', '232-450-7225', '36 Randy Road');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10050, 'Madalyn Harmant', 'mharmant1f@theguardian.com', '174-348-6061', '6851 West Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10051, 'Flossy Belt', 'fbelt1g@nps.gov', '305-570-7025', '89 Pine View Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10052, 'Karie Geistbeck', 'kgeistbeck1h@domainmarket.com', '569-890-6391', '16 Russell Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10053, 'Fancy Danford', 'fdanford1i@amazon.co.uk', '619-288-1943', '395 Fairfield Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10054, 'Illa Lippiett', 'ilippiett1j@tinyurl.com', '271-372-5961', '409 Stoughton Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10055, 'Kipp Elliston', 'kelliston1k@php.net', '953-923-1041', '33961 Vermont Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10056, 'Maribelle Hallums', 'mhallums1l@uiuc.edu', '514-713-9960', '7 Riverside Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10057, 'Dorella Kenney', 'dkenney1m@vimeo.com', '529-113-6042', '7 John Wall Center');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10058, 'Ardys Halshaw', 'ahalshaw1n@last.fm', '359-396-0941', '70 Melvin Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10059, 'Laird Stowers', 'lstowers1o@php.net', '187-591-1105', '5697 Debs Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10060, 'Diannne Kellet', 'dkellet1p@columbia.edu', '470-487-5841', '35780 Mifflin Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10061, 'Elfrieda Hedlestone', 'ehedlestone1q@shop-pro.jp', '180-218-0450', '917 Wayridge Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10062, 'Leland Summerscales', 'lsummerscales1r@pbs.org', '599-616-0088', '12 Haas Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10063, 'Donia Van Hove', 'dvan1s@weather.com', '869-870-4341', '410 Express Park');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10064, 'Ursula Dearle-Palser', 'udearlepalser1t@shareasale.com', '358-728-5146', '58562 Grayhawk Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10065, 'Norman Scarisbrick', 'nscarisbrick1u@miibeian.gov.cn', '660-853-6081', '95 Nevada Road');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10066, 'Gasparo Pidgin', 'gpidgin1v@usatoday.com', '383-482-0998', '2 Sunnyside Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10067, 'Hedda Bambury', 'hbambury1w@furl.net', '682-642-7129', '576 Elka Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10068, 'Lauralee Rundle', 'lrundle1x@netlog.com', '212-590-5350', '48 Pleasure Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10069, 'Kirsten Linggard', 'klinggard1y@list-manage.com', '829-765-1536', '2 Lakewood Junction');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10070, 'Derby Bonnet', 'dbonnet1z@rediff.com', '889-380-2545', '9394 Northport Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10071, 'Elijah Midlar', 'emidlar20@fema.gov', '926-442-8419', '256 Trailsway Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10072, 'Carmelle Fayerbrother', 'cfayerbrother21@shop-pro.jp', '847-822-5455', '31995 Loeprich Junction');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10073, 'Paula Kennler', 'pkennler22@w3.org', '113-594-0537', '2 New Castle Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10074, 'Gerianna Berrisford', 'gberrisford23@mapy.cz', '613-513-8513', '31 Stephen Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10075, 'Melamie Abeau', 'mabeau24@joomla.org', '335-127-3262', '11 Heffernan Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10076, 'Dniren Parlor', 'dparlor25@g.co', '719-931-7105', '45402 Dixon Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10077, 'Issie Rand', 'irand26@hatena.ne.jp', '445-827-9277', '32256 Meadow Ridge Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10078, 'Dirk Keynd', 'dkeynd27@nasa.gov', '735-966-4270', '93 Mallory Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10079, 'Cindy Dundridge', 'cdundridge28@telegraph.co.uk', '948-316-8898', '4 Hoffman Junction');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10080, 'Jessalyn Rudolfer', 'jrudolfer29@google.nl', '881-263-9036', '00 Bluestem Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10081, 'Ceciley Seefeldt', 'cseefeldt2a@illinois.edu', '425-172-2620', '85354 Village Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10082, 'Jacklin McMenemy', 'jmcmenemy2b@instagram.com', '293-563-7830', '4281 Barnett Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10083, 'Penelopa MacTrustie', 'pmactrustie2c@slashdot.org', '335-879-8830', '0883 Brentwood Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10084, 'Janie Siddeley', 'jsiddeley2d@walmart.com', '184-700-9572', '6502 Hovde Way');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10085, 'Lynn Sparshott', 'lsparshott2e@oracle.com', '342-108-8777', '213 Pennsylvania Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10086, 'Leilah Tydeman', 'ltydeman2f@uiuc.edu', '216-410-6833', '99 Shelley Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10087, 'Rosette Pottes', 'rpottes2g@bravesites.com', '604-650-9087', '2956 Delladonna Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10088, 'Gretel Gentsch', 'ggentsch2h@csmonitor.com', '170-896-4941', '4 Parkside Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10089, 'Findlay Coppeard', 'fcoppeard2i@furl.net', '913-967-5756', '04 Loftsgordon Way');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10090, 'Vickie Chestney', 'vchestney2j@phoca.cz', '156-948-6695', '505 Di Loreto Circle');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10091, 'Lyell Shand', 'lshand2k@salon.com', '229-787-5588', '8595 Vernon Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10092, 'Jessy Norker', 'jnorker2l@springer.com', '439-750-7896', '87 Lawn Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10093, 'Dion Dowrey', 'ddowrey2m@bbb.org', '117-285-1275', '289 Dryden Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10094, 'Frederich Widdecombe', 'fwiddecombe2n@boston.com', '385-847-5594', '749 Gateway Junction');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10095, 'Louise MacCaughan', 'lmaccaughan2o@moonfruit.com', '997-144-9308', '555 Spohn Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10096, 'Sibylla Olek', 'solek2p@issuu.com', '965-249-5742', '3526 Stoughton Road');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10097, 'Felecia Grute', 'fgrute2q@netlog.com', '542-709-2623', '09638 Village Green Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10098, 'Alfonso Steanyng', 'asteanyng2r@lulu.com', '519-540-0834', '335 Mayfield Parkway');
commit;
prompt 100 records committed...
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10099, 'Brunhilda Vaskov', 'bvaskov2s@mit.edu', '569-810-9576', '280 Grover Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10100, 'Tracee Glencrash', 'tglencrash2t@ted.com', '260-370-0229', '33 Emmet Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10101, 'Hebert Pagelsen', 'hpagelsen2u@example.com', '617-435-1987', '84 Golf View Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10102, 'Delmar Sprowson', 'dsprowson2v@reddit.com', '727-255-0982', '1433 Village Green Circle');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10103, 'Jourdain McCromley', 'jmccromley2w@guardian.co.uk', '318-276-9524', '5231 Dapin Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10104, 'Webster Bruins', 'wbruins2x@ycombinator.com', '916-108-2992', '1184 Schiller Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10105, 'Octavia Brasner', 'obrasner2y@senate.gov', '308-325-2172', '006 Graceland Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10106, 'Rochette Backshall', 'rbackshall2z@a8.net', '827-455-8721', '1610 Oneill Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10107, 'Sue Ridehalgh', 'sridehalgh30@imgur.com', '558-964-8893', '66846 Johnson Junction');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10108, 'Mahala Linck', 'mlinck31@usnews.com', '156-625-0374', '709 Rieder Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10109, 'Bord O''Reilly', 'boreilly32@unesco.org', '119-583-0098', '70 Independence Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10110, 'Sibel Rodgier', 'srodgier33@so-net.ne.jp', '953-972-7031', '15 Kingsford Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10111, 'Wood Hayer', 'whayer34@who.int', '507-713-9979', '18149 Portage Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10112, 'Jesse Maillard', 'jmaillard35@weibo.com', '247-737-6816', '782 Mallory Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10113, 'Shela Tremblay', 'stremblay36@google.ru', '443-845-9955', '48331 Caliangt Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10114, 'Adella Gaukroger', 'agaukroger37@over-blog.com', '759-700-7096', '8 Londonderry Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10115, 'Jonie Demsey', 'jdemsey38@dagondesign.com', '913-904-9251', '0 Petterle Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10116, 'Row Streatfeild', 'rstreatfeild39@issuu.com', '380-199-3531', '6 Brown Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10117, 'Alex Smeaton', 'asmeaton3a@latimes.com', '612-438-3909', '4 Mifflin Center');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10118, 'Sidney Carme', 'scarme3b@yellowbook.com', '528-971-0034', '66 Dakota Circle');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10119, 'Julius Sherland', 'jsherland3c@shop-pro.jp', '311-424-2659', '45609 Lerdahl Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10120, 'Shelly Howes', 'showes3d@blogs.com', '959-200-7609', '21 Alpine Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10121, 'Janine Seagrave', 'jseagrave3e@yolasite.com', '768-484-2594', '54820 Straubel Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10122, 'Merle Jacketts', 'mjacketts3f@buzzfeed.com', '162-112-1993', '834 Moland Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10123, 'Sosanna Di Domenico', 'sdi3g@sciencedirect.com', '144-695-8918', '6411 Nelson Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10124, 'Donn Eathorne', 'deathorne3h@ow.ly', '239-785-1981', '27 Mcbride Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10125, 'Merrielle Job', 'mjob3i@cisco.com', '300-788-7996', '8 Vidon Center');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10126, 'Giff Clubb', 'gclubb3j@taobao.com', '453-806-3857', '59 Dixon Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10127, 'Ethelyn Nevill', 'enevill3k@thetimes.co.uk', '531-579-5652', '46 Anhalt Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10128, 'Raddie Llewelly', 'rllewelly3l@nydailynews.com', '350-531-7520', '78 Montana Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10129, 'Clerc Jamieson', 'cjamieson3m@narod.ru', '435-790-2225', '3 Hayes Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10130, 'Base Batts', 'bbatts3n@google.com.br', '726-331-7213', '33406 Autumn Leaf Junction');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10131, 'Fair Tender', 'ftender3o@imageshack.us', '735-846-7751', '9457 Lyons Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10132, 'Derril Readshaw', 'dreadshaw3p@samsung.com', '474-199-1796', '2065 Hermina Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10133, 'Hermon Peron', 'hperon3q@wired.com', '635-737-7957', '64 Forest Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10134, 'Bobette Hawkswell', 'bhawkswell3r@yandex.ru', '109-231-5614', '5 Becker Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10135, 'Yank Pregel', 'ypregel3s@blogspot.com', '832-524-1659', '0737 Badeau Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10136, 'Iolanthe Ramm', 'iramm3t@virginia.edu', '964-750-8332', '600 Magdeline Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10137, 'Elbertine De Moreno', 'ede3u@salon.com', '841-362-9517', '54903 Hagan Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10138, 'Elvyn Szymanowicz', 'eszymanowicz3v@sphinn.com', '803-292-6044', '9 Grover Junction');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10139, 'Jacquette Ostick', 'jostick3w@paginegialle.it', '315-562-9719', '1814 Huxley Circle');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10140, 'Feodor Genty', 'fgenty3x@marriott.com', '669-984-4700', '2112 Hauk Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10141, 'Katina Boughton', 'kboughton3y@domainmarket.com', '350-280-5207', '8 Nova Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10142, 'Reggie Chainey', 'rchainey3z@businessweek.com', '753-324-8742', '773 Dixon Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10143, 'Merell Robe', 'mrobe40@wix.com', '916-941-3560', '9903 Mesta Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10144, 'Temp Ecclesall', 'tecclesall41@chron.com', '747-302-7336', '62371 Hudson Circle');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10145, 'Geordie Lelievre', 'glelievre42@multiply.com', '596-259-6002', '339 Bay Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10146, 'Marie-ann Fullom', 'mfullom43@ucoz.com', '266-286-4414', '70310 Lukken Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10147, 'Krisha Wedlake', 'kwedlake44@unblog.fr', '750-511-6951', '09459 Eagan Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10148, 'Nissa Greengrass', 'ngreengrass45@theatlantic.com', '197-171-7853', '36456 Almo Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10149, 'Siegfried Pearson', 'spearson46@mysql.com', '476-894-2980', '11 Vernon Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10150, 'Lek Fourcade', 'lfourcade47@ifeng.com', '603-502-2702', '02 Kropf Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10151, 'Randolph Shaddock', 'rshaddock48@dedecms.com', '939-834-4869', '8 Cody Park');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10152, 'Kennedy Steggals', 'ksteggals49@soup.io', '772-252-3006', '81 Warbler Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10153, 'Jodee Carey', 'jcarey4a@howstuffworks.com', '558-663-1844', '9 Granby Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10154, 'Ellery Phoebe', 'ephoebe4b@ovh.net', '110-141-4544', '34 Ludington Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10155, 'Alexandrina Hardingham', 'ahardingham4c@wiley.com', '250-583-4174', '64095 Mendota Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10156, 'Sherry Reschke', 'sreschke4d@discovery.com', '327-789-1194', '60051 Rowland Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10157, 'Gaspard Saggs', 'gsaggs4e@aol.com', '901-891-6519', '3493 Manley Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10158, 'Kitty Rogier', 'krogier4f@imageshack.us', '958-172-6753', '8836 Bobwhite Road');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10159, 'Alessandro Cleghorn', 'acleghorn4g@theglobeandmail.com', '226-915-5276', '02 Center Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10160, 'Aile Farrah', 'afarrah4h@cnbc.com', '682-436-9264', '45967 South Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10161, 'Bruno Siggin', 'bsiggin4i@ucoz.ru', '272-755-4489', '08540 Bay Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10162, 'Artair Cabena', 'acabena4j@reference.com', '168-814-5593', '2 Columbus Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10163, 'Jacklin Habershaw', 'jhabershaw4k@bing.com', '487-968-5271', '042 Kropf Circle');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10164, 'Fayre Colum', 'fcolum4l@wsj.com', '480-458-1972', '8658 Comanche Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10165, 'Magda Ramsdell', 'mramsdell4m@salon.com', '542-663-6798', '724 Prentice Center');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10166, 'Stormie Maplesden', 'smaplesden4n@foxnews.com', '835-808-6575', '68 Stone Corner Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10167, 'Filide Devereux', 'fdevereux4o@buzzfeed.com', '464-740-0289', '700 Everett Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10168, 'Galen Lorens', 'glorens4p@networksolutions.com', '943-485-9290', '964 Grover Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10169, 'Doloritas Edwicke', 'dedwicke4q@pinterest.com', '735-695-9381', '16106 Gerald Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10170, 'Oliviero Gilders', 'ogilders4r@symantec.com', '311-405-0068', '982 Summit Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10171, 'Jacquenetta Eouzan', 'jeouzan4s@forbes.com', '383-304-0624', '059 Longview Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10172, 'Raddy Doudney', 'rdoudney4t@independent.co.uk', '178-263-8269', '68 Oak Circle');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10173, 'Cornell Juan', 'cjuan4u@nyu.edu', '388-321-0240', '40887 Nobel Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10174, 'Horatio Goble', 'hgoble4v@webnode.com', '673-757-1068', '238 Old Shore Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10175, 'Kacey Limb', 'klimb4w@google.com.hk', '787-325-7240', '70495 Wayridge Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10176, 'Isidro Danat', 'idanat4x@nifty.com', '861-902-2291', '5025 Farwell Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10177, 'Ardenia McKennan', 'amckennan4y@delicious.com', '380-997-4513', '64859 Crowley Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10178, 'Erena Roseveare', 'eroseveare4z@cloudflare.com', '879-330-6509', '7747 Pond Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10179, 'Husein Thurlbourne', 'hthurlbourne50@forbes.com', '266-177-7076', '610 Bobwhite Junction');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10180, 'Jamaal Waddington', 'jwaddington51@usa.gov', '119-696-9771', '6376 Montana Junction');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10181, 'Caresa Garner', 'cgarner52@issuu.com', '403-893-7010', '32149 Bunker Hill Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10182, 'Nevin Load', 'nload53@google.com', '648-742-5974', '54276 Derek Way');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10183, 'Lamond Ring', 'lring54@thetimes.co.uk', '213-897-0637', '0486 Manley Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10184, 'Cheslie Heijnen', 'cheijnen55@wordpress.org', '868-104-2956', '546 Center Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10185, 'Lorettalorna Pegden', 'lpegden56@reverbnation.com', '690-782-5534', '46158 Bultman Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10186, 'Byram McCord', 'bmccord57@fotki.com', '251-962-9712', '492 Jana Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10187, 'Rheba Seif', 'rseif58@360.cn', '417-103-8368', '08428 Sage Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10188, 'Garnette Gwyneth', 'ggwyneth59@bing.com', '381-499-4614', '24528 Stone Corner Center');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10189, 'Ysabel Saintsbury', 'ysaintsbury5a@weebly.com', '666-982-0045', '13092 Debra Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10190, 'Osgood Filipputti', 'ofilipputti5b@quantcast.com', '123-816-2970', '6504 Monica Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10191, 'Octavia Lapidus', 'olapidus5c@sbwire.com', '610-836-6538', '85872 John Wall Junction');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10192, 'Zelda Hoyer', 'zhoyer5d@cnn.com', '337-387-8362', '22 Washington Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10193, 'Ruby Byre', 'rbyre5e@reverbnation.com', '141-630-9791', '88220 Corben Way');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10194, 'Joby Melmoth', 'jmelmoth5f@slashdot.org', '914-927-4811', '15005 Holy Cross Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10195, 'Nanny Stembridge', 'nstembridge5g@newsvine.com', '799-113-2798', '5862 Grim Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10196, 'Janaye Fysh', 'jfysh5h@chicagotribune.com', '647-866-5729', '76 Summer Ridge Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10197, 'Chad Simonnet', 'csimonnet5i@aol.com', '568-160-6545', '1635 Mosinee Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10198, 'Jean Brownsea', 'jbrownsea5j@goo.gl', '500-994-5757', '7345 Cherokee Alley');
commit;
prompt 200 records committed...
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10199, 'Ester Merrilees', 'emerrilees5k@t.co', '927-866-8928', '0680 Maywood Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10200, 'Pavlov Coles', 'pcoles5l@wp.com', '615-125-0248', '795 Mariners Cove Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10201, 'Jamey Campkin', 'jcampkin5m@blogger.com', '755-373-0466', '96 Glendale Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10202, 'Faythe Emmet', 'femmet5n@cdbaby.com', '747-749-2326', '4 Marquette Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10203, 'Tory Deares', 'tdeares5o@jugem.jp', '783-401-6982', '85310 Lukken Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10204, 'Catherin Thomen', 'cthomen5p@youku.com', '189-445-0342', '0606 Sachtjen Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10205, 'Ursuline Cappineer', 'ucappineer5q@ocn.ne.jp', '685-112-9268', '227 Gulseth Junction');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10206, 'Virgina Croom', 'vcroom5r@pbs.org', '375-993-1170', '64 Russell Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10207, 'Sydney Sier', 'ssier5s@shinystat.com', '706-232-9867', '5168 Browning Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10208, 'Alexine Form', 'aform5t@hp.com', '761-148-3194', '1 Surrey Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10209, 'Bethanne Bakhrushin', 'bbakhrushin5u@oaic.gov.au', '194-770-4048', '5700 Meadow Ridge Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10210, 'Salvador Raper', 'sraper5v@pbs.org', '585-565-3251', '52574 Loeprich Road');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10211, 'Salome Von Brook', 'svon5w@lulu.com', '570-851-8957', '503 Ridgeview Junction');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10212, 'Devora Gossage', 'dgossage5x@uol.com.br', '818-101-3273', '87 Monica Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10213, 'Leah Barham', 'lbarham5y@prweb.com', '706-813-7051', '0 Stone Corner Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10214, 'Belita Fuzzens', 'bfuzzens5z@salon.com', '369-126-1072', '5 Duke Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10215, 'Bob Bestwick', 'bbestwick60@last.fm', '597-274-0760', '3 Jackson Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10216, 'Vinson Cullen', 'vcullen61@state.gov', '167-129-1378', '5499 Meadow Valley Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10217, 'Edy Joist', 'ejoist62@yolasite.com', '352-575-8975', '496 Heath Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10218, 'Gamaliel Ruben', 'gruben63@slashdot.org', '797-862-6877', '15 Stang Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10219, 'Natale Fritchley', 'nfritchley64@squarespace.com', '156-688-9183', '3656 Farmco Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10220, 'Trey Collingdon', 'tcollingdon65@comcast.net', '162-380-7868', '38590 Riverside Center');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10221, 'Janel Murford', 'jmurford66@berkeley.edu', '392-331-5768', '0 Novick Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10222, 'Boothe Kingswood', 'bkingswood67@naver.com', '327-639-0075', '29961 Northfield Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10223, 'Daphene Gauvain', 'dgauvain68@newyorker.com', '899-663-1799', '52 Waywood Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10224, 'Bobby Biffen', 'bbiffen69@myspace.com', '101-814-4461', '99936 Division Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10225, 'Alikee Murrhardt', 'amurrhardt6a@npr.org', '397-685-4290', '714 Heath Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10226, 'Calv MacKeague', 'cmackeague6b@wikimedia.org', '768-871-5011', '2 Holmberg Center');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10227, 'Romeo Holligan', 'rholligan6c@infoseek.co.jp', '131-887-6773', '29477 Walton Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10228, 'Reuven Romeo', 'rromeo6d@youku.com', '953-780-4828', '0055 Butternut Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10229, 'Weidar Bernaldez', 'wbernaldez6e@feedburner.com', '648-458-5247', '49899 Melby Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10230, 'Valentine Skingley', 'vskingley6f@123-reg.co.uk', '122-507-8653', '25 Ludington Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10231, 'Terrance Bucknill', 'tbucknill6g@ezinearticles.com', '543-598-6892', '62025 Tomscot Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10232, 'Emmett Minkin', 'eminkin6h@ihg.com', '920-248-7042', '6949 Delaware Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10233, 'Thurston Giraths', 'tgiraths6i@slashdot.org', '957-963-7778', '5 Clyde Gallagher Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10234, 'Colleen Jankovic', 'cjankovic6j@nytimes.com', '768-360-8629', '771 Bobwhite Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10235, 'Cathee Margetts', 'cmargetts6k@mozilla.org', '258-100-0905', '0 Claremont Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10236, 'Bron Booth-Jarvis', 'bboothjarvis6l@51.la', '878-606-7937', '44807 International Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10237, 'Eadie Thomke', 'ethomke6m@pcworld.com', '451-576-3873', '27 6th Way');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10238, 'Hana Clapson', 'hclapson6n@about.com', '489-221-9910', '6 Mayer Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10239, 'Gusti Winborn', 'gwinborn6o@senate.gov', '787-200-6889', '2 Melrose Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10240, 'Javier Spaldin', 'jspaldin6p@google.com.br', '111-490-8806', '9049 Maple Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10241, 'Skell Mushet', 'smushet6q@meetup.com', '855-175-3343', '1355 Delladonna Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10242, 'Hansiain Nestoruk', 'hnestoruk6r@dropbox.com', '163-351-9247', '50 Wayridge Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10243, 'Lannie Crosbie', 'lcrosbie6s@pcworld.com', '694-946-0999', '92079 Dapin Park');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10244, 'Jonis Fuchs', 'jfuchs6t@spotify.com', '165-682-8391', '327 Westport Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10245, 'Iolanthe McHarry', 'imcharry6u@dropbox.com', '640-743-3298', '03277 Commercial Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10246, 'Tracy Easum', 'teasum6v@unicef.org', '225-819-8220', '033 Washington Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10247, 'Kalle Carlsson', 'kcarlsson6w@upenn.edu', '662-948-5319', '3698 Northport Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10248, 'Remington McCurlye', 'rmccurlye6x@weebly.com', '793-530-2435', '94308 Butternut Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10249, 'Ida Hurrion', 'ihurrion6y@state.gov', '161-179-2699', '15895 John Wall Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10250, 'Kim Braunton', 'kbraunton6z@cmu.edu', '460-420-0067', '24 Texas Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10251, 'Gwyneth Waddicor', 'gwaddicor70@mayoclinic.com', '248-128-3214', '9718 Briar Crest Road');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10252, 'Page McGeagh', 'pmcgeagh71@engadget.com', '565-556-1324', '69 Canary Park');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10253, 'Perrine Taylot', 'ptaylot72@livejournal.com', '578-896-8732', '31583 Chinook Way');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10254, 'Brigida Chesshire', 'bchesshire73@t-online.de', '666-765-4127', '32048 Ruskin Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10255, 'Jade Cuttin', 'jcuttin74@google.com.au', '823-229-2985', '37 Quincy Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10256, 'Trent Stellman', 'tstellman75@examiner.com', '821-194-3407', '01754 Arizona Center');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10257, 'Natale Stanford', 'nstanford76@abc.net.au', '960-630-6782', '7983 Meadow Vale Junction');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10258, 'Viviyan Snowsill', 'vsnowsill77@cam.ac.uk', '119-658-1410', '3072 Park Meadow Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10259, 'Wilbert Murney', 'wmurney78@house.gov', '357-670-1696', '0 Superior Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10260, 'Darsey Owlner', 'dowlner79@123-reg.co.uk', '941-784-3820', '1 Jenifer Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10261, 'Jennee Lonnon', 'jlonnon7a@mozilla.org', '402-205-1009', '064 Blackbird Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10262, 'Griz Edgcumbe', 'gedgcumbe7b@stumbleupon.com', '177-691-5230', '5032 Riverside Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10263, 'Annmarie Boyer', 'aboyer7c@unesco.org', '496-264-6930', '438 Rusk Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10264, 'Joy Motherwell', 'jmotherwell7d@netscape.com', '255-683-1232', '0793 Russell Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10265, 'Minnaminnie Nunan', 'mnunan7e@wordpress.org', '303-747-2123', '61 Valley Edge Junction');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10266, 'Misti Rennebeck', 'mrennebeck7f@lulu.com', '493-130-9535', '77 Pleasure Park');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10267, 'Rabbi Langforth', 'rlangforth7g@reuters.com', '292-656-6513', '47 Northridge Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10268, 'Valera Phelipeau', 'vphelipeau7h@dailymotion.com', '578-496-2604', '434 Carpenter Way');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10269, 'Jeanie Prinn', 'jprinn7i@nhs.uk', '507-104-9020', '837 Golden Leaf Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10270, 'Guido Godridge', 'ggodridge7j@umich.edu', '310-628-3445', '302 Vera Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10271, 'Justina Rosser', 'jrosser7k@google.it', '198-228-5637', '84 Carey Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10272, 'Lura Traske', 'ltraske7l@noaa.gov', '686-443-7613', '685 Anthes Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10273, 'Thedrick Vigne', 'tvigne7m@mashable.com', '158-452-0449', '660 Mallard Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10274, 'Demott Gawler', 'dgawler7n@unblog.fr', '164-953-6411', '905 Meadow Valley Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10275, 'Ernie Bugbird', 'ebugbird7o@people.com.cn', '834-905-5998', '45677 2nd Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10276, 'Dottie Lesser', 'dlesser7p@time.com', '997-346-1752', '950 Elmside Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10277, 'Jeannine Dary', 'jdary7q@dailymail.co.uk', '635-990-2249', '07623 Haas Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10278, 'Ad Klesel', 'aklesel7r@themeforest.net', '160-260-7621', '8853 Northland Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10279, 'Raoul Hakonsson', 'rhakonsson7s@yandex.ru', '292-811-2425', '52 American Ash Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10280, 'Chic Labuschagne', 'clabuschagne7t@ft.com', '344-647-6322', '9 Twin Pines Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10281, 'Alyss Licence', 'alicence7u@lycos.com', '484-319-7214', '2 Loeprich Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10282, 'Ardenia Styant', 'astyant7v@fc2.com', '136-535-8254', '563 Menomonie Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10283, 'Winfred McKillop', 'wmckillop7w@sitemeter.com', '309-847-9947', '96 Esch Junction');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10284, 'Kendell Church', 'kchurch7x@mapquest.com', '809-372-5804', '4421 Morningstar Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10285, 'Jilly Matoshin', 'jmatoshin7y@salon.com', '206-261-0671', '43074 Loeprich Way');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10286, 'John Filon', 'jfilon7z@nifty.com', '471-507-7927', '07 Kingsford Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10287, 'Meade Attock', 'mattock80@ihg.com', '201-875-6811', '15 Buhler Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10288, 'Nicholle Redolfi', 'nredolfi81@prlog.org', '764-538-4228', '0165 Warrior Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10289, 'Pierrette Drew', 'pdrew82@dot.gov', '374-320-7759', '8757 Dunning Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10290, 'Lesley Hebner', 'lhebner83@unicef.org', '931-446-0655', '10737 Northland Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10291, 'Rochelle Jobbings', 'rjobbings84@miibeian.gov.cn', '137-244-4445', '81 Lakewood Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10292, 'Joaquin Kunc', 'jkunc85@studiopress.com', '421-457-6085', '8106 Mallory Center');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10293, 'Fleming Yeowell', 'fyeowell86@examiner.com', '907-215-2117', '3251 Sundown Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10294, 'Luther Swiffen', 'lswiffen87@home.pl', '109-598-4668', '294 Norway Maple Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10295, 'Leonore Hackford', 'lhackford88@so-net.ne.jp', '553-226-5954', '2 Haas Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10296, 'Rab De Simoni', 'rde89@simplemachines.org', '915-408-3086', '185 Orin Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10297, 'Clair Commings', 'ccommings8a@bandcamp.com', '345-899-3147', '78 Nova Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10298, 'Alphard Howle', 'ahowle8b@jimdo.com', '156-360-2138', '45250 Judy Way');
commit;
prompt 300 records committed...
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10299, 'Roslyn Gerrens', 'rgerrens8c@last.fm', '867-815-5303', '38 Kensington Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10300, 'Joyann Stallard', 'jstallard8d@posterous.com', '301-522-4191', '4 Jay Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10301, 'Gilli Snoxell', 'gsnoxell8e@tmall.com', '193-480-2973', '18 Bashford Junction');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10302, 'Novelia Laurent', 'nlaurent8f@ed.gov', '567-260-4647', '361 Moose Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10303, 'Port Peyto', 'ppeyto8g@theglobeandmail.com', '640-220-4134', '35607 Kenwood Park');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10304, 'Joane Baddiley', 'jbaddiley8h@1und1.de', '569-406-2669', '111 Utah Way');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10305, 'Harold Dunsmuir', 'hdunsmuir8i@youtu.be', '204-157-4140', '9 Kingsford Road');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10306, 'Addi Brotherick', 'abrotherick8j@time.com', '341-433-7378', '55 Dunning Circle');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10307, 'Kamila MacCague', 'kmaccague8k@cbsnews.com', '648-569-2786', '8754 Mayfield Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10308, 'Serge Carville', 'scarville8l@last.fm', '409-262-9715', '2399 Michigan Way');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10309, 'Bel Klees', 'bklees8m@google.fr', '330-267-3806', '5 Mitchell Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10310, 'Gilberto Ivancevic', 'givancevic8n@hibu.com', '408-662-1671', '2399 Golf Course Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10311, 'Aleta Bunclark', 'abunclark8o@gmpg.org', '976-382-5124', '3 Duke Junction');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10312, 'Sorcha Freeth', 'sfreeth8p@bravesites.com', '485-873-1407', '681 Kim Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10313, 'Ruperta Pursey', 'rpursey8q@technorati.com', '776-724-9684', '51552 Magdeline Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10314, 'Tessa Poyntz', 'tpoyntz8r@google.es', '480-684-8429', '39 Blaine Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10315, 'Janey Piscot', 'jpiscot8s@alexa.com', '966-787-1024', '44 Fieldstone Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10316, 'Brennen Toope', 'btoope8t@youku.com', '739-796-5765', '08595 Aberg Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10317, 'Hirsch Lippatt', 'hlippatt8u@upenn.edu', '240-544-5630', '82509 School Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10318, 'Cyndia Greener', 'cgreener8v@epa.gov', '785-999-4956', '85 Blaine Park');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10319, 'Karin Oganesian', 'koganesian8w@timesonline.co.uk', '752-830-3295', '14 Merry Park');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10320, 'Evvy Cosstick', 'ecosstick8x@examiner.com', '507-629-0325', '74 Erie Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10321, 'Essie Jenteau', 'ejenteau8y@wikispaces.com', '948-596-9210', '77 Mayfield Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10322, 'Nilson Stoney', 'nstoney8z@photobucket.com', '554-222-7609', '4277 Eagle Crest Way');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10323, 'Rad Blampey', 'rblampey90@prlog.org', '323-270-3138', '983 Summit Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10324, 'Constantina Flanaghan', 'cflanaghan91@zdnet.com', '563-415-0805', '0 Arrowood Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10325, 'Hillary Rushbury', 'hrushbury92@spotify.com', '685-493-8637', '85 Farmco Center');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10326, 'Berget Poker', 'bpoker93@apache.org', '758-678-1032', '6 Spohn Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10327, 'Colet Adrienne', 'cadrienne94@theguardian.com', '983-680-3978', '1 Oriole Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10328, 'Anallese Dudley', 'adudley95@google.ca', '726-885-5541', '5 Oak Center');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10329, 'Fedora Maplethorpe', 'fmaplethorpe96@soup.io', '976-981-5732', '32305 Union Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10330, 'Gustaf Johann', 'gjohann97@blogger.com', '444-134-6235', '16444 Hazelcrest Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10331, 'Lucinda Algore', 'lalgore98@1und1.de', '416-819-9438', '43970 Alpine Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10332, 'Sharron Manach', 'smanach99@macromedia.com', '748-535-9752', '77 7th Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10333, 'Madelina Tander', 'mtander9a@histats.com', '158-389-1462', '123 Meadow Valley Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10334, 'Darin Stonebridge', 'dstonebridge9b@jimdo.com', '961-940-2733', '57 Village Green Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10335, 'Willetta Prangley', 'wprangley9c@whitehouse.gov', '477-462-0351', '6168 Fulton Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10336, 'Marielle Halliday', 'mhalliday9d@ibm.com', '918-109-7998', '26 Knutson Park');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10337, 'Xena Antoniou', 'xantoniou9e@unicef.org', '409-206-5092', '26262 Holmberg Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10338, 'Celesta Eccleshare', 'ceccleshare9f@mayoclinic.com', '830-896-4035', '49 Macpherson Park');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10339, 'Verene Caselick', 'vcaselick9g@seesaa.net', '549-737-9536', '2538 Utah Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10340, 'Melesa Middlemist', 'mmiddlemist9h@trellian.com', '329-936-8428', '110 Rowland Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10341, 'Alisha Cuttelar', 'acuttelar9i@timesonline.co.uk', '881-530-4688', '14553 American Ash Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10342, 'Arlan Fairbank', 'afairbank9j@addtoany.com', '547-692-7873', '751 Melrose Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10343, 'Ruperta Succamore', 'rsuccamore9k@army.mil', '846-177-3759', '3 Messerschmidt Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10344, 'Bobbie Birtwistle', 'bbirtwistle9l@cisco.com', '908-921-2556', '474 Bowman Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10345, 'Courtnay Hebble', 'chebble9m@rediff.com', '236-764-6797', '40517 Rutledge Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10346, 'Cate Postles', 'cpostles9n@unblog.fr', '729-555-8933', '78921 Artisan Circle');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10347, 'Siouxie Wakenshaw', 'swakenshaw9o@cargocollective.com', '280-887-2414', '67 Fallview Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10348, 'Carlene Holby', 'cholby9p@diigo.com', '757-938-0946', '9765 Grayhawk Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10349, 'Wyatt Egger', 'wegger9q@noaa.gov', '675-499-4342', '8 Harper Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10350, 'Noelle Pixton', 'npixton9r@miitbeian.gov.cn', '239-518-8099', '441 Bayside Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10351, 'Trevor Izhaky', 'tizhaky9s@github.com', '632-266-8611', '957 Springs Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10352, 'Stormi Gulley', 'sgulley9t@live.com', '780-828-6477', '196 Jay Park');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10353, 'Lincoln Burt', 'lburt9u@google.ca', '737-187-3852', '1050 Carpenter Circle');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10354, 'Sergeant Sommerland', 'ssommerland9v@over-blog.com', '939-797-6943', '63 Bunker Hill Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10355, 'Benny Spadollini', 'bspadollini9w@comsenz.com', '970-595-6205', '8 Londonderry Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10356, 'Gare Sorrie', 'gsorrie9x@dell.com', '556-892-1941', '04 Eastwood Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10357, 'Marianne Ferreira', 'mferreira9y@biblegateway.com', '502-425-3156', '566 Randy Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10358, 'Ginny Springthorpe', 'gspringthorpe9z@earthlink.net', '310-663-6602', '0 Westport Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10359, 'Huberto Tincey', 'htinceya0@lulu.com', '559-424-0157', '197 Waywood Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10360, 'Zabrina Vondra', 'zvondraa1@dailymotion.com', '754-477-9699', '41 Burning Wood Center');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10361, 'Herminia Bush', 'hbusha2@lycos.com', '541-657-4023', '251 Drewry Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10362, 'Martino Trahar', 'mtrahara3@vinaora.com', '620-177-9419', '50 Dottie Center');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10363, 'Kora Learoyd', 'klearoyda4@illinois.edu', '198-272-8758', '67 Arkansas Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10364, 'Uri Hailwood', 'uhailwooda5@ucoz.com', '675-145-5770', '95 Brentwood Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10365, 'Mick Pluvier', 'mpluviera6@amazon.com', '526-547-0050', '1 Lindbergh Road');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10366, 'Lauren Henryson', 'lhenrysona7@tripod.com', '326-648-4402', '49443 Toban Park');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10367, 'Adan Sandyfirth', 'asandyfirtha8@yahoo.co.jp', '996-984-9055', '913 Ohio Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10368, 'Isaiah Orris', 'iorrisa9@shinystat.com', '616-745-7735', '8747 Farwell Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10369, 'Sigismondo Trowill', 'strowillaa@epa.gov', '444-280-9941', '707 Portage Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10370, 'Shawn Maruszewski', 'smaruszewskiab@goo.gl', '662-317-8072', '10 Debs Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10371, 'Adam Greeveson', 'agreevesonac@nationalgeographic.com', '643-921-6360', '8998 Carpenter Way');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10372, 'Wells Aitcheson', 'waitchesonad@bravesites.com', '501-995-6348', '2251 Algoma Way');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10373, 'Carolina Maryott', 'cmaryottae@wordpress.org', '634-190-9758', '7 Pierstorff Junction');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10374, 'Darlleen Mochan', 'dmochanaf@barnesandnoble.com', '303-781-8001', '2 Drewry Circle');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10375, 'Corry Hauxby', 'chauxbyag@unesco.org', '302-294-4276', '15991 Maple Wood Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10376, 'Felix Pickup', 'fpickupah@rakuten.co.jp', '167-677-3592', '1548 Sycamore Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10377, 'Isidoro Ernke', 'iernkeai@sogou.com', '708-436-4287', '1 Oriole Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10378, 'Caitlin Ogborne', 'cogborneaj@dell.com', '719-767-4619', '1 Raven Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10379, 'Georg Ivoshin', 'givoshinak@blogtalkradio.com', '859-920-7434', '4871 Bunker Hill Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10380, 'Cynthy Sage', 'csageal@army.mil', '418-546-5057', '0684 Maple Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10381, 'Konrad Partner', 'kpartneram@miitbeian.gov.cn', '864-254-7460', '87495 Luster Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10382, 'Arlene Mabbott', 'amabbottan@xinhuanet.com', '755-296-7950', '74 Shoshone Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10383, 'Christyna MacBrearty', 'cmacbreartyao@irs.gov', '184-475-8998', '79 Oak Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10384, 'Saidee Somerset', 'ssomersetap@sohu.com', '287-640-5854', '07625 Lerdahl Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10385, 'Natalie Forre', 'nforreaq@booking.com', '644-703-7445', '9 Nobel Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10386, 'Joellen MacCorley', 'jmaccorleyar@kickstarter.com', '422-404-1082', '5890 Main Park');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10387, 'Codi Janik', 'cjanikas@1688.com', '838-309-5346', '8014 Laurel Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10388, 'Merrily Prescot', 'mprescotat@sogou.com', '828-204-3644', '775 Stoughton Park');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10389, 'Bear Volcker', 'bvolckerau@wikimedia.org', '272-373-0085', '6785 Gateway Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10390, 'Gilberta Szimon', 'gszimonav@bing.com', '787-901-6468', '7644 Bartillon Way');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10391, 'Courtenay Meek', 'cmeekaw@ask.com', '103-969-7752', '2 Bluestem Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10392, 'Milly Billyard', 'mbillyardax@vistaprint.com', '746-163-2059', '941 Towne Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10393, 'Jamima Main', 'jmainay@fastcompany.com', '728-926-2042', '5418 Sauthoff Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10394, 'Lina Championnet', 'lchampionnetaz@myspace.com', '563-304-5839', '72 Northfield Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10395, 'Gonzales Spaldin', 'gspaldinb0@nasa.gov', '740-629-2125', '1 Rowland Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10396, 'Tremaine Tennant', 'ttennantb1@nih.gov', '534-161-7231', '7866 Chinook Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10397, 'Lin O''Bradane', 'lobradaneb2@huffingtonpost.com', '364-513-9153', '11678 Milwaukee Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10398, 'Alden Sanders', 'asandersb3@weather.com', '343-292-1967', '045 Coleman Circle');
commit;
prompt 400 records committed...
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10399, 'Bianka Tomblett', 'btomblettb4@webnode.com', '998-759-1663', '91 Tony Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10400, 'Randi Monkeman', 'rmonkemanb5@nps.gov', '768-254-2194', '2102 East Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10401, 'Olivia De La Cote', 'odeb6@yolasite.com', '277-742-6463', '26920 Beilfuss Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10402, 'Leonid Ivankin', 'livankinb7@scribd.com', '407-459-2440', '4222 Fuller Park');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10403, 'Nissa Roskelley', 'nroskelleyb8@go.com', '131-391-1659', '89 Hansons Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10404, 'Garth Posvner', 'gposvnerb9@webs.com', '176-897-3959', '659 Hollow Ridge Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10405, 'Con MacKinnon', 'cmackinnonba@hugedomains.com', '997-434-3535', '066 Hollow Ridge Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10406, 'Mill Noor', 'mnoorbb@wired.com', '179-954-2186', '7528 Melody Junction');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10407, 'Osbourn Snelman', 'osnelmanbc@goo.ne.jp', '352-911-0484', '6483 Green Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10408, 'Katharina D''Oyley', 'kdoyleybd@webeden.co.uk', '603-605-0734', '0993 Chinook Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10409, 'Chico Nerney', 'cnerneybe@bbb.org', '818-974-7865', '29 Kropf Circle');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10410, 'Giraud Diegan', 'gdieganbf@earthlink.net', '830-783-1762', '0524 Pine View Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10411, 'Benedikt Brookwood', 'bbrookwoodbg@mozilla.com', '677-283-6898', '65 Lillian Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10412, 'Cookie Sapsford', 'csapsfordbh@cdc.gov', '168-257-6870', '5 Nancy Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10413, 'Caldwell Schruyers', 'cschruyersbi@oracle.com', '405-600-9332', '46566 Morrow Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10414, 'Deina Friedman', 'dfriedmanbj@google.it', '895-306-4503', '4 Helena Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10415, 'Bradford Caban', 'bcabanbk@ask.com', '239-404-2465', '0917 Buell Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10416, 'Maryrose Viveash', 'mviveashbl@java.com', '288-314-7695', '836 Melvin Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10417, 'Kahlil Landes', 'klandesbm@people.com.cn', '664-759-2074', '8 Riverside Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10418, 'Bibby Ralestone', 'bralestonebn@nsw.gov.au', '564-192-9725', '616 Melrose Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10419, 'Coraline Eskrigge', 'ceskriggebo@wordpress.com', '218-433-1966', '044 Union Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10420, 'Dionis Eyre', 'deyrebp@creativecommons.org', '880-365-1613', '16113 Prairieview Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10421, 'Marchelle Fannon', 'mfannonbq@newyorker.com', '348-921-4466', '78015 Longview Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10422, 'Ferdie Waker', 'fwakerbr@sitemeter.com', '545-666-0863', '549 Goodland Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10423, 'Penni Stitfall', 'pstitfallbs@liveinternet.ru', '110-361-8673', '8011 Hallows Circle');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10424, 'Jory Eadington', 'jeadingtonbt@discovery.com', '443-614-8508', '95 Moland Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10425, 'Josephina Booty', 'jbootybu@privacy.gov.au', '472-519-9584', '341 Arrowood Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10426, 'Issiah Wiltshear', 'iwiltshearbv@ebay.com', '563-329-3701', '2555 Roth Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10427, 'Nat Drewery', 'ndrewerybw@npr.org', '979-378-9711', '35349 Jackson Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10428, 'Ephrayim Gallier', 'egallierbx@ft.com', '867-935-0701', '00 Hermina Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10429, 'Heinrik Hobgen', 'hhobgenby@t.co', '352-284-9083', '38673 La Follette Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10430, 'Auberon Moyle', 'amoylebz@ebay.com', '966-444-2414', '95 Maple Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10431, 'Aland Gascoyne', 'agascoynec0@redcross.org', '826-451-8957', '95666 East Park');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10432, 'Mar Antonich', 'mantonichc1@hugedomains.com', '576-414-4305', '73792 Knutson Road');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10433, 'Markus Snaddin', 'msnaddinc2@jimdo.com', '575-414-2817', '33 Vermont Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10434, 'Dallas Saunton', 'dsauntonc3@dailymotion.com', '576-772-1501', '92700 Cherokee Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10435, 'Byrle Howles', 'bhowlesc4@tuttocitta.it', '160-714-3190', '09592 Cordelia Way');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10436, 'Minette Sauniere', 'msaunierec5@networkadvertising.org', '786-820-0178', '22020 Mallory Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10437, 'Nolie Huske', 'nhuskec6@cloudflare.com', '101-842-8063', '292 Northview Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10438, 'Pat Shayes', 'pshayesc7@comsenz.com', '646-924-6801', '7 Orin Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10439, 'Eartha Furnell', 'efurnellc8@123-reg.co.uk', '466-740-2757', '0907 Lakewood Gardens Way');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10440, 'Hugo Pozzo', 'hpozzoc9@ning.com', '809-559-3589', '3 Fulton Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10441, 'Nealon Gidman', 'ngidmanca@arstechnica.com', '424-416-3649', '4 Mandrake Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10442, 'Ivy Hentzer', 'ihentzercb@merriam-webster.com', '479-826-2957', '44957 Oxford Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10443, 'Tate Ply', 'tplycc@dailymail.co.uk', '659-715-9072', '61516 Oneill Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10444, 'Ruddie MacFarlan', 'rmacfarlancd@istockphoto.com', '106-894-3401', '40119 Garrison Way');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10445, 'Kim Brosoli', 'kbrosolice@rambler.ru', '101-829-0751', '8387 Rieder Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10446, 'Dian Haselgrove', 'dhaselgrovecf@biglobe.ne.jp', '178-721-6324', '0 Everett Circle');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10447, 'Linus Markus', 'lmarkuscg@youtu.be', '622-257-7798', '60569 Morningstar Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10448, 'Lucy Courcey', 'lcourceych@census.gov', '392-448-4684', '29537 Artisan Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10449, 'Frans McLeoid', 'fmcleoidci@stanford.edu', '587-617-1542', '94 Washington Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10450, 'Hilliary Plumtree', 'hplumtreecj@bloglines.com', '232-451-4882', '709 Barby Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10451, 'Odo Patchett', 'opatchettck@tiny.cc', '838-261-0348', '5798 Briar Crest Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10452, 'Lise Moffat', 'lmoffatcl@dagondesign.com', '398-550-1393', '2 Delaware Circle');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10453, 'Audie Belf', 'abelfcm@ebay.com', '872-238-3089', '0 Fremont Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10454, 'Tymothy Geffe', 'tgeffecn@sina.com.cn', '341-899-8416', '3 Sommers Center');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10455, 'Lucina Cowndley', 'lcowndleyco@opera.com', '875-490-6185', '22 Milwaukee Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10456, 'Midge Bewsey', 'mbewseycp@example.com', '697-957-2521', '85 Fulton Road');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10457, 'Shanta O''Sharkey', 'sosharkeycq@uiuc.edu', '128-128-2848', '933 Anderson Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10458, 'Philippe Rosewarne', 'prosewarnecr@behance.net', '651-427-9681', '197 Merry Way');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10459, 'Mycah Scibsey', 'mscibseycs@omniture.com', '791-139-6338', '5200 Independence Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10460, 'Paulie Copping', 'pcoppingct@eepurl.com', '770-350-5041', '530 Scott Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10461, 'Cassandry Criag', 'ccriagcu@dyndns.org', '822-923-9333', '77579 Manitowish Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10462, 'Elysee Micklem', 'emicklemcv@google.pl', '349-958-0998', '123 Barnett Park');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10463, 'Kristal Braben', 'kbrabencw@rediff.com', '300-994-0525', '01 Bay Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10464, 'Boycie Cartledge', 'bcartledgecx@weather.com', '901-451-5960', '93 Granby Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10465, 'Nestor Leving', 'nlevingcy@columbia.edu', '341-436-4384', '2183 Heffernan Way');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10466, 'Inigo Bunclark', 'ibunclarkcz@gmpg.org', '601-895-6178', '44770 Cherokee Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10467, 'Batholomew Hawes', 'bhawesd0@free.fr', '981-523-3809', '803 Butterfield Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10468, 'Ted Trower', 'ttrowerd1@cyberchimps.com', '771-861-8206', '5 Raven Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10469, 'Tailor Trethewey', 'ttretheweyd2@gizmodo.com', '379-936-0089', '0866 Grim Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10470, 'Tamma O''Mailey', 'tomaileyd3@walmart.com', '141-816-5600', '27 Fallview Junction');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10471, 'Peyter Bineham', 'pbinehamd4@bloglines.com', '565-509-8155', '3 Crowley Center');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10472, 'Ashby Boissier', 'aboissierd5@creativecommons.org', '251-949-1517', '59776 Sherman Circle');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10473, 'Carie Plumridge', 'cplumridged6@zimbio.com', '589-629-8579', '996 Toban Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10474, 'Jeniffer Stidson', 'jstidsond7@github.io', '548-619-0800', '83346 Village Green Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10475, 'Cord Jereatt', 'cjereattd8@bloomberg.com', '403-467-9092', '06 Arkansas Junction');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10476, 'Ami Bullivent', 'abulliventd9@thetimes.co.uk', '698-721-6818', '011 Aberg Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10477, 'Enoch Mucillo', 'emucilloda@xing.com', '436-281-3297', '7626 Merrick Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10478, 'Korie Mullaney', 'kmullaneydb@vk.com', '304-860-3552', '561 Northridge Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10479, 'Giraud Calbreath', 'gcalbreathdc@patch.com', '251-892-1042', '03 High Crossing Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10480, 'Paige Lydster', 'plydsterdd@earthlink.net', '989-664-5015', '78195 Jenna Way');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10481, 'Carmelina Yuille', 'cyuillede@usatoday.com', '742-485-4580', '0 Graedel Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10482, 'Junette Grisedale', 'jgrisedaledf@biglobe.ne.jp', '107-201-1541', '95 Onsgard Road');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10483, 'Ezequiel Kinnar', 'ekinnardg@so-net.ne.jp', '422-633-3343', '6 North Center');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10484, 'Myca Chesswas', 'mchesswasdh@privacy.gov.au', '326-903-4830', '27405 Vernon Junction');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10485, 'Elinor Darwent', 'edarwentdi@china.com.cn', '713-480-1399', '5 Manitowish Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10486, 'Venus McGonagle', 'vmcgonagledj@themeforest.net', '129-335-1757', '9019 Kipling Center');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10487, 'Shalne Spitaro', 'sspitarodk@sphinn.com', '297-882-8392', '12 Logan Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10488, 'Dix Crone', 'dcronedl@dell.com', '319-737-8345', '26 Kropf Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10489, 'Almire Bayless', 'abaylessdm@nsw.gov.au', '787-694-6363', '4 Darwin Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10490, 'Edithe Kairns', 'ekairnsdn@dot.gov', '709-668-1895', '555 Randy Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10491, 'Linc Mulrenan', 'lmulrenando@typepad.com', '375-331-0222', '9 La Follette Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10492, 'Deeann Stoodale', 'dstoodaledp@google.com.au', '910-742-2174', '41 Colorado Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10493, 'Selinda Enser', 'senserdq@samsung.com', '425-777-5105', '4819 Dayton Way');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10494, 'Imelda Spehr', 'ispehrdr@weibo.com', '145-165-0289', '89 Bellgrove Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10495, 'Tirrell Carleton', 'tcarletonds@independent.co.uk', '714-427-4045', '16 Sunbrook Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10496, 'Hailee Clohisey', 'hclohiseydt@mapquest.com', '203-722-9268', '951 Everett Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10497, 'Rhodie Bulfield', 'rbulfielddu@ucsd.edu', '194-914-4949', '678 Surrey Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10498, 'Drucy Jacqueminot', 'djacqueminotdv@amazonaws.com', '557-245-9537', '256 Scofield Plaza');
commit;
prompt 500 records committed...
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10499, 'Bethanne Champneys', 'bchampneysdw@prlog.org', '895-938-6599', '470 Mccormick Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10500, 'Wini Allott', 'wallottdx@ehow.com', '581-529-1218', '53209 School Junction');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10501, 'Marshal Bastiman', 'mbastimandy@auda.org.au', '865-164-9090', '042 Lakewood Gardens Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10502, 'Gabie Navein', 'gnaveindz@samsung.com', '349-199-3979', '44945 Reindahl Park');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10503, 'Amelia McGrill', 'amcgrille0@reddit.com', '531-683-6250', '110 Starling Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10504, 'Cathe Minto', 'cmintoe1@blinklist.com', '533-251-7513', '15 Gale Road');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10505, 'Judas Aulsford', 'jaulsforde2@biglobe.ne.jp', '123-226-8097', '7 Vahlen Road');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10506, 'Teodoro Frances', 'tfrancese3@meetup.com', '340-513-3664', '0050 5th Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10507, 'Zondra Didsbury', 'zdidsburye4@artisteer.com', '700-437-3042', '61727 Haas Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10508, 'Lyndsie Paton', 'lpatone5@ox.ac.uk', '950-919-1148', '28862 Milwaukee Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10509, 'Bonni Elphee', 'belpheee6@icq.com', '858-979-0431', '77 Hayes Park');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10510, 'Nadia Giordano', 'ngiordanoe7@paginegialle.it', '848-486-3227', '6 Kennedy Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10511, 'Vina Richly', 'vrichlye8@e-recht24.de', '756-129-2412', '49 Pearson Circle');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10512, 'Martica Forten', 'mfortene9@domainmarket.com', '562-226-5968', '2 Miller Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10513, 'Corrie Jakucewicz', 'cjakucewiczea@ox.ac.uk', '412-858-1247', '36041 Melrose Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10514, 'Una Jepensen', 'ujepenseneb@ibm.com', '109-994-0769', '4403 Walton Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10515, 'Naoma Borrows', 'nborrowsec@github.com', '950-638-4176', '312 Sycamore Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10516, 'Rube Brignall', 'rbrignalled@godaddy.com', '471-234-4353', '28 Tomscot Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10517, 'Hermon Colliard', 'hcolliardee@oakley.com', '653-113-2365', '5345 Stang Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10518, 'Deck Asche', 'dascheef@mashable.com', '772-795-8445', '8 Glacier Hill Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10519, 'Elston Smieton', 'esmietoneg@hao123.com', '241-211-7218', '14 Clarendon Road');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10520, 'Odilia Bimrose', 'obimroseeh@epa.gov', '472-301-7602', '79 Manufacturers Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10521, 'Karissa Halton', 'khaltonei@so-net.ne.jp', '761-995-5705', '99974 Norway Maple Park');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10522, 'Sela Row', 'srowej@slashdot.org', '950-203-5986', '47866 Chinook Way');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10523, 'Karlyn Hargreves', 'khargrevesek@bloglovin.com', '980-756-4421', '35457 2nd Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10524, 'Alberta Bramstom', 'abramstomel@bigcartel.com', '299-107-2448', '1238 Fordem Way');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10525, 'Orran Dametti', 'odamettiem@smugmug.com', '122-780-5477', '7 Novick Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10526, 'Nessa Lazell', 'nlazellen@privacy.gov.au', '982-445-8515', '70 Bonner Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10527, 'Ede Kilby', 'ekilbyeo@hibu.com', '559-600-7451', '65 Dapin Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10528, 'Siward Cowans', 'scowansep@delicious.com', '658-874-9966', '08529 Swallow Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10529, 'Yvette Serraillier', 'yserrailliereq@patch.com', '143-563-7180', '8 Buell Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10530, 'Idette Stripling', 'istriplinger@bbb.org', '443-239-2261', '68629 Debs Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10531, 'Armstrong Whitcombe', 'awhitcombees@sitemeter.com', '381-361-7225', '23775 Dayton Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10532, 'Elga Khotler', 'ekhotleret@wordpress.com', '909-447-7603', '39 Debra Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10533, 'Kathryne Geraldini', 'kgeraldinieu@is.gd', '511-365-6618', '5977 Mccormick Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10534, 'Penni Bremley', 'pbremleyev@hugedomains.com', '945-539-2301', '8 Hansons Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10535, 'Ruthi Orpin', 'rorpinew@aol.com', '504-995-5795', '4468 Forest Dale Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10536, 'Izaak Pendlebery', 'ipendleberyex@usa.gov', '541-491-2065', '64 Dorton Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10537, 'Casi Nassy', 'cnassyey@youtu.be', '768-386-4700', '748 Annamark Park');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10538, 'Thatcher Lassey', 'tlasseyez@google.co.jp', '686-992-4263', '38015 Melvin Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10539, 'Mildrid McClaurie', 'mmcclaurief0@360.cn', '329-157-8109', '7549 Johnson Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10540, 'Torrie Reith', 'treithf1@prnewswire.com', '930-568-4203', '418 Namekagon Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10541, 'Fayre Dorling', 'fdorlingf2@businessweek.com', '926-409-0981', '6417 Bunker Hill Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10542, 'Loren Braid', 'lbraidf3@upenn.edu', '635-404-9562', '9558 Cody Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10543, 'Arielle McKew', 'amckewf4@techcrunch.com', '123-301-5757', '398 Sheridan Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10544, 'Whit Odda', 'woddaf5@wikia.com', '698-560-7757', '7 Declaration Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10545, 'Latashia Kausche', 'lkauschef6@yahoo.co.jp', '144-563-2067', '62571 Southridge Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10546, 'Carolyne Squibe', 'csquibef7@bandcamp.com', '672-472-0572', '4 Tony Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10547, 'Clareta Meek', 'cmeekf8@geocities.com', '856-125-6580', '85 Maryland Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10548, 'Juanita Janak', 'jjanakf9@51.la', '287-404-1733', '94 Mendota Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10549, 'Alvinia Arthan', 'aarthanfa@ucsd.edu', '522-331-6079', '66 Onsgard Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10550, 'Eleanor Canton', 'ecantonfb@storify.com', '135-409-6980', '03 Del Mar Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10551, 'Cos Drayton', 'cdraytonfc@goo.gl', '828-691-4629', '687 Green Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10552, 'Valina Courtney', 'vcourtneyfd@mozilla.com', '802-627-3878', '5 Lakewood Gardens Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10553, 'Katerina Russo', 'krussofe@tuttocitta.it', '827-670-0790', '93 Brickson Park Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10554, 'Mose Circuitt', 'mcircuittff@mozilla.com', '380-820-4437', '92 Gale Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10555, 'Elia Flade', 'efladefg@purevolume.com', '527-436-4193', '624 Browning Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10556, 'Luciano Brito', 'lbritofh@boston.com', '470-108-5346', '8476 Derek Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10557, 'Gabriell Coady', 'gcoadyfi@hubpages.com', '744-495-5533', '2930 Ohio Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10558, 'Jeni Carling', 'jcarlingfj@rakuten.co.jp', '944-569-9375', '6 Monument Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10559, 'Chet Rucklidge', 'crucklidgefk@unicef.org', '223-578-8722', '24455 Ridgeway Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10560, 'Irita Kinsley', 'ikinsleyfl@liveinternet.ru', '639-447-1796', '392 Schlimgen Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10561, 'Pall Glassford', 'pglassfordfm@omniture.com', '999-501-9275', '92120 Erie Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10562, 'Cchaddie Barnard', 'cbarnardfn@guardian.co.uk', '999-770-9923', '5 3rd Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10563, 'Gregor Hess', 'ghessfo@admin.ch', '271-133-1978', '8 Mockingbird Center');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10564, 'Hewett Tiebe', 'htiebefp@mediafire.com', '498-200-2226', '38163 Ramsey Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10565, 'Pietra Robyns', 'probynsfq@myspace.com', '358-459-8884', '809 Susan Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10566, 'Blake Wheatland', 'bwheatlandfr@tmall.com', '639-996-6500', '2723 Ridgeview Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10567, 'Patty Hollow', 'phollowfs@furl.net', '770-127-2566', '988 Beilfuss Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10568, 'Adrian Hegley', 'ahegleyft@jugem.jp', '110-455-6359', '1688 Almo Park');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10569, 'Davide Ealden', 'dealdenfu@usda.gov', '789-339-8174', '320 Red Cloud Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10570, 'Godfry Turl', 'gturlfv@paypal.com', '333-839-4049', '93 North Center');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10571, 'Brina Harkness', 'bharknessfw@harvard.edu', '652-334-7164', '1 Maple Wood Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10572, 'Alberik Fortnon', 'afortnonfx@phpbb.com', '714-383-3756', '6429 Lakeland Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10573, 'Nicholas Marre', 'nmarrefy@paypal.com', '386-301-1608', '88222 Amoth Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10574, 'Pierrette Barns', 'pbarnsfz@myspace.com', '457-446-5008', '2039 Raven Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10575, 'Tobe Tower', 'ttowerg0@geocities.jp', '846-165-0107', '7621 Lake View Road');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10576, 'Aggy Lennie', 'alennieg1@squidoo.com', '801-168-3934', '35 Warner Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10577, 'Susanna Wharin', 'swharing2@bing.com', '701-492-9333', '3 Merry Center');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10578, 'Alonzo Mackelworth', 'amackelworthg3@infoseek.co.jp', '439-727-6069', '7179 Eagan Center');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10579, 'Lawry Moorfield', 'lmoorfieldg4@dmoz.org', '420-622-0267', '81 Becker Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10580, 'Joice Burgne', 'jburgneg5@netvibes.com', '366-289-2649', '79 Erie Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10581, 'Christye Bardell', 'cbardellg6@webmd.com', '546-943-5149', '21 Cottonwood Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10582, 'Ralf Murray', 'rmurrayg7@123-reg.co.uk', '871-492-2638', '9317 Birchwood Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10583, 'Rochester Grutchfield', 'rgrutchfieldg8@studiopress.com', '347-984-6842', '94729 Parkside Center');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10584, 'Carlynn Preto', 'cpretog9@hhs.gov', '527-176-8887', '809 Merry Park');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10585, 'Carmon Sprules', 'csprulesga@weebly.com', '504-654-7001', '8574 Pennsylvania Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10586, 'Dukey McCully', 'dmccullygb@examiner.com', '448-871-5852', '8 Havey Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10587, 'Aimil Grunson', 'agrunsongc@live.com', '732-245-9885', '7321 Loeprich Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10588, 'Hilton Broggetti', 'hbroggettigd@last.fm', '417-983-8383', '0 Kinsman Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10589, 'Donia Shiliton', 'dshilitonge@time.com', '110-395-4341', '6315 Grasskamp Circle');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10590, 'Alfy Roadknight', 'aroadknightgf@home.pl', '649-107-1956', '9 Union Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10591, 'Cornelle Ashbolt', 'cashboltgg@elegantthemes.com', '729-951-5142', '728 Oriole Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10592, 'Tremaine Van der Baaren', 'tvangh@usatoday.com', '408-975-9645', '6 Golf Course Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10593, 'Grantham St. John', 'gstgi@usgs.gov', '849-759-3049', '7694 Oakridge Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10594, 'Elisabetta Toombes', 'etoombesgj@cmu.edu', '355-719-7943', '62714 Dexter Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10595, 'Stavros O''Kenny', 'sokennygk@about.me', '471-286-8701', '52195 Nova Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10596, 'Piotr Osmant', 'posmantgl@dailymail.co.uk', '542-762-8022', '67 Monterey Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10597, 'Shoshana Bringloe', 'sbringloegm@ycombinator.com', '127-856-2484', '77 Paget Road');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10598, 'Pat Crabb', 'pcrabbgn@forbes.com', '401-464-7044', '4 Killdeer Park');
commit;
prompt 600 records committed...
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10599, 'Chick Nann', 'cnanngo@nsw.gov.au', '467-774-4760', '0555 Sugar Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10600, 'Ilse Etuck', 'ietuckgp@trellian.com', '247-728-4721', '06 Kim Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10601, 'Web De Roberto', 'wdegq@furl.net', '209-110-2496', '12564 Buena Vista Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10602, 'Elinor MacDermot', 'emacdermotgr@diigo.com', '963-963-2940', '75 Eastwood Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10603, 'Wenona Martinat', 'wmartinatgs@comcast.net', '241-791-8333', '4087 Sunnyside Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10604, 'Chadwick Karpe', 'ckarpegt@netlog.com', '415-983-6420', '3 Sherman Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10605, 'Florance Roughan', 'froughangu@cdbaby.com', '632-652-8669', '6124 Forster Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10606, 'Kikelia Maybury', 'kmayburygv@deliciousdays.com', '815-411-5978', '5630 Ronald Regan Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10607, 'Colan Rosiello', 'crosiellogw@themeforest.net', '871-174-6358', '5693 Golf Course Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10608, 'Karlis Mancer', 'kmancergx@about.com', '835-830-6066', '687 Pearson Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10609, 'Emily Leith-Harvey', 'eleithharveygy@uol.com.br', '637-501-1673', '23547 Sycamore Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10610, 'Linn Fullalove', 'lfullalovegz@microsoft.com', '184-899-5338', '2246 Buhler Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10611, 'Angel Tolmie', 'atolmieh0@ebay.co.uk', '856-939-9920', '84 Buell Circle');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10612, 'Sumner Ellingsworth', 'sellingsworthh1@1688.com', '498-275-8708', '5502 Schurz Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10613, 'Prudi Stambridge', 'pstambridgeh2@myspace.com', '473-461-3830', '151 Old Shore Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10614, 'Emma Cofax', 'ecofaxh3@bloglovin.com', '925-971-6700', '3 Hermina Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10615, 'Cindra Scantleberry', 'cscantleberryh4@hexun.com', '187-775-8576', '324 Claremont Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10616, 'Lorry Hamsley', 'lhamsleyh5@google.com.au', '936-711-6688', '79948 Kings Junction');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10617, 'Darnell Hawton', 'dhawtonh6@stanford.edu', '537-696-9491', '90 Aberg Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10618, 'Albertina Camlin', 'acamlinh7@icio.us', '420-145-4579', '90674 Hagan Road');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10619, 'Ernesto Armfirld', 'earmfirldh8@businessweek.com', '419-396-8828', '9749 Arapahoe Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10620, 'Karrie Martinyuk', 'kmartinyukh9@princeton.edu', '259-957-4365', '7781 Rowland Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10621, 'Cristi Thorogood', 'cthorogoodha@ocn.ne.jp', '114-537-5401', '931 Ryan Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10622, 'Thoma Cuffley', 'tcuffleyhb@storify.com', '360-109-0561', '403 Michigan Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10623, 'Creighton Howsden', 'chowsdenhc@google.com', '528-500-0380', '2274 Carioca Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10624, 'Lise Tongs', 'ltongshd@redcross.org', '502-226-7946', '47 Lerdahl Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10625, 'Jessalin Ricardot', 'jricardothe@hatena.ne.jp', '792-620-7340', '3 Gale Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10626, 'Lindsey Yeardsley', 'lyeardsleyhf@adobe.com', '452-466-3429', '98 Jenifer Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10627, 'Heywood Balloch', 'hballochhg@hp.com', '515-309-1906', '58 Cordelia Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10628, 'Sandro Tipler', 'stiplerhh@bluehost.com', '804-189-5037', '654 Southridge Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10629, 'Allyce Pietruszka', 'apietruszkahi@163.com', '812-969-3814', '7870 Kings Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10630, 'Feliks Sheber', 'fsheberhj@odnoklassniki.ru', '513-126-6537', '217 Sutherland Park');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10631, 'Miner Beckles', 'mbeckleshk@dailymotion.com', '355-256-4814', '28542 Scott Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10632, 'Frankie Sergison', 'fsergisonhl@marriott.com', '423-110-6838', '4021 Algoma Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10633, 'Terri Vaney', 'tvaneyhm@bing.com', '821-723-4491', '46172 Pleasure Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10634, 'Trent Bowcher', 'tbowcherhn@posterous.com', '509-555-7823', '4 Fuller Circle');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10635, 'Willamina Bleby', 'wblebyho@edublogs.org', '959-119-3906', '18 Sherman Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10636, 'Adrien Linskey', 'alinskeyhp@wired.com', '728-319-1368', '63 Kipling Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10637, 'Bendick Prestwich', 'bprestwichhq@npr.org', '681-752-4856', '6 Warner Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10638, 'Barbee Escreet', 'bescreethr@umich.edu', '164-328-0511', '6841 Tony Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10639, 'Urson Proffitt', 'uproffitths@behance.net', '882-316-4739', '9 Almo Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10640, 'Vyky Tench', 'vtenchht@berkeley.edu', '390-952-8755', '3635 Hallows Center');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10641, 'Pia Giberd', 'pgiberdhu@examiner.com', '924-478-9184', '8 Heffernan Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10642, 'Ad Malam', 'amalamhv@ihg.com', '951-225-6374', '93 Muir Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10643, 'Galen Winwright', 'gwinwrighthw@phoca.cz', '577-249-5263', '9 Crest Line Center');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10644, 'Rea Golden', 'rgoldenhx@youku.com', '864-376-5906', '581 Northport Circle');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10645, 'Elwood Quilty', 'equiltyhy@slate.com', '105-508-1439', '72556 Hazelcrest Junction');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10646, 'Harley Matyatin', 'hmatyatinhz@google.com.br', '111-281-6719', '59 Continental Drive');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10647, 'Alene Ferrar', 'aferrari0@uiuc.edu', '292-780-5271', '5069 Sauthoff Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10648, 'Nanon Harbar', 'nharbari1@cloudflare.com', '955-400-6674', '1378 Elgar Road');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10649, 'Dennie Tompkins', 'dtompkinsi2@biglobe.ne.jp', '681-603-7872', '3728 Lien Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10650, 'Lyn Jarrad', 'ljarradi3@trellian.com', '964-923-5811', '0351 Kedzie Road');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10651, 'Elsworth Mewha', 'emewhai4@usatoday.com', '361-195-1869', '631 American Ash Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10652, 'Bertie Sheach', 'bsheachi5@senate.gov', '482-599-1491', '666 Debra Place');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10653, 'Adams Bollum', 'abollumi6@skyrock.com', '146-995-8341', '2696 Northport Park');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10654, 'Margarita Lacy', 'mlacyi7@ca.gov', '739-236-7288', '48 Elka Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10655, 'Auroora Jandourek', 'ajandoureki8@elpais.com', '906-428-5561', '02 American Ash Circle');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10656, 'Antonino McNutt', 'amcnutti9@flavors.me', '851-705-6638', '7268 Straubel Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10657, 'Antonetta Stokes', 'astokesia@tinypic.com', '559-658-6391', '6 Hanson Circle');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10658, 'Jobyna Gudahy', 'jgudahyib@cisco.com', '101-958-6644', '607 Village Green Junction');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10659, 'Albert Brew', 'abrewic@google.ca', '267-639-2311', '1 1st Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10660, 'Agnola Troy', 'atroyid@hugedomains.com', '418-791-6031', '18 Express Center');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10661, 'Harold Lewson', 'hlewsonie@cnbc.com', '826-275-0869', '1 Morrow Junction');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10662, 'Kerwinn Crates', 'kcratesif@nps.gov', '360-174-2861', '81 Meadow Vale Road');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10663, 'Jami Mussett', 'jmussettig@blogtalkradio.com', '498-567-3607', '31823 Towne Road');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10664, 'Gae Andric', 'gandricih@omniture.com', '768-868-3177', '1649 Sheridan Circle');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10665, 'Hughie Stower', 'hstowerii@simplemachines.org', '993-384-4554', '142 Petterle Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10666, 'Becki Stukings', 'bstukingsij@nbcnews.com', '406-318-8000', '67500 Sheridan Road');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10667, 'Maisey Gaishson', 'mgaishsonik@unc.edu', '324-851-7018', '0 Nova Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10668, 'Yurik Jolland', 'yjollandil@posterous.com', '967-781-8810', '83419 Manufacturers Point');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10669, 'Rufus Ayre', 'rayreim@studiopress.com', '819-217-5427', '8165 Scofield Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10670, 'Gualterio Miall', 'gmiallin@woothemes.com', '945-501-5547', '964 Claremont Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10671, 'Blanche Mollene', 'bmolleneio@slate.com', '139-786-9195', '45767 Troy Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10672, 'Hilliard Strevens', 'hstrevensip@wufoo.com', '835-166-5330', '519 Randy Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10673, 'Dougy Beadles', 'dbeadlesiq@about.me', '716-371-3282', '4908 Pawling Parkway');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10674, 'Hugh Connick', 'hconnickir@marketwatch.com', '222-448-3564', '89935 Eastwood Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10675, 'Nelson Dimblebee', 'ndimblebeeis@samsung.com', '856-809-8034', '3 Blue Bill Park Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10676, 'Wilt Bushrod', 'wbushrodit@themeforest.net', '455-747-0240', '9088 Forster Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10677, 'Devonne Laughlin', 'dlaughliniu@dropbox.com', '118-547-6510', '7399 Muir Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10678, 'Quintilla Aiken', 'qaikeniv@blogspot.com', '528-186-0243', '871 Hintze Trail');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10679, 'Lexine Corneck', 'lcorneckiw@addthis.com', '714-627-9127', '27 Hansons Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10680, 'Parrnell Dellatorre', 'pdellatorreix@icio.us', '931-882-4327', '44721 Hanson Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10681, 'Anabella Marques', 'amarquesiy@answers.com', '680-644-9188', '4010 Chive Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10682, 'Annissa Shenton', 'ashentoniz@free.fr', '914-556-0894', '3 Southridge Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10683, 'Caleb Troke', 'ctrokej0@dailymotion.com', '474-908-7428', '49224 Amoth Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10684, 'Nicoli Isacq', 'nisacqj1@dell.com', '540-801-5869', '9291 Sunbrook Plaza');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10685, 'Maynord Daveridge', 'mdaveridgej2@sciencedirect.com', '394-748-5080', '77332 Milwaukee Road');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10686, 'Mariquilla Jarry', 'mjarryj3@lulu.com', '512-685-8149', '96429 Lotheville Court');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10687, 'Korney Chastanet', 'kchastanetj4@intel.com', '856-703-8043', '2 Pawling Hill');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10688, 'Towney Earngy', 'tearngyj5@privacy.gov.au', '197-410-9407', '1692 Hoffman Crossing');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10689, 'Sharleen Ferraraccio', 'sferraraccioj6@fotki.com', '429-378-7197', '63462 Golden Leaf Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10690, 'Kimball Scudder', 'kscudderj7@artisteer.com', '886-460-7755', '5395 Paget Alley');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10691, 'Whitaker Surfleet', 'wsurfleetj8@clickbank.net', '655-127-6192', '384 Butterfield Junction');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10692, 'Cherilynn Smidmoor', 'csmidmoorj9@newsvine.com', '974-618-4239', '5018 Stoughton Way');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10693, 'Dwain Brimilcombe', 'dbrimilcombeja@dedecms.com', '374-442-8504', '7 Corben Lane');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10694, 'Carmella Gostage', 'cgostagejb@51.la', '875-616-0963', '4 3rd Pass');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10695, 'Helaina Degan', 'hdeganjc@wisc.edu', '879-533-9306', '3 West Street');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10696, 'Claybourne Glavis', 'cglavisjd@wordpress.com', '939-153-4287', '97443 Tennyson Avenue');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10697, 'Harriette Rintoul', 'hrintoulje@diigo.com', '460-246-2662', '723 High Crossing Terrace');
insert into BUYERS (buyer_id, buyer_name, email, phone, address)
values (10698, 'Kare Gimeno', 'kgimenojf@slate.com', '654-359-6309', '0548 Bartillon Drive');
commit;
prompt 700 records loaded
prompt Loading CATEGORIES...
insert into CATEGORIES (category_id, category_name, information)
values (1, 'Computer Accessories', 'Enhance computer functionality with peripherals.');
insert into CATEGORIES (category_id, category_name, information)
values (2, 'Audio Equipment', 'Speakers and headphones for great sound.');
insert into CATEGORIES (category_id, category_name, information)
values (3, 'Office Supplies', 'Stands, lamps, and organizers for office.');
insert into CATEGORIES (category_id, category_name, information)
values (4, 'Networking', 'Routers and hubs for network management.');
insert into CATEGORIES (category_id, category_name, information)
values (5, 'Gaming Gear', 'Keyboards, consoles, VR headsets.');
insert into CATEGORIES (category_id, category_name, information)
values (6, 'Headphones & Earbuds', 'Personal audio: music, podcasts.');
insert into CATEGORIES (category_id, category_name, information)
values (7, 'Mobile Accessories', 'Cases, chargers, gimbals for mobiles.');
insert into CATEGORIES (category_id, category_name, information)
values (8, 'Wearable Technology', 'Smart watches, fitness trackers.');
insert into CATEGORIES (category_id, category_name, information)
values (9, 'Cameras & Photography', 'Capture photos, videos with cameras.');
insert into CATEGORIES (category_id, category_name, information)
values (10, 'Lighting', 'Lights for home and office use.');
insert into CATEGORIES (category_id, category_name, information)
values (11, 'Data Storage', 'Store and manage data: hard drives.');
insert into CATEGORIES (category_id, category_name, information)
values (12, 'Health & Fitness', 'Fitness trackers, smart scales.');
insert into CATEGORIES (category_id, category_name, information)
values (13, 'Smart Home Devices', 'Thermostats, security cameras.');
insert into CATEGORIES (category_id, category_name, information)
values (14, 'Small Kitchen Appliances', 'Blenders, coffee makers.');
insert into CATEGORIES (category_id, category_name, information)
values (15, 'Home Cleaning', 'Robot vacuums, pressure washers.');
insert into CATEGORIES (category_id, category_name, information)
values (16, 'Personal Care', 'Toothbrushes, shavers for grooming.');
insert into CATEGORIES (category_id, category_name, information)
values (17, 'Medical Devices', 'Blood pressure devices for home.');
insert into CATEGORIES (category_id, category_name, information)
values (18, 'Exercise Equipment', 'Yoga mats, treadmills for fitness.');
insert into CATEGORIES (category_id, category_name, information)
values (19, 'Television & Home Theater', 'Smart TVs, projectors for entertainment.');
insert into CATEGORIES (category_id, category_name, information)
values (20, 'Streaming & Media', 'Media streaming with sticks.');
insert into CATEGORIES (category_id, category_name, information)
values (21, 'Outdoor & Garden', 'Garden tools, patio furniture.');
insert into CATEGORIES (category_id, category_name, information)
values (22, 'Tools & Hardware', 'Drills, saws, toolkits for home.');
insert into CATEGORIES (category_id, category_name, information)
values (23, 'Automotive Accessories', 'Car chargers, GPS, dash cams.');
insert into CATEGORIES (category_id, category_name, information)
values (24, 'Travel Accessories', 'Travel pillows, suitcases, bags.');
insert into CATEGORIES (category_id, category_name, information)
values (25, 'Fashion Accessories', 'Sunglasses, wallets for fashion.');
insert into CATEGORIES (category_id, category_name, information)
values (26, 'Luggage & Bags', 'Camera bags, handbags, luggage.');
insert into CATEGORIES (category_id, category_name, information)
values (27, 'Camera Accessories', 'Tripods, memory cards for photography.');
insert into CATEGORIES (category_id, category_name, information)
values (28, 'Virtual Reality', 'VR headsets for virtual experiences.');
insert into CATEGORIES (category_id, category_name, information)
values (29, 'Drones', 'Drones for photography, entertainment.');
insert into CATEGORIES (category_id, category_name, information)
values (30, '3D Printing', '3D printers for creating objects.');
commit;
prompt 30 records loaded
prompt Loading ORDERS...
insert into ORDERS (order_id, order_date, buyer_id)
values (61016, to_date('12-06-2023', 'dd-mm-yyyy'), 10362);
insert into ORDERS (order_id, order_date, buyer_id)
values (43394, to_date('16-05-2023', 'dd-mm-yyyy'), 10551);
insert into ORDERS (order_id, order_date, buyer_id)
values (96466, to_date('20-11-2023', 'dd-mm-yyyy'), 10606);
insert into ORDERS (order_id, order_date, buyer_id)
values (66142, to_date('12-06-2023', 'dd-mm-yyyy'), 10215);
insert into ORDERS (order_id, order_date, buyer_id)
values (74499, to_date('01-09-2023', 'dd-mm-yyyy'), 10568);
insert into ORDERS (order_id, order_date, buyer_id)
values (98032, to_date('21-10-2023', 'dd-mm-yyyy'), 10191);
insert into ORDERS (order_id, order_date, buyer_id)
values (89934, to_date('09-02-2023', 'dd-mm-yyyy'), 10292);
insert into ORDERS (order_id, order_date, buyer_id)
values (81849, to_date('26-05-2023', 'dd-mm-yyyy'), 10512);
insert into ORDERS (order_id, order_date, buyer_id)
values (92030, to_date('13-11-2023', 'dd-mm-yyyy'), 10654);
insert into ORDERS (order_id, order_date, buyer_id)
values (21754, to_date('19-02-2023', 'dd-mm-yyyy'), 10214);
insert into ORDERS (order_id, order_date, buyer_id)
values (83788, to_date('06-02-2023', 'dd-mm-yyyy'), 10186);
insert into ORDERS (order_id, order_date, buyer_id)
values (51465, to_date('24-05-2023', 'dd-mm-yyyy'), 10352);
insert into ORDERS (order_id, order_date, buyer_id)
values (68973, to_date('22-01-2023', 'dd-mm-yyyy'), 10463);
insert into ORDERS (order_id, order_date, buyer_id)
values (73861, to_date('13-08-2023', 'dd-mm-yyyy'), 10608);
insert into ORDERS (order_id, order_date, buyer_id)
values (95317, to_date('30-05-2023', 'dd-mm-yyyy'), 10284);
insert into ORDERS (order_id, order_date, buyer_id)
values (93085, to_date('14-10-2023', 'dd-mm-yyyy'), 10468);
insert into ORDERS (order_id, order_date, buyer_id)
values (69640, to_date('07-01-2023', 'dd-mm-yyyy'), 10483);
insert into ORDERS (order_id, order_date, buyer_id)
values (25208, to_date('29-01-2023', 'dd-mm-yyyy'), 10086);
insert into ORDERS (order_id, order_date, buyer_id)
values (96856, to_date('01-07-2023', 'dd-mm-yyyy'), 10550);
insert into ORDERS (order_id, order_date, buyer_id)
values (91096, to_date('03-05-2023', 'dd-mm-yyyy'), 10016);
insert into ORDERS (order_id, order_date, buyer_id)
values (13293, to_date('07-05-2023', 'dd-mm-yyyy'), 10306);
insert into ORDERS (order_id, order_date, buyer_id)
values (15928, to_date('20-05-2023', 'dd-mm-yyyy'), 10544);
insert into ORDERS (order_id, order_date, buyer_id)
values (33675, to_date('18-06-2023', 'dd-mm-yyyy'), 10636);
insert into ORDERS (order_id, order_date, buyer_id)
values (59457, to_date('01-01-2024', 'dd-mm-yyyy'), 10096);
insert into ORDERS (order_id, order_date, buyer_id)
values (33450, to_date('03-07-2023', 'dd-mm-yyyy'), 10326);
insert into ORDERS (order_id, order_date, buyer_id)
values (80092, to_date('21-11-2023', 'dd-mm-yyyy'), 10128);
insert into ORDERS (order_id, order_date, buyer_id)
values (72238, to_date('30-03-2023', 'dd-mm-yyyy'), 10291);
insert into ORDERS (order_id, order_date, buyer_id)
values (50150, to_date('06-03-2023', 'dd-mm-yyyy'), 10042);
insert into ORDERS (order_id, order_date, buyer_id)
values (52936, to_date('28-05-2023', 'dd-mm-yyyy'), 10049);
insert into ORDERS (order_id, order_date, buyer_id)
values (99376, to_date('26-08-2023', 'dd-mm-yyyy'), 10411);
insert into ORDERS (order_id, order_date, buyer_id)
values (22714, to_date('20-11-2023', 'dd-mm-yyyy'), 10209);
insert into ORDERS (order_id, order_date, buyer_id)
values (75064, to_date('04-07-2023', 'dd-mm-yyyy'), 10522);
insert into ORDERS (order_id, order_date, buyer_id)
values (49848, to_date('22-11-2023', 'dd-mm-yyyy'), 10548);
insert into ORDERS (order_id, order_date, buyer_id)
values (80252, to_date('29-08-2023', 'dd-mm-yyyy'), 10178);
insert into ORDERS (order_id, order_date, buyer_id)
values (52177, to_date('18-11-2023', 'dd-mm-yyyy'), 10442);
insert into ORDERS (order_id, order_date, buyer_id)
values (82123, to_date('17-09-2023', 'dd-mm-yyyy'), 10377);
insert into ORDERS (order_id, order_date, buyer_id)
values (82081, to_date('26-02-2023', 'dd-mm-yyyy'), 10567);
insert into ORDERS (order_id, order_date, buyer_id)
values (41740, to_date('18-07-2023', 'dd-mm-yyyy'), 10285);
insert into ORDERS (order_id, order_date, buyer_id)
values (57379, to_date('03-12-2023', 'dd-mm-yyyy'), 10680);
insert into ORDERS (order_id, order_date, buyer_id)
values (48913, to_date('22-06-2023', 'dd-mm-yyyy'), 10221);
insert into ORDERS (order_id, order_date, buyer_id)
values (60575, to_date('11-01-2023', 'dd-mm-yyyy'), 10467);
insert into ORDERS (order_id, order_date, buyer_id)
values (83238, to_date('08-04-2023', 'dd-mm-yyyy'), 10140);
insert into ORDERS (order_id, order_date, buyer_id)
values (38510, to_date('02-12-2023', 'dd-mm-yyyy'), 10563);
insert into ORDERS (order_id, order_date, buyer_id)
values (99606, to_date('26-12-2023', 'dd-mm-yyyy'), 10061);
insert into ORDERS (order_id, order_date, buyer_id)
values (93943, to_date('04-08-2023', 'dd-mm-yyyy'), 10379);
insert into ORDERS (order_id, order_date, buyer_id)
values (54473, to_date('25-02-2023', 'dd-mm-yyyy'), 10114);
insert into ORDERS (order_id, order_date, buyer_id)
values (57852, to_date('09-09-2023', 'dd-mm-yyyy'), 10477);
insert into ORDERS (order_id, order_date, buyer_id)
values (33453, to_date('16-05-2023', 'dd-mm-yyyy'), 10099);
insert into ORDERS (order_id, order_date, buyer_id)
values (89624, to_date('08-01-2023', 'dd-mm-yyyy'), 10080);
insert into ORDERS (order_id, order_date, buyer_id)
values (72115, to_date('21-08-2023', 'dd-mm-yyyy'), 10576);
insert into ORDERS (order_id, order_date, buyer_id)
values (99728, to_date('29-12-2023', 'dd-mm-yyyy'), 10664);
insert into ORDERS (order_id, order_date, buyer_id)
values (15633, to_date('18-05-2023', 'dd-mm-yyyy'), 10059);
insert into ORDERS (order_id, order_date, buyer_id)
values (19233, to_date('10-07-2023', 'dd-mm-yyyy'), 10637);
insert into ORDERS (order_id, order_date, buyer_id)
values (90056, to_date('14-08-2023', 'dd-mm-yyyy'), 10329);
insert into ORDERS (order_id, order_date, buyer_id)
values (80659, to_date('24-09-2023', 'dd-mm-yyyy'), 10128);
insert into ORDERS (order_id, order_date, buyer_id)
values (63737, to_date('03-02-2023', 'dd-mm-yyyy'), 10215);
insert into ORDERS (order_id, order_date, buyer_id)
values (28254, to_date('18-09-2023', 'dd-mm-yyyy'), 10264);
insert into ORDERS (order_id, order_date, buyer_id)
values (82910, to_date('09-09-2023', 'dd-mm-yyyy'), 10179);
insert into ORDERS (order_id, order_date, buyer_id)
values (11137, to_date('03-05-2023', 'dd-mm-yyyy'), 10534);
insert into ORDERS (order_id, order_date, buyer_id)
values (35660, to_date('27-06-2023', 'dd-mm-yyyy'), 10532);
insert into ORDERS (order_id, order_date, buyer_id)
values (42735, to_date('19-04-2023', 'dd-mm-yyyy'), 10187);
insert into ORDERS (order_id, order_date, buyer_id)
values (84762, to_date('02-01-2023', 'dd-mm-yyyy'), 10050);
insert into ORDERS (order_id, order_date, buyer_id)
values (62909, to_date('13-02-2023', 'dd-mm-yyyy'), 10125);
insert into ORDERS (order_id, order_date, buyer_id)
values (47206, to_date('08-02-2023', 'dd-mm-yyyy'), 10051);
insert into ORDERS (order_id, order_date, buyer_id)
values (78140, to_date('08-02-2023', 'dd-mm-yyyy'), 10039);
insert into ORDERS (order_id, order_date, buyer_id)
values (67677, to_date('22-11-2023', 'dd-mm-yyyy'), 10655);
insert into ORDERS (order_id, order_date, buyer_id)
values (48180, to_date('23-03-2023', 'dd-mm-yyyy'), 10697);
insert into ORDERS (order_id, order_date, buyer_id)
values (10154, to_date('31-05-2023', 'dd-mm-yyyy'), 10255);
insert into ORDERS (order_id, order_date, buyer_id)
values (48016, to_date('21-09-2023', 'dd-mm-yyyy'), 10290);
insert into ORDERS (order_id, order_date, buyer_id)
values (27033, to_date('03-04-2023', 'dd-mm-yyyy'), 10574);
insert into ORDERS (order_id, order_date, buyer_id)
values (89662, to_date('05-02-2023', 'dd-mm-yyyy'), 10420);
insert into ORDERS (order_id, order_date, buyer_id)
values (64100, to_date('11-07-2023', 'dd-mm-yyyy'), 10228);
insert into ORDERS (order_id, order_date, buyer_id)
values (52636, to_date('04-10-2023', 'dd-mm-yyyy'), 10009);
insert into ORDERS (order_id, order_date, buyer_id)
values (33184, to_date('29-01-2023', 'dd-mm-yyyy'), 10086);
insert into ORDERS (order_id, order_date, buyer_id)
values (52842, to_date('27-01-2023', 'dd-mm-yyyy'), 10084);
insert into ORDERS (order_id, order_date, buyer_id)
values (97823, to_date('19-09-2023', 'dd-mm-yyyy'), 10274);
insert into ORDERS (order_id, order_date, buyer_id)
values (80258, to_date('15-07-2023', 'dd-mm-yyyy'), 10119);
insert into ORDERS (order_id, order_date, buyer_id)
values (31485, to_date('03-07-2023', 'dd-mm-yyyy'), 10173);
insert into ORDERS (order_id, order_date, buyer_id)
values (14409, to_date('15-09-2023', 'dd-mm-yyyy'), 10122);
insert into ORDERS (order_id, order_date, buyer_id)
values (88491, to_date('10-05-2023', 'dd-mm-yyyy'), 10061);
insert into ORDERS (order_id, order_date, buyer_id)
values (56177, to_date('05-12-2023', 'dd-mm-yyyy'), 10063);
insert into ORDERS (order_id, order_date, buyer_id)
values (95236, to_date('31-07-2023', 'dd-mm-yyyy'), 10691);
insert into ORDERS (order_id, order_date, buyer_id)
values (13213, to_date('07-10-2023', 'dd-mm-yyyy'), 10220);
insert into ORDERS (order_id, order_date, buyer_id)
values (39457, to_date('07-01-2023', 'dd-mm-yyyy'), 10613);
insert into ORDERS (order_id, order_date, buyer_id)
values (27213, to_date('12-05-2023', 'dd-mm-yyyy'), 10524);
insert into ORDERS (order_id, order_date, buyer_id)
values (58533, to_date('24-09-2023', 'dd-mm-yyyy'), 10470);
insert into ORDERS (order_id, order_date, buyer_id)
values (52694, to_date('31-07-2023', 'dd-mm-yyyy'), 10229);
insert into ORDERS (order_id, order_date, buyer_id)
values (29946, to_date('06-01-2023', 'dd-mm-yyyy'), 10059);
insert into ORDERS (order_id, order_date, buyer_id)
values (21793, to_date('26-12-2023', 'dd-mm-yyyy'), 10449);
insert into ORDERS (order_id, order_date, buyer_id)
values (88610, to_date('20-10-2023', 'dd-mm-yyyy'), 10185);
insert into ORDERS (order_id, order_date, buyer_id)
values (86161, to_date('28-07-2023', 'dd-mm-yyyy'), 10537);
insert into ORDERS (order_id, order_date, buyer_id)
values (12407, to_date('08-07-2023', 'dd-mm-yyyy'), 10517);
insert into ORDERS (order_id, order_date, buyer_id)
values (48289, to_date('28-10-2023', 'dd-mm-yyyy'), 10666);
insert into ORDERS (order_id, order_date, buyer_id)
values (89648, to_date('30-01-2023', 'dd-mm-yyyy'), 10622);
insert into ORDERS (order_id, order_date, buyer_id)
values (98846, to_date('08-08-2023', 'dd-mm-yyyy'), 10265);
insert into ORDERS (order_id, order_date, buyer_id)
values (95813, to_date('11-01-2023', 'dd-mm-yyyy'), 10269);
insert into ORDERS (order_id, order_date, buyer_id)
values (86757, to_date('13-09-2023', 'dd-mm-yyyy'), 10616);
insert into ORDERS (order_id, order_date, buyer_id)
values (82628, to_date('25-02-2023', 'dd-mm-yyyy'), 10323);
insert into ORDERS (order_id, order_date, buyer_id)
values (63130, to_date('03-01-2023', 'dd-mm-yyyy'), 10198);
insert into ORDERS (order_id, order_date, buyer_id)
values (95682, to_date('28-03-2023', 'dd-mm-yyyy'), 10150);
commit;
prompt 100 records committed...
insert into ORDERS (order_id, order_date, buyer_id)
values (41750, to_date('08-10-2023', 'dd-mm-yyyy'), 10114);
insert into ORDERS (order_id, order_date, buyer_id)
values (38234, to_date('06-05-2023', 'dd-mm-yyyy'), 10287);
insert into ORDERS (order_id, order_date, buyer_id)
values (15844, to_date('11-01-2023', 'dd-mm-yyyy'), 10050);
insert into ORDERS (order_id, order_date, buyer_id)
values (34123, to_date('24-10-2023', 'dd-mm-yyyy'), 10068);
insert into ORDERS (order_id, order_date, buyer_id)
values (96349, to_date('08-08-2023', 'dd-mm-yyyy'), 10025);
insert into ORDERS (order_id, order_date, buyer_id)
values (92343, to_date('28-01-2023', 'dd-mm-yyyy'), 10449);
insert into ORDERS (order_id, order_date, buyer_id)
values (79070, to_date('08-01-2023', 'dd-mm-yyyy'), 10148);
insert into ORDERS (order_id, order_date, buyer_id)
values (55663, to_date('12-06-2023', 'dd-mm-yyyy'), 10223);
insert into ORDERS (order_id, order_date, buyer_id)
values (40058, to_date('22-01-2023', 'dd-mm-yyyy'), 10118);
insert into ORDERS (order_id, order_date, buyer_id)
values (26135, to_date('17-11-2023', 'dd-mm-yyyy'), 10191);
insert into ORDERS (order_id, order_date, buyer_id)
values (88310, to_date('25-02-2023', 'dd-mm-yyyy'), 10273);
insert into ORDERS (order_id, order_date, buyer_id)
values (47139, to_date('30-08-2023', 'dd-mm-yyyy'), 10088);
insert into ORDERS (order_id, order_date, buyer_id)
values (35757, to_date('22-02-2023', 'dd-mm-yyyy'), 10229);
insert into ORDERS (order_id, order_date, buyer_id)
values (65358, to_date('01-02-2023', 'dd-mm-yyyy'), 10527);
insert into ORDERS (order_id, order_date, buyer_id)
values (44484, to_date('24-09-2023', 'dd-mm-yyyy'), 10478);
insert into ORDERS (order_id, order_date, buyer_id)
values (82463, to_date('22-12-2023', 'dd-mm-yyyy'), 10277);
insert into ORDERS (order_id, order_date, buyer_id)
values (93321, to_date('01-01-2024', 'dd-mm-yyyy'), 10548);
insert into ORDERS (order_id, order_date, buyer_id)
values (35763, to_date('26-05-2023', 'dd-mm-yyyy'), 10285);
insert into ORDERS (order_id, order_date, buyer_id)
values (18611, to_date('19-04-2023', 'dd-mm-yyyy'), 10498);
insert into ORDERS (order_id, order_date, buyer_id)
values (45503, to_date('15-12-2023', 'dd-mm-yyyy'), 10000);
insert into ORDERS (order_id, order_date, buyer_id)
values (40095, to_date('28-11-2023', 'dd-mm-yyyy'), 10518);
insert into ORDERS (order_id, order_date, buyer_id)
values (54267, to_date('09-09-2023', 'dd-mm-yyyy'), 10374);
insert into ORDERS (order_id, order_date, buyer_id)
values (50609, to_date('29-01-2023', 'dd-mm-yyyy'), 10106);
insert into ORDERS (order_id, order_date, buyer_id)
values (46891, to_date('10-05-2023', 'dd-mm-yyyy'), 10503);
insert into ORDERS (order_id, order_date, buyer_id)
values (90878, to_date('14-10-2023', 'dd-mm-yyyy'), 10200);
insert into ORDERS (order_id, order_date, buyer_id)
values (17847, to_date('21-12-2023', 'dd-mm-yyyy'), 10398);
insert into ORDERS (order_id, order_date, buyer_id)
values (66111, to_date('30-11-2023', 'dd-mm-yyyy'), 10179);
insert into ORDERS (order_id, order_date, buyer_id)
values (33027, to_date('21-01-2023', 'dd-mm-yyyy'), 10524);
insert into ORDERS (order_id, order_date, buyer_id)
values (72546, to_date('20-10-2023', 'dd-mm-yyyy'), 10442);
insert into ORDERS (order_id, order_date, buyer_id)
values (34720, to_date('25-02-2023', 'dd-mm-yyyy'), 10682);
insert into ORDERS (order_id, order_date, buyer_id)
values (37709, to_date('11-06-2023', 'dd-mm-yyyy'), 10185);
insert into ORDERS (order_id, order_date, buyer_id)
values (68055, to_date('04-03-2023', 'dd-mm-yyyy'), 10111);
insert into ORDERS (order_id, order_date, buyer_id)
values (61009, to_date('25-04-2023', 'dd-mm-yyyy'), 10474);
insert into ORDERS (order_id, order_date, buyer_id)
values (94821, to_date('02-01-2023', 'dd-mm-yyyy'), 10584);
insert into ORDERS (order_id, order_date, buyer_id)
values (99524, to_date('13-12-2023', 'dd-mm-yyyy'), 10599);
insert into ORDERS (order_id, order_date, buyer_id)
values (92106, to_date('11-06-2023', 'dd-mm-yyyy'), 10600);
insert into ORDERS (order_id, order_date, buyer_id)
values (80629, to_date('08-10-2023', 'dd-mm-yyyy'), 10091);
insert into ORDERS (order_id, order_date, buyer_id)
values (89119, to_date('08-10-2023', 'dd-mm-yyyy'), 10240);
insert into ORDERS (order_id, order_date, buyer_id)
values (76509, to_date('18-01-2023', 'dd-mm-yyyy'), 10019);
insert into ORDERS (order_id, order_date, buyer_id)
values (51579, to_date('01-01-2023', 'dd-mm-yyyy'), 10637);
insert into ORDERS (order_id, order_date, buyer_id)
values (48764, to_date('01-02-2023', 'dd-mm-yyyy'), 10518);
insert into ORDERS (order_id, order_date, buyer_id)
values (49816, to_date('26-10-2023', 'dd-mm-yyyy'), 10456);
insert into ORDERS (order_id, order_date, buyer_id)
values (72406, to_date('30-03-2023', 'dd-mm-yyyy'), 10026);
insert into ORDERS (order_id, order_date, buyer_id)
values (59746, to_date('31-08-2023', 'dd-mm-yyyy'), 10191);
insert into ORDERS (order_id, order_date, buyer_id)
values (90601, to_date('12-07-2023', 'dd-mm-yyyy'), 10253);
insert into ORDERS (order_id, order_date, buyer_id)
values (55927, to_date('14-01-2023', 'dd-mm-yyyy'), 10540);
insert into ORDERS (order_id, order_date, buyer_id)
values (92740, to_date('05-10-2023', 'dd-mm-yyyy'), 10211);
insert into ORDERS (order_id, order_date, buyer_id)
values (88457, to_date('10-05-2023', 'dd-mm-yyyy'), 10199);
insert into ORDERS (order_id, order_date, buyer_id)
values (21920, to_date('30-06-2023', 'dd-mm-yyyy'), 10643);
insert into ORDERS (order_id, order_date, buyer_id)
values (81302, to_date('03-01-2023', 'dd-mm-yyyy'), 10329);
insert into ORDERS (order_id, order_date, buyer_id)
values (31770, to_date('18-01-2023', 'dd-mm-yyyy'), 10286);
insert into ORDERS (order_id, order_date, buyer_id)
values (64231, to_date('02-10-2023', 'dd-mm-yyyy'), 10335);
insert into ORDERS (order_id, order_date, buyer_id)
values (59967, to_date('11-07-2023', 'dd-mm-yyyy'), 10336);
insert into ORDERS (order_id, order_date, buyer_id)
values (84615, to_date('11-09-2023', 'dd-mm-yyyy'), 10286);
insert into ORDERS (order_id, order_date, buyer_id)
values (24815, to_date('05-06-2023', 'dd-mm-yyyy'), 10415);
insert into ORDERS (order_id, order_date, buyer_id)
values (94519, to_date('30-07-2023', 'dd-mm-yyyy'), 10393);
insert into ORDERS (order_id, order_date, buyer_id)
values (33333, to_date('06-11-2023', 'dd-mm-yyyy'), 10638);
insert into ORDERS (order_id, order_date, buyer_id)
values (19822, to_date('11-11-2023', 'dd-mm-yyyy'), 10258);
insert into ORDERS (order_id, order_date, buyer_id)
values (32402, to_date('28-10-2023', 'dd-mm-yyyy'), 10436);
insert into ORDERS (order_id, order_date, buyer_id)
values (28135, to_date('25-09-2023', 'dd-mm-yyyy'), 10358);
insert into ORDERS (order_id, order_date, buyer_id)
values (26227, to_date('19-10-2023', 'dd-mm-yyyy'), 10093);
insert into ORDERS (order_id, order_date, buyer_id)
values (54635, to_date('03-01-2023', 'dd-mm-yyyy'), 10116);
insert into ORDERS (order_id, order_date, buyer_id)
values (40534, to_date('22-01-2023', 'dd-mm-yyyy'), 10635);
insert into ORDERS (order_id, order_date, buyer_id)
values (31799, to_date('31-07-2023', 'dd-mm-yyyy'), 10455);
insert into ORDERS (order_id, order_date, buyer_id)
values (71428, to_date('23-01-2023', 'dd-mm-yyyy'), 10364);
insert into ORDERS (order_id, order_date, buyer_id)
values (48824, to_date('13-11-2023', 'dd-mm-yyyy'), 10089);
insert into ORDERS (order_id, order_date, buyer_id)
values (57575, to_date('04-09-2023', 'dd-mm-yyyy'), 10508);
insert into ORDERS (order_id, order_date, buyer_id)
values (25176, to_date('12-09-2023', 'dd-mm-yyyy'), 10013);
insert into ORDERS (order_id, order_date, buyer_id)
values (89573, to_date('09-09-2023', 'dd-mm-yyyy'), 10577);
insert into ORDERS (order_id, order_date, buyer_id)
values (11510, to_date('04-12-2023', 'dd-mm-yyyy'), 10329);
insert into ORDERS (order_id, order_date, buyer_id)
values (52932, to_date('02-10-2023', 'dd-mm-yyyy'), 10245);
insert into ORDERS (order_id, order_date, buyer_id)
values (65079, to_date('12-09-2023', 'dd-mm-yyyy'), 10462);
insert into ORDERS (order_id, order_date, buyer_id)
values (14075, to_date('22-12-2023', 'dd-mm-yyyy'), 10047);
insert into ORDERS (order_id, order_date, buyer_id)
values (59083, to_date('04-05-2023', 'dd-mm-yyyy'), 10019);
insert into ORDERS (order_id, order_date, buyer_id)
values (98067, to_date('12-05-2023', 'dd-mm-yyyy'), 10652);
insert into ORDERS (order_id, order_date, buyer_id)
values (98726, to_date('26-07-2023', 'dd-mm-yyyy'), 10394);
insert into ORDERS (order_id, order_date, buyer_id)
values (63041, to_date('20-06-2023', 'dd-mm-yyyy'), 10145);
insert into ORDERS (order_id, order_date, buyer_id)
values (19210, to_date('19-09-2023', 'dd-mm-yyyy'), 10613);
insert into ORDERS (order_id, order_date, buyer_id)
values (25149, to_date('25-09-2023', 'dd-mm-yyyy'), 10577);
insert into ORDERS (order_id, order_date, buyer_id)
values (85661, to_date('29-11-2023', 'dd-mm-yyyy'), 10100);
insert into ORDERS (order_id, order_date, buyer_id)
values (19863, to_date('03-12-2023', 'dd-mm-yyyy'), 10295);
insert into ORDERS (order_id, order_date, buyer_id)
values (40064, to_date('24-10-2023', 'dd-mm-yyyy'), 10135);
insert into ORDERS (order_id, order_date, buyer_id)
values (86362, to_date('11-08-2023', 'dd-mm-yyyy'), 10584);
insert into ORDERS (order_id, order_date, buyer_id)
values (98999, to_date('27-02-2023', 'dd-mm-yyyy'), 10698);
insert into ORDERS (order_id, order_date, buyer_id)
values (72042, to_date('21-11-2023', 'dd-mm-yyyy'), 10172);
insert into ORDERS (order_id, order_date, buyer_id)
values (46144, to_date('26-11-2023', 'dd-mm-yyyy'), 10503);
insert into ORDERS (order_id, order_date, buyer_id)
values (89602, to_date('04-07-2023', 'dd-mm-yyyy'), 10190);
insert into ORDERS (order_id, order_date, buyer_id)
values (58690, to_date('14-10-2023', 'dd-mm-yyyy'), 10304);
insert into ORDERS (order_id, order_date, buyer_id)
values (20230, to_date('26-04-2023', 'dd-mm-yyyy'), 10686);
insert into ORDERS (order_id, order_date, buyer_id)
values (44630, to_date('28-05-2023', 'dd-mm-yyyy'), 10339);
insert into ORDERS (order_id, order_date, buyer_id)
values (88895, to_date('09-06-2023', 'dd-mm-yyyy'), 10601);
insert into ORDERS (order_id, order_date, buyer_id)
values (31934, to_date('06-03-2023', 'dd-mm-yyyy'), 10386);
insert into ORDERS (order_id, order_date, buyer_id)
values (82075, to_date('22-05-2023', 'dd-mm-yyyy'), 10077);
insert into ORDERS (order_id, order_date, buyer_id)
values (68656, to_date('04-06-2023', 'dd-mm-yyyy'), 10468);
insert into ORDERS (order_id, order_date, buyer_id)
values (60282, to_date('06-04-2023', 'dd-mm-yyyy'), 10568);
insert into ORDERS (order_id, order_date, buyer_id)
values (78409, to_date('27-12-2023', 'dd-mm-yyyy'), 10601);
insert into ORDERS (order_id, order_date, buyer_id)
values (57847, to_date('08-06-2023', 'dd-mm-yyyy'), 10463);
insert into ORDERS (order_id, order_date, buyer_id)
values (96404, to_date('30-07-2023', 'dd-mm-yyyy'), 10534);
insert into ORDERS (order_id, order_date, buyer_id)
values (66464, to_date('10-07-2023', 'dd-mm-yyyy'), 10499);
insert into ORDERS (order_id, order_date, buyer_id)
values (80471, to_date('24-10-2023', 'dd-mm-yyyy'), 10524);
commit;
prompt 200 records committed...
insert into ORDERS (order_id, order_date, buyer_id)
values (37421, to_date('29-11-2023', 'dd-mm-yyyy'), 10492);
insert into ORDERS (order_id, order_date, buyer_id)
values (37453, to_date('13-04-2023', 'dd-mm-yyyy'), 10277);
insert into ORDERS (order_id, order_date, buyer_id)
values (95988, to_date('27-01-2023', 'dd-mm-yyyy'), 10673);
insert into ORDERS (order_id, order_date, buyer_id)
values (20985, to_date('11-01-2023', 'dd-mm-yyyy'), 10201);
insert into ORDERS (order_id, order_date, buyer_id)
values (90620, to_date('26-10-2023', 'dd-mm-yyyy'), 10325);
insert into ORDERS (order_id, order_date, buyer_id)
values (80255, to_date('18-09-2023', 'dd-mm-yyyy'), 10333);
insert into ORDERS (order_id, order_date, buyer_id)
values (45259, to_date('30-07-2023', 'dd-mm-yyyy'), 10628);
insert into ORDERS (order_id, order_date, buyer_id)
values (23934, to_date('23-08-2023', 'dd-mm-yyyy'), 10087);
insert into ORDERS (order_id, order_date, buyer_id)
values (95456, to_date('07-05-2023', 'dd-mm-yyyy'), 10520);
insert into ORDERS (order_id, order_date, buyer_id)
values (97162, to_date('12-03-2023', 'dd-mm-yyyy'), 10392);
insert into ORDERS (order_id, order_date, buyer_id)
values (64158, to_date('29-01-2023', 'dd-mm-yyyy'), 10654);
insert into ORDERS (order_id, order_date, buyer_id)
values (35470, to_date('18-07-2023', 'dd-mm-yyyy'), 10362);
insert into ORDERS (order_id, order_date, buyer_id)
values (71316, to_date('02-01-2023', 'dd-mm-yyyy'), 10409);
insert into ORDERS (order_id, order_date, buyer_id)
values (65915, to_date('13-01-2023', 'dd-mm-yyyy'), 10380);
insert into ORDERS (order_id, order_date, buyer_id)
values (68531, to_date('11-07-2023', 'dd-mm-yyyy'), 10189);
insert into ORDERS (order_id, order_date, buyer_id)
values (35559, to_date('18-01-2023', 'dd-mm-yyyy'), 10528);
insert into ORDERS (order_id, order_date, buyer_id)
values (56593, to_date('08-10-2023', 'dd-mm-yyyy'), 10292);
insert into ORDERS (order_id, order_date, buyer_id)
values (68992, to_date('26-02-2023', 'dd-mm-yyyy'), 10079);
insert into ORDERS (order_id, order_date, buyer_id)
values (35359, to_date('19-05-2023', 'dd-mm-yyyy'), 10696);
insert into ORDERS (order_id, order_date, buyer_id)
values (72881, to_date('06-03-2023', 'dd-mm-yyyy'), 10324);
insert into ORDERS (order_id, order_date, buyer_id)
values (32823, to_date('07-11-2023', 'dd-mm-yyyy'), 10071);
insert into ORDERS (order_id, order_date, buyer_id)
values (74716, to_date('28-12-2023', 'dd-mm-yyyy'), 10396);
insert into ORDERS (order_id, order_date, buyer_id)
values (18868, to_date('04-12-2023', 'dd-mm-yyyy'), 10485);
insert into ORDERS (order_id, order_date, buyer_id)
values (68135, to_date('26-04-2023', 'dd-mm-yyyy'), 10425);
insert into ORDERS (order_id, order_date, buyer_id)
values (59849, to_date('20-08-2023', 'dd-mm-yyyy'), 10419);
insert into ORDERS (order_id, order_date, buyer_id)
values (86548, to_date('26-04-2023', 'dd-mm-yyyy'), 10634);
insert into ORDERS (order_id, order_date, buyer_id)
values (18370, to_date('02-05-2023', 'dd-mm-yyyy'), 10604);
insert into ORDERS (order_id, order_date, buyer_id)
values (73409, to_date('25-06-2023', 'dd-mm-yyyy'), 10109);
insert into ORDERS (order_id, order_date, buyer_id)
values (89027, to_date('22-09-2023', 'dd-mm-yyyy'), 10149);
insert into ORDERS (order_id, order_date, buyer_id)
values (99452, to_date('31-03-2023', 'dd-mm-yyyy'), 10241);
insert into ORDERS (order_id, order_date, buyer_id)
values (31112, to_date('26-01-2023', 'dd-mm-yyyy'), 10502);
insert into ORDERS (order_id, order_date, buyer_id)
values (77774, to_date('12-02-2023', 'dd-mm-yyyy'), 10490);
insert into ORDERS (order_id, order_date, buyer_id)
values (24038, to_date('24-01-2023', 'dd-mm-yyyy'), 10427);
insert into ORDERS (order_id, order_date, buyer_id)
values (44750, to_date('16-08-2023', 'dd-mm-yyyy'), 10428);
insert into ORDERS (order_id, order_date, buyer_id)
values (15916, to_date('13-05-2023', 'dd-mm-yyyy'), 10146);
insert into ORDERS (order_id, order_date, buyer_id)
values (91749, to_date('24-06-2023', 'dd-mm-yyyy'), 10389);
insert into ORDERS (order_id, order_date, buyer_id)
values (81310, to_date('23-03-2023', 'dd-mm-yyyy'), 10037);
insert into ORDERS (order_id, order_date, buyer_id)
values (17369, to_date('24-02-2023', 'dd-mm-yyyy'), 10492);
insert into ORDERS (order_id, order_date, buyer_id)
values (55893, to_date('21-02-2023', 'dd-mm-yyyy'), 10247);
insert into ORDERS (order_id, order_date, buyer_id)
values (95807, to_date('27-12-2023', 'dd-mm-yyyy'), 10047);
insert into ORDERS (order_id, order_date, buyer_id)
values (84586, to_date('24-05-2023', 'dd-mm-yyyy'), 10404);
insert into ORDERS (order_id, order_date, buyer_id)
values (21885, to_date('19-10-2023', 'dd-mm-yyyy'), 10675);
insert into ORDERS (order_id, order_date, buyer_id)
values (41007, to_date('04-09-2023', 'dd-mm-yyyy'), 10126);
insert into ORDERS (order_id, order_date, buyer_id)
values (90560, to_date('01-01-2023', 'dd-mm-yyyy'), 10130);
insert into ORDERS (order_id, order_date, buyer_id)
values (40685, to_date('27-09-2023', 'dd-mm-yyyy'), 10036);
insert into ORDERS (order_id, order_date, buyer_id)
values (26277, to_date('04-03-2023', 'dd-mm-yyyy'), 10450);
insert into ORDERS (order_id, order_date, buyer_id)
values (13783, to_date('09-11-2023', 'dd-mm-yyyy'), 10619);
insert into ORDERS (order_id, order_date, buyer_id)
values (58801, to_date('03-01-2023', 'dd-mm-yyyy'), 10382);
insert into ORDERS (order_id, order_date, buyer_id)
values (45969, to_date('30-11-2023', 'dd-mm-yyyy'), 10221);
insert into ORDERS (order_id, order_date, buyer_id)
values (54785, to_date('09-01-2023', 'dd-mm-yyyy'), 10217);
insert into ORDERS (order_id, order_date, buyer_id)
values (93917, to_date('22-02-2023', 'dd-mm-yyyy'), 10009);
insert into ORDERS (order_id, order_date, buyer_id)
values (32041, to_date('10-06-2023', 'dd-mm-yyyy'), 10397);
insert into ORDERS (order_id, order_date, buyer_id)
values (25552, to_date('19-02-2023', 'dd-mm-yyyy'), 10610);
insert into ORDERS (order_id, order_date, buyer_id)
values (73791, to_date('26-12-2023', 'dd-mm-yyyy'), 10551);
insert into ORDERS (order_id, order_date, buyer_id)
values (90093, to_date('02-09-2023', 'dd-mm-yyyy'), 10531);
insert into ORDERS (order_id, order_date, buyer_id)
values (26706, to_date('09-03-2023', 'dd-mm-yyyy'), 10258);
insert into ORDERS (order_id, order_date, buyer_id)
values (99789, to_date('21-01-2023', 'dd-mm-yyyy'), 10561);
insert into ORDERS (order_id, order_date, buyer_id)
values (77123, to_date('25-09-2023', 'dd-mm-yyyy'), 10323);
insert into ORDERS (order_id, order_date, buyer_id)
values (99776, to_date('16-06-2023', 'dd-mm-yyyy'), 10487);
insert into ORDERS (order_id, order_date, buyer_id)
values (87648, to_date('19-12-2023', 'dd-mm-yyyy'), 10329);
insert into ORDERS (order_id, order_date, buyer_id)
values (55070, to_date('24-01-2023', 'dd-mm-yyyy'), 10631);
insert into ORDERS (order_id, order_date, buyer_id)
values (79688, to_date('08-10-2023', 'dd-mm-yyyy'), 10106);
insert into ORDERS (order_id, order_date, buyer_id)
values (90269, to_date('05-11-2023', 'dd-mm-yyyy'), 10371);
insert into ORDERS (order_id, order_date, buyer_id)
values (69126, to_date('26-01-2023', 'dd-mm-yyyy'), 10406);
insert into ORDERS (order_id, order_date, buyer_id)
values (18452, to_date('29-01-2023', 'dd-mm-yyyy'), 10136);
insert into ORDERS (order_id, order_date, buyer_id)
values (20842, to_date('16-05-2023', 'dd-mm-yyyy'), 10616);
insert into ORDERS (order_id, order_date, buyer_id)
values (76799, to_date('18-10-2023', 'dd-mm-yyyy'), 10488);
insert into ORDERS (order_id, order_date, buyer_id)
values (65916, to_date('28-12-2023', 'dd-mm-yyyy'), 10684);
insert into ORDERS (order_id, order_date, buyer_id)
values (48163, to_date('06-10-2023', 'dd-mm-yyyy'), 10218);
insert into ORDERS (order_id, order_date, buyer_id)
values (51403, to_date('06-03-2023', 'dd-mm-yyyy'), 10160);
insert into ORDERS (order_id, order_date, buyer_id)
values (15938, to_date('27-02-2023', 'dd-mm-yyyy'), 10613);
insert into ORDERS (order_id, order_date, buyer_id)
values (89705, to_date('11-07-2023', 'dd-mm-yyyy'), 10171);
insert into ORDERS (order_id, order_date, buyer_id)
values (64498, to_date('18-02-2023', 'dd-mm-yyyy'), 10297);
insert into ORDERS (order_id, order_date, buyer_id)
values (80709, to_date('01-11-2023', 'dd-mm-yyyy'), 10106);
insert into ORDERS (order_id, order_date, buyer_id)
values (85127, to_date('03-01-2023', 'dd-mm-yyyy'), 10533);
insert into ORDERS (order_id, order_date, buyer_id)
values (38419, to_date('13-04-2023', 'dd-mm-yyyy'), 10258);
insert into ORDERS (order_id, order_date, buyer_id)
values (38154, to_date('23-05-2023', 'dd-mm-yyyy'), 10473);
insert into ORDERS (order_id, order_date, buyer_id)
values (92638, to_date('20-05-2023', 'dd-mm-yyyy'), 10263);
insert into ORDERS (order_id, order_date, buyer_id)
values (61568, to_date('31-12-2023', 'dd-mm-yyyy'), 10462);
insert into ORDERS (order_id, order_date, buyer_id)
values (38656, to_date('09-10-2023', 'dd-mm-yyyy'), 10343);
insert into ORDERS (order_id, order_date, buyer_id)
values (15530, to_date('19-02-2023', 'dd-mm-yyyy'), 10241);
insert into ORDERS (order_id, order_date, buyer_id)
values (61982, to_date('26-10-2023', 'dd-mm-yyyy'), 10559);
insert into ORDERS (order_id, order_date, buyer_id)
values (46306, to_date('11-05-2023', 'dd-mm-yyyy'), 10527);
insert into ORDERS (order_id, order_date, buyer_id)
values (93859, to_date('19-11-2023', 'dd-mm-yyyy'), 10559);
insert into ORDERS (order_id, order_date, buyer_id)
values (33012, to_date('15-06-2023', 'dd-mm-yyyy'), 10104);
insert into ORDERS (order_id, order_date, buyer_id)
values (35098, to_date('26-11-2023', 'dd-mm-yyyy'), 10363);
insert into ORDERS (order_id, order_date, buyer_id)
values (31743, to_date('25-02-2023', 'dd-mm-yyyy'), 10052);
insert into ORDERS (order_id, order_date, buyer_id)
values (63405, to_date('27-07-2023', 'dd-mm-yyyy'), 10245);
insert into ORDERS (order_id, order_date, buyer_id)
values (84792, to_date('04-03-2023', 'dd-mm-yyyy'), 10309);
insert into ORDERS (order_id, order_date, buyer_id)
values (61221, to_date('16-01-2023', 'dd-mm-yyyy'), 10265);
insert into ORDERS (order_id, order_date, buyer_id)
values (63381, to_date('13-09-2023', 'dd-mm-yyyy'), 10406);
insert into ORDERS (order_id, order_date, buyer_id)
values (30260, to_date('09-09-2023', 'dd-mm-yyyy'), 10568);
insert into ORDERS (order_id, order_date, buyer_id)
values (61236, to_date('01-10-2023', 'dd-mm-yyyy'), 10149);
insert into ORDERS (order_id, order_date, buyer_id)
values (43363, to_date('13-11-2023', 'dd-mm-yyyy'), 10122);
insert into ORDERS (order_id, order_date, buyer_id)
values (69083, to_date('19-10-2023', 'dd-mm-yyyy'), 10583);
insert into ORDERS (order_id, order_date, buyer_id)
values (57351, to_date('08-11-2023', 'dd-mm-yyyy'), 10294);
insert into ORDERS (order_id, order_date, buyer_id)
values (47350, to_date('03-07-2023', 'dd-mm-yyyy'), 10081);
insert into ORDERS (order_id, order_date, buyer_id)
values (50204, to_date('27-12-2023', 'dd-mm-yyyy'), 10641);
insert into ORDERS (order_id, order_date, buyer_id)
values (71618, to_date('28-07-2023', 'dd-mm-yyyy'), 10122);
insert into ORDERS (order_id, order_date, buyer_id)
values (65313, to_date('11-05-2023', 'dd-mm-yyyy'), 10451);
commit;
prompt 300 records committed...
insert into ORDERS (order_id, order_date, buyer_id)
values (43355, to_date('26-08-2023', 'dd-mm-yyyy'), 10688);
insert into ORDERS (order_id, order_date, buyer_id)
values (32865, to_date('07-05-2023', 'dd-mm-yyyy'), 10545);
insert into ORDERS (order_id, order_date, buyer_id)
values (82777, to_date('10-11-2023', 'dd-mm-yyyy'), 10303);
insert into ORDERS (order_id, order_date, buyer_id)
values (46773, to_date('11-07-2023', 'dd-mm-yyyy'), 10233);
insert into ORDERS (order_id, order_date, buyer_id)
values (81917, to_date('24-04-2023', 'dd-mm-yyyy'), 10358);
insert into ORDERS (order_id, order_date, buyer_id)
values (72987, to_date('08-02-2023', 'dd-mm-yyyy'), 10447);
insert into ORDERS (order_id, order_date, buyer_id)
values (79853, to_date('13-12-2023', 'dd-mm-yyyy'), 10366);
insert into ORDERS (order_id, order_date, buyer_id)
values (44824, to_date('21-07-2023', 'dd-mm-yyyy'), 10252);
insert into ORDERS (order_id, order_date, buyer_id)
values (29060, to_date('21-11-2023', 'dd-mm-yyyy'), 10057);
insert into ORDERS (order_id, order_date, buyer_id)
values (61011, to_date('23-12-2023', 'dd-mm-yyyy'), 10230);
insert into ORDERS (order_id, order_date, buyer_id)
values (37740, to_date('27-02-2023', 'dd-mm-yyyy'), 10333);
insert into ORDERS (order_id, order_date, buyer_id)
values (65841, to_date('31-10-2023', 'dd-mm-yyyy'), 10025);
insert into ORDERS (order_id, order_date, buyer_id)
values (88288, to_date('13-04-2023', 'dd-mm-yyyy'), 10646);
insert into ORDERS (order_id, order_date, buyer_id)
values (66073, to_date('18-06-2023', 'dd-mm-yyyy'), 10013);
insert into ORDERS (order_id, order_date, buyer_id)
values (12465, to_date('04-12-2023', 'dd-mm-yyyy'), 10546);
insert into ORDERS (order_id, order_date, buyer_id)
values (29300, to_date('26-11-2023', 'dd-mm-yyyy'), 10551);
insert into ORDERS (order_id, order_date, buyer_id)
values (79956, to_date('03-07-2023', 'dd-mm-yyyy'), 10042);
insert into ORDERS (order_id, order_date, buyer_id)
values (71414, to_date('01-01-2024', 'dd-mm-yyyy'), 10236);
insert into ORDERS (order_id, order_date, buyer_id)
values (24402, to_date('03-01-2023', 'dd-mm-yyyy'), 10038);
insert into ORDERS (order_id, order_date, buyer_id)
values (59762, to_date('07-07-2023', 'dd-mm-yyyy'), 10624);
insert into ORDERS (order_id, order_date, buyer_id)
values (90411, to_date('05-03-2023', 'dd-mm-yyyy'), 10529);
insert into ORDERS (order_id, order_date, buyer_id)
values (21714, to_date('04-11-2023', 'dd-mm-yyyy'), 10102);
insert into ORDERS (order_id, order_date, buyer_id)
values (51975, to_date('26-07-2023', 'dd-mm-yyyy'), 10303);
insert into ORDERS (order_id, order_date, buyer_id)
values (98658, to_date('26-01-2023', 'dd-mm-yyyy'), 10187);
insert into ORDERS (order_id, order_date, buyer_id)
values (67942, to_date('26-08-2023', 'dd-mm-yyyy'), 10281);
insert into ORDERS (order_id, order_date, buyer_id)
values (71260, to_date('05-07-2023', 'dd-mm-yyyy'), 10070);
insert into ORDERS (order_id, order_date, buyer_id)
values (19116, to_date('22-02-2023', 'dd-mm-yyyy'), 10138);
insert into ORDERS (order_id, order_date, buyer_id)
values (86055, to_date('19-09-2023', 'dd-mm-yyyy'), 10409);
insert into ORDERS (order_id, order_date, buyer_id)
values (15073, to_date('20-08-2023', 'dd-mm-yyyy'), 10038);
insert into ORDERS (order_id, order_date, buyer_id)
values (44341, to_date('21-12-2023', 'dd-mm-yyyy'), 10272);
insert into ORDERS (order_id, order_date, buyer_id)
values (42265, to_date('18-05-2023', 'dd-mm-yyyy'), 10366);
insert into ORDERS (order_id, order_date, buyer_id)
values (95050, to_date('17-12-2023', 'dd-mm-yyyy'), 10157);
insert into ORDERS (order_id, order_date, buyer_id)
values (19215, to_date('31-08-2023', 'dd-mm-yyyy'), 10053);
insert into ORDERS (order_id, order_date, buyer_id)
values (21797, to_date('19-01-2023', 'dd-mm-yyyy'), 10196);
insert into ORDERS (order_id, order_date, buyer_id)
values (55193, to_date('02-11-2023', 'dd-mm-yyyy'), 10266);
insert into ORDERS (order_id, order_date, buyer_id)
values (93937, to_date('08-10-2023', 'dd-mm-yyyy'), 10588);
insert into ORDERS (order_id, order_date, buyer_id)
values (16225, to_date('04-07-2023', 'dd-mm-yyyy'), 10409);
insert into ORDERS (order_id, order_date, buyer_id)
values (30109, to_date('30-01-2023', 'dd-mm-yyyy'), 10274);
insert into ORDERS (order_id, order_date, buyer_id)
values (22426, to_date('02-02-2023', 'dd-mm-yyyy'), 10663);
insert into ORDERS (order_id, order_date, buyer_id)
values (23825, to_date('07-01-2023', 'dd-mm-yyyy'), 10378);
insert into ORDERS (order_id, order_date, buyer_id)
values (13897, to_date('19-07-2023', 'dd-mm-yyyy'), 10458);
insert into ORDERS (order_id, order_date, buyer_id)
values (71947, to_date('24-04-2023', 'dd-mm-yyyy'), 10556);
insert into ORDERS (order_id, order_date, buyer_id)
values (84563, to_date('28-08-2023', 'dd-mm-yyyy'), 10069);
insert into ORDERS (order_id, order_date, buyer_id)
values (91848, to_date('29-01-2023', 'dd-mm-yyyy'), 10672);
insert into ORDERS (order_id, order_date, buyer_id)
values (84914, to_date('03-01-2023', 'dd-mm-yyyy'), 10342);
insert into ORDERS (order_id, order_date, buyer_id)
values (49577, to_date('09-04-2023', 'dd-mm-yyyy'), 10257);
insert into ORDERS (order_id, order_date, buyer_id)
values (91238, to_date('11-04-2023', 'dd-mm-yyyy'), 10562);
insert into ORDERS (order_id, order_date, buyer_id)
values (32616, to_date('11-01-2023', 'dd-mm-yyyy'), 10518);
insert into ORDERS (order_id, order_date, buyer_id)
values (91292, to_date('25-04-2023', 'dd-mm-yyyy'), 10697);
insert into ORDERS (order_id, order_date, buyer_id)
values (55042, to_date('11-03-2023', 'dd-mm-yyyy'), 10016);
insert into ORDERS (order_id, order_date, buyer_id)
values (70059, to_date('03-12-2023', 'dd-mm-yyyy'), 10350);
insert into ORDERS (order_id, order_date, buyer_id)
values (73096, to_date('17-11-2023', 'dd-mm-yyyy'), 10117);
insert into ORDERS (order_id, order_date, buyer_id)
values (24854, to_date('04-09-2023', 'dd-mm-yyyy'), 10348);
insert into ORDERS (order_id, order_date, buyer_id)
values (83507, to_date('20-12-2023', 'dd-mm-yyyy'), 10497);
insert into ORDERS (order_id, order_date, buyer_id)
values (52254, to_date('30-08-2023', 'dd-mm-yyyy'), 10564);
insert into ORDERS (order_id, order_date, buyer_id)
values (58535, to_date('28-07-2023', 'dd-mm-yyyy'), 10002);
insert into ORDERS (order_id, order_date, buyer_id)
values (70761, to_date('03-06-2023', 'dd-mm-yyyy'), 10343);
insert into ORDERS (order_id, order_date, buyer_id)
values (48692, to_date('21-01-2023', 'dd-mm-yyyy'), 10226);
insert into ORDERS (order_id, order_date, buyer_id)
values (38332, to_date('25-08-2023', 'dd-mm-yyyy'), 10060);
insert into ORDERS (order_id, order_date, buyer_id)
values (59623, to_date('16-01-2023', 'dd-mm-yyyy'), 10535);
insert into ORDERS (order_id, order_date, buyer_id)
values (63620, to_date('02-03-2023', 'dd-mm-yyyy'), 10493);
insert into ORDERS (order_id, order_date, buyer_id)
values (11789, to_date('08-11-2023', 'dd-mm-yyyy'), 10643);
insert into ORDERS (order_id, order_date, buyer_id)
values (99538, to_date('26-07-2023', 'dd-mm-yyyy'), 10541);
insert into ORDERS (order_id, order_date, buyer_id)
values (43515, to_date('04-09-2023', 'dd-mm-yyyy'), 10677);
insert into ORDERS (order_id, order_date, buyer_id)
values (98230, to_date('15-10-2023', 'dd-mm-yyyy'), 10605);
insert into ORDERS (order_id, order_date, buyer_id)
values (17769, to_date('29-11-2023', 'dd-mm-yyyy'), 10605);
insert into ORDERS (order_id, order_date, buyer_id)
values (93378, to_date('17-05-2023', 'dd-mm-yyyy'), 10327);
insert into ORDERS (order_id, order_date, buyer_id)
values (83902, to_date('18-01-2023', 'dd-mm-yyyy'), 10072);
insert into ORDERS (order_id, order_date, buyer_id)
values (29459, to_date('21-02-2023', 'dd-mm-yyyy'), 10632);
insert into ORDERS (order_id, order_date, buyer_id)
values (35494, to_date('26-10-2023', 'dd-mm-yyyy'), 10584);
insert into ORDERS (order_id, order_date, buyer_id)
values (23998, to_date('26-10-2023', 'dd-mm-yyyy'), 10113);
insert into ORDERS (order_id, order_date, buyer_id)
values (87761, to_date('28-03-2023', 'dd-mm-yyyy'), 10253);
insert into ORDERS (order_id, order_date, buyer_id)
values (28316, to_date('30-03-2023', 'dd-mm-yyyy'), 10384);
insert into ORDERS (order_id, order_date, buyer_id)
values (70524, to_date('11-08-2023', 'dd-mm-yyyy'), 10537);
insert into ORDERS (order_id, order_date, buyer_id)
values (30702, to_date('07-04-2023', 'dd-mm-yyyy'), 10130);
insert into ORDERS (order_id, order_date, buyer_id)
values (18955, to_date('13-02-2023', 'dd-mm-yyyy'), 10257);
insert into ORDERS (order_id, order_date, buyer_id)
values (63733, to_date('16-02-2023', 'dd-mm-yyyy'), 10345);
insert into ORDERS (order_id, order_date, buyer_id)
values (92048, to_date('13-11-2023', 'dd-mm-yyyy'), 10133);
insert into ORDERS (order_id, order_date, buyer_id)
values (90374, to_date('06-03-2023', 'dd-mm-yyyy'), 10466);
insert into ORDERS (order_id, order_date, buyer_id)
values (91337, to_date('23-10-2023', 'dd-mm-yyyy'), 10312);
insert into ORDERS (order_id, order_date, buyer_id)
values (72084, to_date('31-01-2023', 'dd-mm-yyyy'), 10430);
insert into ORDERS (order_id, order_date, buyer_id)
values (67821, to_date('31-07-2023', 'dd-mm-yyyy'), 10390);
insert into ORDERS (order_id, order_date, buyer_id)
values (82109, to_date('22-06-2023', 'dd-mm-yyyy'), 10423);
insert into ORDERS (order_id, order_date, buyer_id)
values (66502, to_date('14-06-2023', 'dd-mm-yyyy'), 10123);
insert into ORDERS (order_id, order_date, buyer_id)
values (78989, to_date('18-03-2023', 'dd-mm-yyyy'), 10653);
insert into ORDERS (order_id, order_date, buyer_id)
values (63534, to_date('04-05-2023', 'dd-mm-yyyy'), 10328);
insert into ORDERS (order_id, order_date, buyer_id)
values (74820, to_date('14-02-2023', 'dd-mm-yyyy'), 10626);
insert into ORDERS (order_id, order_date, buyer_id)
values (53869, to_date('18-01-2023', 'dd-mm-yyyy'), 10183);
insert into ORDERS (order_id, order_date, buyer_id)
values (10420, to_date('19-10-2023', 'dd-mm-yyyy'), 10184);
insert into ORDERS (order_id, order_date, buyer_id)
values (25504, to_date('21-10-2023', 'dd-mm-yyyy'), 10657);
insert into ORDERS (order_id, order_date, buyer_id)
values (91102, to_date('01-07-2023', 'dd-mm-yyyy'), 10596);
insert into ORDERS (order_id, order_date, buyer_id)
values (13222, to_date('11-08-2023', 'dd-mm-yyyy'), 10683);
insert into ORDERS (order_id, order_date, buyer_id)
values (32645, to_date('08-10-2023', 'dd-mm-yyyy'), 10542);
insert into ORDERS (order_id, order_date, buyer_id)
values (58116, to_date('04-07-2023', 'dd-mm-yyyy'), 10056);
insert into ORDERS (order_id, order_date, buyer_id)
values (63138, to_date('05-11-2023', 'dd-mm-yyyy'), 10064);
insert into ORDERS (order_id, order_date, buyer_id)
values (42380, to_date('19-10-2023', 'dd-mm-yyyy'), 10486);
insert into ORDERS (order_id, order_date, buyer_id)
values (33042, to_date('13-01-2023', 'dd-mm-yyyy'), 10621);
insert into ORDERS (order_id, order_date, buyer_id)
values (49885, to_date('09-09-2023', 'dd-mm-yyyy'), 10606);
insert into ORDERS (order_id, order_date, buyer_id)
values (88929, to_date('21-06-2023', 'dd-mm-yyyy'), 10580);
insert into ORDERS (order_id, order_date, buyer_id)
values (45156, to_date('23-10-2023', 'dd-mm-yyyy'), 10197);
commit;
prompt 400 records committed...
insert into ORDERS (order_id, order_date, buyer_id)
values (26312, to_date('13-04-2023', 'dd-mm-yyyy'), 10171);
insert into ORDERS (order_id, order_date, buyer_id)
values (10000000000, to_date('11-08-2024 01:52:44', 'dd-mm-yyyy hh24:mi:ss'), 9999);
insert into ORDERS (order_id, order_date, buyer_id)
values (6667777, to_date('11-08-2024 01:53:57', 'dd-mm-yyyy hh24:mi:ss'), 9999);
insert into ORDERS (order_id, order_date, buyer_id)
values (99999999999, to_date('11-08-2024 01:56:33', 'dd-mm-yyyy hh24:mi:ss'), 9999);
insert into ORDERS (order_id, order_date, buyer_id)
values (2415235325, to_date('11-08-2024 02:28:40', 'dd-mm-yyyy hh24:mi:ss'), 9999);
insert into ORDERS (order_id, order_date, buyer_id)
values (24152353253, to_date('11-08-2024 02:30:34', 'dd-mm-yyyy hh24:mi:ss'), 9999);
insert into ORDERS (order_id, order_date, buyer_id)
values (2415235322223, to_date('11-08-2024 02:34:07', 'dd-mm-yyyy hh24:mi:ss'), 9999);
insert into ORDERS (order_id, order_date, buyer_id)
values (2415235324423324, to_date('11-08-2024 02:34:32', 'dd-mm-yyyy hh24:mi:ss'), 9999);
commit;
prompt 408 records loaded
prompt Loading INCLUDE_PRODUCTS...
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (51975, 114, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (52842, 301, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (11510, 79, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (76509, 450, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (76509, 92, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (45259, 211, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (93321, 143, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (70059, 480, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (44824, 408, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (23934, 145, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (62909, 227, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (38510, 152, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (72084, 210, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (80629, 346, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (95807, 272, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (59967, 415, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (65313, 43, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (67821, 238, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (50150, 330, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (80709, 307, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (92106, 211, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (49816, 195, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (35559, 345, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (90374, 157, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (38419, 334, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (89648, 468, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (31799, 106, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (58801, 111, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (46306, 201, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (24038, 32, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (27033, 21, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (52694, 476, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (34123, 121, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (69640, 199, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (96404, 477, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (48163, 189, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (95682, 101, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (98032, 199, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (90269, 177, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (65916, 140, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (63041, 272, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (72987, 204, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (93917, 366, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (90601, 1, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (79956, 157, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (13293, 217, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (28254, 271, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (33450, 1, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (26227, 435, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (80252, 188, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (68992, 304, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (23825, 463, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (52932, 110, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (50204, 395, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (45503, 58, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (56177, 450, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (40064, 385, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (40534, 285, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (25149, 26, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (22714, 423, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (88310, 9, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (49577, 11, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (59746, 218, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (83788, 128, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (59457, 54, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (80092, 125, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (17369, 416, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (93321, 332, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (34123, 189, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (88288, 471, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (43363, 434, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (88929, 355, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (59623, 199, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (59746, 396, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (19210, 422, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (71260, 268, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (72084, 417, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (47206, 91, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (56177, 331, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (71414, 451, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (66142, 267, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (28135, 487, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (81302, 296, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (67677, 209, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (96404, 174, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (19210, 281, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (99776, 326, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (48764, 248, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (33042, 365, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (29060, 117, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (91337, 301, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (57847, 91, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (81310, 89, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (52842, 391, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (21920, 411, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (64100, 412, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (63130, 417, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (88929, 492, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (72987, 308, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (82463, 146, 2);
commit;
prompt 100 records committed...
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (65915, 61, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (48016, 2, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (78989, 322, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (26312, 77, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (37709, 469, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (19116, 68, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (22426, 293, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (46144, 36, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (50609, 9, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (48764, 257, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (35098, 113, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (33012, 193, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (93321, 154, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (54267, 223, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (26277, 246, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (92638, 235, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (79853, 283, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (21885, 284, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (99776, 141, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (99776, 236, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (89662, 296, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (43355, 86, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (54635, 477, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (52177, 240, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (30109, 254, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (44484, 77, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (51465, 464, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (67677, 132, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (66464, 209, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (28135, 296, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (68135, 355, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (80258, 18, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (91238, 17, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (32041, 432, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (65915, 147, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (35559, 488, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (67942, 107, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (91102, 366, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (22714, 407, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (40058, 248, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (83507, 278, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (99538, 457, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (52254, 429, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (62909, 134, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (55927, 196, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (83788, 33, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (95050, 374, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (18955, 375, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (99606, 418, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (19863, 41, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (15633, 387, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (93085, 364, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (71414, 425, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (57379, 137, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (72546, 137, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (15928, 398, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (31770, 170, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (20230, 389, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (52932, 406, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (89705, 74, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (49577, 380, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (89705, 88, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (15928, 58, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (42380, 465, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (38154, 458, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (20842, 136, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (89573, 132, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (10154, 61, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (66111, 336, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (26312, 283, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (40534, 244, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (35660, 251, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (93937, 445, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (20842, 379, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (33184, 277, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (89705, 199, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (43363, 468, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (90093, 131, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (57379, 201, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (84914, 102, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (68973, 164, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (35763, 367, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (61568, 379, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (80258, 345, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (80471, 235, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (38332, 41, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (88610, 385, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (97162, 471, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (65916, 342, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (25552, 125, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (43515, 428, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (26277, 44, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (90411, 378, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (15928, 487, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (16225, 193, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (99606, 159, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (82081, 402, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (73096, 149, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (49816, 418, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (42735, 487, 10);
commit;
prompt 200 records committed...
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (46306, 133, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (94519, 116, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (99606, 310, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (82109, 263, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (58690, 79, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (33675, 153, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (76509, 299, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (92030, 322, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (35763, 33, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (89934, 308, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (98032, 27, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (70059, 5, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (85127, 195, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (80255, 298, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (33012, 338, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (72042, 145, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (84563, 422, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (32823, 374, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (99776, 389, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (91749, 248, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (80629, 142, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (12407, 1, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (82081, 389, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (52936, 352, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (35660, 120, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (15916, 205, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (98032, 335, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (40064, 375, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (12465, 451, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (63733, 221, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (95050, 69, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (85661, 256, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (43363, 182, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (53869, 479, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (82075, 161, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (20985, 387, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (52694, 84, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (82123, 345, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (21920, 312, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (63737, 445, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (94821, 402, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (58535, 422, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (38656, 437, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (13897, 313, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (71947, 298, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (31112, 48, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (40095, 398, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (83902, 479, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (50609, 421, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (51975, 56, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (28254, 342, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (35763, 391, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (62909, 279, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (46891, 190, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (32616, 310, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (72406, 324, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (28254, 486, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (42735, 1, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (95236, 350, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (59746, 47, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (19233, 319, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (84586, 291, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (83238, 41, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (61221, 86, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (95317, 401, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (24854, 324, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (93937, 382, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (24038, 116, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (65916, 229, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (89119, 482, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (64158, 294, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (33184, 23, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (35470, 100, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (24402, 401, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (29060, 326, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (38510, 398, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (53869, 362, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (98032, 25, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (92740, 115, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (34720, 341, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (80258, 387, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (84792, 299, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (35757, 476, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (25552, 460, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (89934, 323, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (66464, 313, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (64231, 373, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (25504, 284, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (26227, 361, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (89602, 209, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (56593, 387, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (93917, 218, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (99728, 312, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (92638, 1, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (27213, 220, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (51579, 457, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (84762, 440, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (26277, 405, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (37421, 111, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (70761, 308, 2);
commit;
prompt 300 records committed...
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (56593, 138, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (58116, 37, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (80629, 385, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (45259, 494, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (91337, 98, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (54473, 244, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (31770, 356, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (57575, 255, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (57379, 372, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (40064, 336, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (59849, 442, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (84762, 463, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (57351, 204, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (38154, 161, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (55070, 74, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (74716, 390, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (63534, 197, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (42380, 434, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (69640, 429, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (32041, 70, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (63733, 85, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (59457, 244, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (15938, 385, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (37453, 86, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (48824, 346, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (89624, 170, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (90374, 402, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (32402, 127, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (37453, 171, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (25504, 309, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (86055, 10, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (57852, 225, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (38656, 274, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (47350, 402, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (13783, 394, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (61568, 342, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (91096, 354, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (96856, 17, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (27033, 487, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (43394, 12, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (82109, 417, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (15916, 293, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (66111, 271, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (24038, 346, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (80092, 475, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (98726, 5, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (23825, 433, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (78989, 3, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (89662, 166, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (86548, 67, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (68531, 491, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (95813, 19, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (78140, 471, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (50609, 84, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (37740, 78, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (61568, 461, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (40058, 435, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (55042, 331, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (49577, 304, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (26706, 87, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (54635, 185, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (82081, 432, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (28254, 283, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (70761, 494, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (11137, 461, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (92048, 448, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (71428, 292, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (68656, 33, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (85127, 311, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (54785, 352, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (80629, 471, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (18868, 422, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (70761, 192, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (97823, 389, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (44341, 384, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (82075, 245, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (52636, 49, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (98032, 15, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (60282, 418, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (33012, 485, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (42380, 351, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (24038, 153, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (67942, 242, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (83902, 480, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (49577, 333, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (32402, 271, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (95456, 470, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (72406, 310, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (54785, 199, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (96466, 209, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (82463, 47, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (68135, 97, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (33675, 308, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (98067, 7, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (13897, 186, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (29300, 145, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (83788, 376, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (31934, 473, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (59457, 210, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (13897, 40, 2);
commit;
prompt 400 records committed...
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (82123, 377, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (15530, 467, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (86548, 345, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (88491, 394, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (48692, 478, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (54473, 321, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (95317, 492, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (59083, 170, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (42380, 471, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (24402, 200, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (95236, 418, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (40685, 438, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (84563, 233, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (91102, 101, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (52936, 17, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (58116, 324, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (86161, 436, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (48764, 429, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (54473, 385, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (57379, 211, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (68973, 348, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (51403, 215, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (66111, 164, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (99524, 174, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (68135, 96, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (90411, 64, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (68055, 2, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (51579, 68, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (32041, 43, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (44341, 227, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (42735, 445, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (63534, 352, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (63620, 441, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (53869, 143, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (96856, 432, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (95456, 448, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (95807, 183, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (93321, 474, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (80709, 220, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (63381, 391, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (26135, 49, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (78409, 389, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (99789, 361, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (89573, 324, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (24815, 133, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (38234, 249, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (21714, 316, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (82109, 408, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (95050, 42, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (21754, 250, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (92343, 410, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (32645, 380, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (38656, 210, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (80252, 460, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (59762, 114, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (84563, 97, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (48692, 317, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (45503, 468, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (42380, 51, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (59457, 49, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (88457, 328, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (51465, 394, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (72881, 465, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (14409, 470, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (15633, 371, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (18955, 220, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (45259, 352, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (86548, 249, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (47139, 290, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (61236, 439, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (95682, 97, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (92106, 440, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (61221, 282, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (99728, 234, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (89602, 219, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (84914, 487, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (37709, 226, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (80255, 391, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (47350, 319, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (86548, 113, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (90093, 365, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (57379, 486, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (95236, 433, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (95456, 179, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (89602, 200, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (56593, 260, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (59746, 259, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (46306, 391, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (63733, 482, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (24815, 411, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (86757, 198, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (90601, 252, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (44341, 467, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (61236, 121, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (81302, 395, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (99728, 396, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (14409, 9, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (67821, 125, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (95236, 12, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (19116, 87, 7);
commit;
prompt 500 records committed...
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (13897, 400, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (23934, 492, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (49885, 71, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (53869, 108, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (99538, 420, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (99376, 199, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (49816, 494, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (55893, 171, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (59849, 45, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (11510, 265, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (59623, 356, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (61236, 311, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (43394, 124, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (50150, 474, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (15938, 132, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (38419, 84, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (15073, 340, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (25176, 112, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (59967, 384, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (64100, 354, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (89602, 324, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (55193, 392, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (71316, 349, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (79688, 231, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (38154, 44, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (99728, 479, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (21754, 28, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (65915, 143, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (11789, 166, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (52842, 342, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (32616, 96, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (88610, 383, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (49577, 216, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (86055, 114, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (28316, 8, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (61016, 426, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (35757, 434, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (81849, 75, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (26312, 243, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (63130, 476, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (33453, 460, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (86161, 49, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (35359, 423, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (81310, 399, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (85127, 488, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (35757, 116, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (63733, 458, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (99538, 214, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (83507, 260, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (48016, 210, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (21754, 186, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (79070, 35, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (99728, 295, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (32865, 237, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (54267, 444, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (88310, 415, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (44341, 474, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (74499, 13, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (42735, 307, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (28135, 223, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (98067, 143, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (26706, 436, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (29060, 94, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (52842, 206, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (80255, 33, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (73096, 463, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (13897, 180, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (68531, 210, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (39457, 21, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (63138, 464, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (93943, 48, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (94519, 414, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (48180, 217, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (43355, 361, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (86161, 187, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (88895, 276, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (19116, 130, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (59623, 370, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (61011, 180, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (96856, 320, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (11510, 182, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (94821, 451, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (56177, 266, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (65916, 230, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (44630, 81, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (73409, 88, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (51465, 467, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (68531, 125, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (13213, 58, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (71618, 180, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (64498, 362, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (98230, 167, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (24815, 210, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (19233, 42, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (15530, 275, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (18868, 242, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (26706, 249, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (98032, 417, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (40095, 283, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (81302, 13, 6);
commit;
prompt 600 records committed...
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (87761, 93, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (90878, 309, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (57575, 31, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (72881, 362, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (74499, 387, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (28135, 284, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (71618, 463, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (23998, 343, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (35494, 173, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (11789, 289, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (89602, 326, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (98726, 287, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (22426, 430, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (45259, 428, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (84586, 155, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (66073, 14, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (90374, 89, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (25208, 404, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (80258, 436, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (85127, 50, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (10420, 412, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (40058, 404, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (59762, 472, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (40064, 11, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (61221, 118, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (34720, 348, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (82109, 205, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (26706, 315, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (33012, 371, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (32041, 38, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (21885, 420, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (74499, 150, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (31112, 303, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (64498, 349, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (90269, 355, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (13213, 85, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (83238, 412, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (84762, 328, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (48016, 254, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (64498, 20, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (23998, 232, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (89624, 477, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (19215, 235, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (32616, 131, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (31485, 438, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (54635, 420, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (48163, 284, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (31743, 199, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (32616, 454, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (26135, 479, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (10000000000, 1, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (10000000000, 2, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (10000000000, 3, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (6667777, 1, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (6667777, 2, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (6667777, 3, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (99999999999, 1, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (99999999999, 2, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (99999999999, 3, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (2415235325, 1, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (2415235325, 2, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (2415235325, 3, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (24152353253, 1, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (24152353253, 2, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (24152353253, 3, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (2415235322223, 1, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (2415235322223, 2, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (2415235322223, 4, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (2415235324423324, 1, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (2415235324423324, 2, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (2415235324423324, 4, 1);
commit;
prompt 671 records loaded
prompt Loading ORDERDETAILS...
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (98999, 'home delivery', 'CMA-070');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (68992, 'pick up spots', 'IBB-114');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (19233, 'home delivery', 'CP-029');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (82081, 'pick up from store', 'CMA-116');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (93085, 'pick up from store', 'MB-062');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (90560, 'pick up spots', 'YS-022');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (84615, 'home delivery', 'SK-017');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (20985, 'home delivery', 'RD-024');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (74716, 'pick up spots', 'VC-035');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (40064, 'pick up spots', 'IBB-044');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (52694, 'pick up spots', 'SK-013');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (51465, 'pick up spots', 'UP-004');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (70761, 'home delivery', 'ABB-010');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (48289, 'home delivery', 'CMA-116');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (95682, 'home delivery', 'YS-024');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (72546, 'pick up spots', 'MB-048');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (21885, 'home delivery', 'MS-001');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (80709, 'pick up from store', 'CMI-075');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (82628, 'pick up spots', 'FM-006');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (48764, 'pick up spots', 'PT-004');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (43363, 'pick up from store', 'ML-011');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (84586, 'home delivery', 'MT-009');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (48692, 'home delivery', 'ME-021');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (26706, 'pick up spots', 'FD-001');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (99776, 'pick up spots', 'CS-099');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (58116, 'home delivery', 'CS-051');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (69640, 'pick up spots', 'YS-006');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (19116, 'pick up spots', 'CP-030');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (89602, 'home delivery', 'IBB-109');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (80255, 'home delivery', 'YS-024');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (38510, 'pick up spots', 'CMA-130');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (52932, 'pick up from store', 'MT-016');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (28316, 'home delivery', 'MB-058');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (89705, 'pick up from store', 'MB-011');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (46144, 'pick up from store', 'CMA-071');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (13222, 'pick up spots', 'ME-019');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (80092, 'pick up from store', 'CS-005');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (61221, 'pick up spots', 'YS-015');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (52636, 'pick up from store', 'KB-006');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (18370, 'home delivery', 'ABB-100');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (47350, 'pick up from store', 'ABB-082');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (33042, 'pick up spots', 'CMI-110');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (15928, 'home delivery', 'ABB-109');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (61236, 'pick up spots', 'YS-026');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (18955, 'pick up spots', 'CS-031');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (89648, 'pick up from store', 'SK-002');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (93859, 'pick up spots', 'SK-012');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (32616, 'home delivery', 'UP-011');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (90374, 'home delivery', 'CMI-118');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (89662, 'pick up from store', 'RD-029');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (71260, 'pick up from store', 'NC-004');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (46306, 'pick up from store', 'CMA-128');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (19863, 'home delivery', 'CP-043');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (34720, 'pick up from store', 'RD-015');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (90601, 'pick up spots', 'CS-014');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (24854, 'pick up spots', 'MB-063');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (31485, 'pick up spots', 'MT-014');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (33184, 'pick up spots', 'RD-023');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (98230, 'pick up from store', 'CS-066');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (85127, 'pick up from store', 'ABB-054');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (62909, 'pick up spots', 'MB-012');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (24038, 'home delivery', 'ABB-072');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (90056, 'pick up from store', 'VC-016');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (61011, 'home delivery', 'RD-026');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (19210, 'home delivery', 'UP-017');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (47206, 'home delivery', 'CMI-104');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (29946, 'pick up from store', 'CP-004');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (48163, 'pick up spots', 'CMI-118');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (59083, 'pick up from store', 'NC-011');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (91238, 'home delivery', 'CS-019');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (61568, 'pick up from store', 'ME-013');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (60575, 'pick up spots', 'CMA-132');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (95050, 'home delivery', 'CS-025');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (74499, 'home delivery', 'CP-038');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (57852, 'pick up from store', 'CS-099');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (67821, 'pick up spots', 'ABB-074');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (24815, 'pick up spots', 'RD-011');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (64231, 'home delivery', 'CMA-070');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (64158, 'home delivery', 'CMI-084');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (59746, 'pick up spots', 'ABB-082');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (79853, 'pick up from store', 'FM-008');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (70524, 'pick up from store', 'MB-042');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (66073, 'home delivery', 'HD-044');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (41750, 'home delivery', 'IBB-010');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (83788, 'pick up from store', 'CS-046');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (38656, 'pick up from store', 'YS-024');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (17769, 'home delivery', 'IBB-006');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (95456, 'pick up from store', 'MB-026');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (20230, 'pick up spots', 'CMA-107');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (54635, 'pick up spots', 'RD-031');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (29459, 'pick up spots', 'KB-003');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (55193, 'pick up from store', 'CS-008');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (92048, 'home delivery', 'CMA-104');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (63381, 'pick up spots', 'HD-024');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (52936, 'home delivery', 'CS-004');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (26135, 'pick up spots', 'VC-034');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (66142, 'home delivery', 'CMA-150');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (96349, 'pick up from store', 'ABB-114');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (38234, 'pick up spots', 'CP-049');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (33450, 'pick up spots', 'ME-014');
commit;
prompt 100 records committed...
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (21793, 'pick up spots', 'MB-012');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (48913, 'pick up spots', 'CMA-157');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (65841, 'pick up from store', 'CS-099');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (50204, 'pick up from store', 'MB-062');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (35660, 'pick up spots', 'CS-034');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (37453, 'home delivery', 'ABB-108');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (34123, 'home delivery', 'NC-013');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (58801, 'pick up from store', 'CP-041');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (21714, 'pick up from store', 'CMI-099');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (91749, 'pick up from store', 'PT-099');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (15844, 'pick up spots', 'CMI-120');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (95236, 'home delivery', 'sy-006');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (24402, 'home delivery', 'CMI-098');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (25504, 'pick up spots', 'SK-002');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (93321, 'pick up from store', 'NC-005');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (58535, 'home delivery', 'ABB-012');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (26277, 'pick up spots', 'HD-007');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (51403, 'home delivery', 'ABB-101');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (44824, 'pick up from store', 'SK-002');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (16225, 'pick up from store', 'ABB-108');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (32865, 'home delivery', 'UP-017');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (35359, 'pick up spots', 'CP-045');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (76799, 'pick up spots', 'CP-032');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (28135, 'pick up from store', 'ME-022');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (26312, 'home delivery', 'VC-015');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (37709, 'pick up from store', 'ME-010');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (53869, 'pick up from store', 'CS-050');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (99606, 'pick up spots', 'ML-031');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (51975, 'home delivery', 'UP-011');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (89027, 'pick up from store', 'CMI-100');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (80471, 'pick up from store', 'HD-003');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (88310, 'home delivery', 'MB-006');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (61016, 'pick up from store', 'CS-031');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (15073, 'pick up spots', 'ABB-095');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (57575, 'pick up from store', 'CMI-122');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (63534, 'pick up spots', 'CMA-149');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (92343, 'pick up from store', 'CMA-155');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (81302, 'pick up spots', 'RD-031');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (49816, 'home delivery', 'SW-002');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (87761, 'pick up from store', 'ML-010');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (88457, 'pick up spots', 'CMI-117');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (63737, 'pick up from store', 'CMA-071');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (89624, 'home delivery', 'ML-036');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (29060, 'home delivery', 'KB-013');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (55070, 'home delivery', 'IBB-038');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (32645, 'pick up from store', 'RD-026');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (12465, 'home delivery', 'MB-057');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (79688, 'pick up spots', 'ML-017');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (72084, 'pick up spots', 'CMA-156');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (66111, 'pick up from store', 'ABB-104');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (17847, 'pick up spots', 'MB-042');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (73096, 'home delivery', 'NC-010');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (44341, 'home delivery', 'CMA-144');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (31770, 'home delivery', 'CS-058');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (18452, 'home delivery', 'RD-011');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (89119, 'pick up spots', 'ABB-012');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (35763, 'pick up spots', 'ABB-106');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (45969, 'pick up from store', 'RD-027');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (92740, 'pick up from store', 'CP-038');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (35098, 'pick up from store', 'IBB-019');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (88491, 'home delivery', 'CMA-151');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (96856, 'pick up spots', 'VC-048');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (54785, 'pick up spots', 'CMA-152');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (63733, 'home delivery', 'CMA-144');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (68135, 'home delivery', 'IBB-041');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (72406, 'pick up from store', 'MB-041');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (65079, 'pick up from store', 'HD-012');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (35494, 'pick up from store', 'ABB-082');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (99524, 'pick up from store', 'HD-035');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (86362, 'home delivery', 'CS-019');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (25208, 'pick up from store', 'CS-088');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (65313, 'home delivery', 'SW-007');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (96404, 'pick up spots', 'CP-052');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (28254, 'pick up spots', 'CMI-113');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (13213, 'pick up spots', 'MB-042');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (58690, 'pick up spots', 'CS-020');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (88610, 'home delivery', 'ML-040');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (80252, 'home delivery', 'CMA-021');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (88895, 'pick up from store', 'ML-026');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (91096, 'pick up from store', 'MB-004');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (66502, 'pick up from store', 'CMI-067');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (43515, 'pick up from store', 'ME-016');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (59762, 'pick up spots', 'ABB-103');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (33675, 'home delivery', 'ABB-107');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (15916, 'pick up from store', 'YS-024');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (68531, 'home delivery', 'KB-006');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (63130, 'home delivery', 'CMI-100');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (58533, 'pick up spots', 'CMA-072');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (91102, 'home delivery', 'ABB-060');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (95988, 'pick up spots', 'ABB-069');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (57351, 'pick up spots', 'CMA-114');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (71414, 'pick up from store', 'NC-016');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (80659, 'pick up from store', 'ME-023');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (63138, 'pick up from store', 'ABB-100');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (70059, 'pick up spots', 'NC-025');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (48180, 'home delivery', 'VC-019');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (91292, 'home delivery', 'KB-008');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (42265, 'pick up from store', 'ME-021');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (73861, 'pick up from store', 'SC-003');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (31112, 'home delivery', 'MS-001');
commit;
prompt 200 records committed...
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (38332, 'home delivery', 'IBB-034');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (82109, 'pick up from store', 'MT-018');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (77774, 'pick up spots', 'ABB-026');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (67942, 'home delivery', 'IBB-114');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (44484, 'home delivery', 'RD-035');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (33027, 'pick up from store', 'YS-027');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (32402, 'pick up from store', 'MB-021');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (80258, 'pick up from store', 'CMI-100');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (46891, 'home delivery', 'HD-012');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (59849, 'pick up spots', 'NC-027');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (46773, 'pick up spots', 'CS-092');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (52842, 'home delivery', 'MB-052');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (47139, 'pick up spots', 'CMI-120');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (64498, 'pick up from store', 'ME-013');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (14409, 'pick up from store', 'NC-025');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (84914, 'pick up from store', 'PT-004');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (95317, 'pick up spots', 'ABB-057');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (91337, 'home delivery', 'VC-012');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (25149, 'pick up spots', 'MB-024');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (95813, 'pick up spots', 'CMA-059');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (74820, 'pick up from store', 'ML-029');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (86757, 'pick up spots', 'CMA-099');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (37740, 'pick up from store', 'CS-005');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (55663, 'home delivery', 'CS-031');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (55893, 'pick up from store', 'CMA-154');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (94519, 'pick up from store', 'MB-028');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (44630, 'home delivery', 'CMI-084');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (97162, 'home delivery', 'VC-041');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (54267, 'pick up spots', 'SC-010');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (40534, 'pick up spots', 'IBB-013');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (83507, 'pick up spots', 'CMI-113');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (86548, 'pick up from store', 'ABB-114');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (45259, 'pick up from store', 'CMA-141');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (95807, 'home delivery', 'CMA-156');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (21797, 'pick up from store', 'CMA-138');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (30109, 'home delivery', 'RD-008');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (85661, 'pick up spots', 'ML-015');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (82123, 'pick up spots', 'VC-031');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (63620, 'pick up spots', 'CP-024');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (15530, 'pick up from store', 'CS-009');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (44750, 'pick up spots', 'CMI-051');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (22714, 'home delivery', 'IBB-033');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (69126, 'home delivery', 'CMI-076');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (25552, 'pick up spots', 'VC-030');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (99452, 'home delivery', 'VC-013');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (65916, 'home delivery', 'CP-008');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (68973, 'home delivery', 'ABB-108');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (93943, 'pick up spots', 'CMI-078');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (98846, 'pick up from store', 'KB-005');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (63405, 'home delivery', 'PT-003');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (82910, 'pick up from store', 'IBB-019');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (71428, 'pick up spots', 'IBB-038');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (90269, 'pick up from store', 'ABB-072');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (99789, 'home delivery', 'ME-026');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (59967, 'pick up from store', 'MS-001');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (40058, 'pick up spots', 'YS-004');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (93917, 'home delivery', 'ABB-061');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (97823, 'home delivery', 'CP-020');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (59623, 'home delivery', 'RD-008');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (90411, 'pick up from store', 'FM-006');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (14075, 'pick up from store', 'CS-021');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (91848, 'pick up from store', 'ME-014');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (84563, 'pick up from store', 'ABB-001');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (13783, 'pick up from store', 'CMI-107');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (76509, 'home delivery', 'MB-010');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (79070, 'home delivery', 'IBB-021');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (69083, 'pick up spots', 'ML-011');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (21920, 'home delivery', 'CMI-079');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (72115, 'pick up from store', 'MT-005');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (19215, 'pick up from store', 'IBB-005');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (93378, 'home delivery', 'ABB-053');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (45156, 'home delivery', 'CS-051');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (11510, 'home delivery', 'ABB-087');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (86161, 'pick up spots', 'CMA-116');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (89934, 'pick up spots', 'IBB-006');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (30702, 'pick up from store', 'VC-041');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (48016, 'pick up spots', 'SY-008');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (94821, 'pick up from store', 'IBB-110');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (77123, 'home delivery', 'CS-024');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (60282, 'home delivery', 'CS-021');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (84792, 'home delivery', 'IBB-113');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (35470, 'home delivery', 'CS-025');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (52177, 'home delivery', 'ABB-001');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (37421, 'pick up from store', 'IBB-038');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (32041, 'home delivery', 'RD-038');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (49885, 'home delivery', 'CMI-092');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (32823, 'pick up spots', 'ME-016');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (15938, 'pick up from store', 'IBB-026');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (83902, 'pick up spots', 'CMI-101');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (15633, 'home delivery', 'CMA-159');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (98726, 'home delivery', 'RD-024');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (86055, 'pick up from store', 'CMA-149');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (26227, 'home delivery', 'ML-102');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (19822, 'pick up spots', 'ME-019');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (68656, 'pick up from store', 'VC-016');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (52254, 'pick up from store', 'TB-009');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (98032, 'home delivery', 'ABB-077');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (55927, 'pick up from store', 'MS-011');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (13897, 'pick up from store', 'CS-025');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (80629, 'home delivery', 'ME-026');
commit;
prompt 300 records committed...
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (71947, 'home delivery', 'YS-026');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (98658, 'pick up spots', 'CS-050');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (82777, 'home delivery', 'KB-008');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (42735, 'pick up spots', 'ABB-098');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (99538, 'home delivery', 'CS-077');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (81917, 'pick up from store', 'CMA-111');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (82075, 'pick up from store', 'ABB-072');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (10420, 'home delivery', 'ABB-103');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (12407, 'home delivery', 'MB-001');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (92030, 'pick up spots', 'PT-012');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (81310, 'pick up from store', 'CMA-117');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (92106, 'home delivery', 'CMI-097');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (72238, 'pick up from store', 'SW-011');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (73409, 'home delivery', 'CMI-120');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (78409, 'pick up from store', 'ME-023');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (57847, 'home delivery', 'CS-050');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (49577, 'pick up spots', 'CS-020');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (72987, 'pick up from store', 'MB-023');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (45503, 'home delivery', 'CS-077');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (40095, 'pick up from store', 'HD-015');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (65915, 'home delivery', 'KB-008');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (55042, 'home delivery', 'NC-011');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (10154, 'pick up from store', 'CMA-130');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (11137, 'pick up spots', 'NC-020');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (29300, 'home delivery', 'CP-029');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (89573, 'pick up from store', 'YS-010');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (41007, 'pick up spots', 'MB-012');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (21754, 'pick up from store', 'CS-021');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (22426, 'home delivery', 'RD-035');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (61009, 'home delivery', 'CMI-093');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (48824, 'home delivery', 'SC-009');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (27213, 'home delivery', 'ML-034');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (31934, 'pick up spots', 'KB-006');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (73791, 'pick up spots', 'ABB-069');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (13293, 'pick up spots', 'CP-040');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (63041, 'pick up from store', 'ME-009');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (18868, 'pick up spots', 'HD-003');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (41740, 'pick up from store', 'ML-031');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (67677, 'pick up spots', 'IBB-034');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (99376, 'home delivery', 'CP-007');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (35559, 'home delivery', 'CP-024');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (71316, 'pick up from store', 'CS-015');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (31799, 'pick up from store', 'HD-036');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (87648, 'pick up spots', 'MB-024');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (43394, 'pick up from store', 'CMI-119');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (38419, 'home delivery', 'SK-013');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (20842, 'pick up spots', 'ABB-062');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (33453, 'pick up spots', 'CMI-099');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (96466, 'home delivery', 'ME-019');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (33012, 'home delivery', 'ME-014');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (59457, 'pick up spots', 'RD-029');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (79956, 'home delivery', 'CMA-160');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (40685, 'home delivery', 'KB-006');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (90620, 'pick up spots', 'CS-072');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (56593, 'home delivery', 'CMA-114');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (50150, 'home delivery', 'ML-102');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (88929, 'pick up from store', 'NC-012');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (90093, 'pick up spots', 'CMA-039');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (72881, 'pick up from store', 'SK-014');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (35757, 'pick up spots', 'RD-014');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (18611, 'pick up spots', 'CMA-142');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (83238, 'home delivery', 'ME-031');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (81849, 'pick up from store', 'NC-005');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (54473, 'home delivery', 'ABB-001');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (56177, 'pick up from store', 'YS-026');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (11789, 'pick up spots', 'YS-024');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (51579, 'home delivery', 'ABB-077');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (61982, 'pick up from store', 'TB-009');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (92638, 'pick up spots', 'CMI-105');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (65358, 'pick up spots', 'MB-033');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (23998, 'pick up from store', 'ABB-110');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (23934, 'pick up from store', 'ABB-089');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (49848, 'pick up from store', 'ME-034');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (57379, 'pick up spots', 'KB-018');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (99728, 'pick up spots', 'CS-077');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (64100, 'pick up from store', 'CMI-115');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (17369, 'pick up spots', 'RD-028');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (33333, 'home delivery', 'ML-026');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (30260, 'pick up spots', 'MB-024');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (66464, 'pick up from store', 'IBB-110');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (39457, 'pick up from store', 'CP-024');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (88288, 'pick up spots', 'RD-034');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (71618, 'pick up from store', 'CS-072');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (31743, 'pick up from store', 'IBB-109');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (93937, 'pick up spots', 'CS-031');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (84762, 'pick up spots', 'IBB-015');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (50609, 'pick up spots', 'RD-018');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (42380, 'pick up from store', 'KB-002');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (23825, 'home delivery', 'MB-002');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (72042, 'pick up spots', 'ABB-100');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (68055, 'home delivery', 'IBB-044');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (98067, 'pick up spots', 'IBB-033');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (82463, 'pick up spots', 'IBB-010');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (78140, 'pick up from store', 'CS-018');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (78989, 'home delivery', 'ABB-114');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (38154, 'pick up spots', 'ML-039');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (75064, 'pick up spots', 'CS-025');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (90878, 'pick up from store', 'CS-020');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (27033, 'pick up from store', 'ME-016');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (25176, 'home delivery', 'MB-011');
commit;
prompt 400 records committed...
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (43355, 'home delivery', 'CP-042');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (10000000000, 'home delivery', 'TRACK12345');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (6667777, 'home delivery', 'TRACK12345');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (99999999999, 'home delivery', 'TRACK12345');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (2415235325, 'home delivery', 'TRACK12345');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (24152353253, 'home delivery', 'TRACK12345');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (2415235322223, 'home delivery', 'TRACK12345');
insert into ORDERDETAILS (order_id, delivery_method, tracking_number)
values (2415235324423324, 'home delivery', 'TRACK12345');
commit;
prompt 408 records loaded
prompt Loading PRODUCTS...
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (1, ' Laptop', ' New', 899.99, 1, 1, to_date('26-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (2, ' Desktop Computer', ' Refurbished', 699.99, 1, 22, to_date('20-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (3, ' Monitor', ' New', 199.99, 1, 0, to_date('03-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (4, ' Keyboard', ' New', 49.99, 1, 11, to_date('30-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (5, ' Mouse', ' New', 19.99, 1, 16, to_date('30-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (6, ' External Hard Drive', ' Refurbished', 79.99, 11, 18, to_date('23-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (7, ' USB Flash Drive', ' New', 14.99, 11, 20, to_date('24-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (8, ' Printer', ' New', 149.99, 2, 15, to_date('05-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (9, ' Wireless Keyboard', ' Refurbished', 29.99, 1, 25, to_date('12-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (10, ' Bluetooth Speaker', ' New', 79.99, 2, 21, to_date('26-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (11, ' Gaming Mouse', ' New', 49.99, 5, 28, to_date('05-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (12, ' Mechanical Keyboard', ' Refurbished', 89.99, 5, 16, to_date('27-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (13, ' Wireless Headphones', ' New', 129.99, 6, 11, to_date('30-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (14, ' Earbuds', ' Refurbished', 39.99, 6, 24, to_date('18-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (15, ' Smartwatch', ' New', 199.99, 8, 27, to_date('21-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (16, ' Fitness Tracker', ' New', 69.99, 12, 28, to_date('19-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (17, ' Digital Camera', ' Refurbished', 149.99, 9, 27, to_date('06-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (18, ' DSLR Camera', ' New', 699.99, 9, 7, to_date('05-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (19, ' LED Desk Lamp', ' New', 34.99, 10, 16, to_date('29-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (20, ' Smart Bulbs', ' Refurbished', 19.99, 10, 3, to_date('24-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (21, ' WiFi Router', ' New', 79.99, 4, 1, to_date('09-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (22, ' Network Switch', ' New', 49.99, 4, 22, to_date('20-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (23, ' Gaming Console', ' New', 399.99, 5, 17, to_date('16-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (24, ' VR Headset', ' Refurbished', 299.99, 28, 13, to_date('17-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (25, ' Action Camera', ' New', 199.99, 28, 28, to_date('31-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (26, ' 3D Printer', ' New', 399.99, 29, 29, to_date('02-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (27, ' Filament Refill', ' New', 29.99, 29, 15, to_date('12-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (28, ' Blood Pressure Monitor', ' New', 59.99, 17, 11, to_date('03-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (29, ' Electric Shaver', ' New', 79.99, 12, 24, to_date('28-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (31, ' Dumbbell Set', ' Refurbished', 49.99, 18, 16, to_date('20-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (32, ' Resistance Bands', ' New', 19.99, 18, 24, to_date('06-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (33, ' Treadmill', ' New', 599.99, 18, 4, to_date('26-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (35, ' Elliptical Machine', ' Refurbished', 449.99, 18, 14, to_date('26-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (36, ' Home Gym Set', ' New', 899.99, 18, 25, to_date('06-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (37, ' Jump Rope', ' New', 9.99, 18, 9, to_date('04-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (39, ' Smart TV', ' New', 499.99, 19, 1, to_date('04-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (40, ' Streaming Device', ' New', 79.99, 19, 3, to_date('06-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (41, ' Sound Bar', ' Refurbished', 149.99, 19, 16, to_date('06-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (42, ' Projector', ' New', 299.99, 19, 29, to_date('30-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (44, ' Wireless Router', ' New', 79.99, 19, 5, to_date('26-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (45, ' Smart Light Bulbs', ' Refurbished', 29.99, 19, 8, to_date('06-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (46, ' Smart Thermostat', ' New', 129.99, 19, 7, to_date('26-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (47, ' Security Camera', ' New', 79.99, 19, 6, to_date('01-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (49, ' Baby Monitor', ' New', 69.99, 19, 29, to_date('13-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (50, ' Smart Plug', ' New', 19.99, 19, 8, to_date('27-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (51, ' Smart Lock', ' Refurbished', 149.99, 19, 9, to_date('07-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (52, ' Indoor Plant', ' New', 39.99, 19, 9, to_date('19-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (54, ' Outdoor Grill', ' New', 299.99, 19, 5, to_date('26-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (55, ' Patio Furniture', ' Refurbished', 399.99, 19, 2, to_date('08-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (56, ' Hammock', ' New', 39.99, 19, 14, to_date('26-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (57, ' Fire Pit', ' New', 199.99, 19, 28, to_date('21-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (58, ' Lawn Mower', ' New', 249.99, 19, 1, to_date('15-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (60, ' Pressure Washer', ' New', 149.99, 19, 11, to_date('24-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (61, ' Tool Kit', ' New', 29.99, 19, 12, to_date('04-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (62, ' Cordless Drill', ' Refurbished', 79.99, 19, 6, to_date('12-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (63, ' Saw', ' New', 49.99, 19, 10, to_date('11-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (65, ' Safety Goggles', ' Refurbished', 9.99, 19, 20, to_date('26-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (66, ' Work Gloves', ' New', 14.99, 19, 13, to_date('28-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (67, ' Paint Sprayer', ' New', 69.99, 19, 12, to_date('30-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (69, ' Wrench Set', ' Refurbished', 19.99, 19, 14, to_date('13-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (70, ' Screwdriver Set', ' New', 14.99, 19, 28, to_date('24-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (71, ' Socket Set', ' New', 39.99, 19, 1, to_date('22-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (72, ' Measuring Tape', ' Refurbished', 9.99, 19, 14, to_date('11-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (74, ' Car Charger', ' Refurbished', 19.99, 19, 15, to_date('30-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (75, ' GPS Navigator', ' New', 99.99, 19, 8, to_date('19-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (76, ' Dash Cam', ' New', 59.99, 19, 9, to_date('15-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (78, ' Steering Wheel Cover', ' Refurbished', 14.99, 19, 22, to_date('16-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (79, ' Car Air Purifier', ' New', 39.99, 19, 15, to_date('25-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (80, ' Tire Pressure Gauge', ' Refurbished', 9.99, 19, 28, to_date('13-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (82, ' Toolbox', ' New', 49.99, 19, 23, to_date('20-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (83, ' Sunglasses', ' Refurbished', 19.99, 19, 20, to_date('22-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (84, ' Wristwatch', ' New', 39.99, 19, 3, to_date('14-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (85, ' Wallet', ' New', 29.99, 19, 28, to_date('06-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (87, ' Handbag', ' New', 24.99, 19, 8, to_date('01-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (88, ' Suitcase', ' New', 79.99, 19, 3, to_date('13-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (89, ' Travel Pillow', ' Refurbished', 14.99, 19, 28, to_date('15-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (91, ' Tripod', ' New', 49.99, 19, 7, to_date('28-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (92, ' Photo Printer', ' Refurbished', 149.99, 19, 21, to_date('07-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (93, ' Memory Card', ' New', 9.99, 19, 25, to_date('07-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (95, ' VR Headset', ' Refurbished', 299.99, 19, 1, to_date('07-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (96, ' Drone', ' New', 249.99, 19, 7, to_date('30-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (97, ' Action Camera', ' New', 199.99, 19, 12, to_date('26-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (98, ' 3D Printer', ' New', 399.99, 19, 11, to_date('01-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (100, ' Wireless Mouse', ' New', 29.99, 20, 22, to_date('18-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (101, ' Bluetooth Speaker', ' Refurbished', 99.99, 20, 5, to_date('19-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (102, ' Laptop Stand', ' New', 29.99, 20, 6, to_date('22-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (103, ' USB-C Hub', ' New', 39.99, 20, 16, to_date('16-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (104, ' Gaming Keyboard', ' Refurbished', 79.99, 20, 6, to_date('15-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (106, ' Portable Charger', ' New', 24.99, 20, 16, to_date('26-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (107, ' Smart Watch', ' New', 199.99, 20, 17, to_date('03-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (108, ' Digital Camera', ' Refurbished', 149.99, 20, 6, to_date('31-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (109, ' LED Desk Lamp', ' New', 34.99, 20, 27, to_date('09-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (110, ' External Hard Drive', ' New', 89.99, 20, 16, to_date('31-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (112, ' Fitness Tracker', ' New', 69.99, 20, 6, to_date('16-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (113, ' Wireless Earbuds', ' Refurbished', 59.99, 20, 23, to_date('31-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (114, ' Graphic Tablet', ' New', 129.99, 20, 13, to_date('20-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (115, ' Electric Kettle', ' New', 39.99, 20, 13, to_date('07-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (116, ' Coffee Maker', ' Refurbished', 49.99, 20, 11, to_date('09-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (118, ' Air Fryer', ' New', 99.99, 20, 18, to_date('07-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (119, ' Pressure Cooker', ' Refurbished', 89.99, 20, 1, to_date('17-10-2023', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (120, ' Robot Vacuum', ' New', 199.99, 20, 19, to_date('08-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (122, ' Hair Dryer', ' New', 29.99, 20, 18, to_date('26-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (123, ' Beard Trimmer', ' Refurbished', 34.99, 20, 11, to_date('08-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (124, ' Water Flosser', ' New', 39.99, 20, 10, to_date('19-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (125, ' Infrared Thermometer', ' Refurbished', 24.99, 20, 8, to_date('05-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (126, ' Blood Pressure Monitor', ' New', 59.99, 20, 2, to_date('28-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (128, ' Electric Shaver', ' Refurbished', 79.99, 20, 18, to_date('27-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (129, ' Massage Gun', ' New', 149.99, 20, 26, to_date('30-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (130, ' Yoga Mat', ' New', 24.99, 20, 3, to_date('15-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (131, ' Dumbbell Set', ' New', 69.99, 20, 1, to_date('30-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (133, ' Treadmill', ' New', 599.99, 20, 28, to_date('04-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (134, ' Exercise Bike', ' Refurbished', 249.99, 20, 1, to_date('10-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (135, ' Elliptical Machine', ' New', 499.99, 20, 5, to_date('27-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (136, ' Home Gym Set', ' New', 999.99, 20, 29, to_date('18-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (138, ' Foam Roller', ' New', 14.99, 20, 7, to_date('21-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (139, ' Smart TV', ' Refurbished', 399.99, 21, 9, to_date('14-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (140, ' Streaming Device', ' New', 49.99, 21, 26, to_date('12-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (141, ' Sound Bar', ' New', 199.99, 21, 5, to_date('25-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (143, ' Gaming Console', ' New', 399.99, 21, 8, to_date('28-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (144, ' Wireless Router', ' New', 79.99, 21, 22, to_date('14-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (145, ' Smart Light Bulbs', ' New', 29.99, 21, 21, to_date('11-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (146, ' Smart Thermostat', ' Refurbished', 129.99, 21, 19, to_date('01-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (148, ' Video Doorbell', ' New', 199.99, 21, 19, to_date('12-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (149, ' Baby Monitor', ' New', 69.99, 21, 28, to_date('18-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (150, ' Smart Plug', ' Refurbished', 19.99, 21, 2, to_date('22-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (151, ' Smart Lock', ' New', 149.99, 21, 25, to_date('07-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (153, ' Garden Tools Set', ' Refurbished', 49.99, 21, 29, to_date('26-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (154, ' Outdoor Grill', ' New', 299.99, 21, 6, to_date('02-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (155, ' Patio Furniture', ' New', 399.99, 21, 2, to_date('03-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (157, ' Fire Pit', ' New', 199.99, 21, 8, to_date('18-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (158, ' Lawn Mower', ' New', 249.99, 21, 6, to_date('22-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (159, ' Leaf Blower', ' Refurbished', 99.99, 21, 24, to_date('11-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (160, ' Pressure Washer', ' New', 149.99, 21, 19, to_date('21-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (162, ' Cordless Drill', ' Refurbished', 79.99, 21, 18, to_date('29-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (163, ' Saw', ' New', 49.99, 21, 9, to_date('27-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (164, ' Workbench', ' New', 99.99, 21, 25, to_date('11-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (166, ' Work Gloves', ' New', 14.99, 21, 17, to_date('31-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (167, ' Paint Sprayer', ' New', 69.99, 21, 5, to_date('02-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (168, ' Air Compressor', ' Refurbished', 149.99, 21, 3, to_date('12-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (169, ' Wrench Set', ' New', 19.99, 21, 20, to_date('10-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (171, ' Socket Set', ' Refurbished', 39.99, 21, 7, to_date('21-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (172, ' Measuring Tape', ' New', 9.99, 21, 28, to_date('31-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (173, ' Car Vacuum', ' New', 29.99, 21, 9, to_date('10-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (174, ' Car Charger', ' Refurbished', 19.99, 21, 8, to_date('13-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (176, ' Dash Cam', ' New', 59.99, 21, 11, to_date('30-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (177, ' Car Seat Cover', ' Refurbished', 49.99, 21, 8, to_date('26-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (178, ' Steering Wheel Cover', ' New', 14.99, 21, 13, to_date('19-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (180, ' Tire Pressure Gauge', ' Refurbished', 9.99, 21, 7, to_date('20-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (181, ' Jump Starter', ' New', 69.99, 21, 3, to_date('18-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (182, ' Toolbox', ' New', 49.99, 21, 16, to_date('13-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (183, ' Sunglasses', ' Refurbished', 19.99, 21, 21, to_date('08-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (185, ' Wallet', ' New', 29.99, 21, 8, to_date('16-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (186, ' Backpack', ' Refurbished', 49.99, 21, 2, to_date('01-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (187, ' Handbag', ' New', 24.99, 21, 15, to_date('19-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (189, ' Travel Pillow', ' Refurbished', 14.99, 21, 6, to_date('29-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (190, ' Camera Bag', ' New', 34.99, 21, 29, to_date('06-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (191, ' Tripod', ' New', 49.99, 21, 18, to_date('08-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (193, ' Memory Card', ' New', 9.99, 21, 24, to_date('19-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (194, ' Smartphone Gimbal', ' New', 79.99, 21, 17, to_date('10-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (195, ' VR Headset', ' Refurbished', 299.99, 21, 22, to_date('22-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (196, ' Drone', ' New', 249.99, 21, 21, to_date('30-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (197, ' Action Camera', ' New', 199.99, 21, 7, to_date('04-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (198, ' 3D Printer', ' Refurbished', 399.99, 21, 12, to_date('29-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (199, ' Electric Scooter', ' New', 299.99, 21, 24, to_date('24-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (200, ' Laptop Cooling Pad', ' Refurbished', 24.99, 1, 11, to_date('20-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (201, ' External SSD', ' New', 119.99, 11, 11, to_date('18-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (202, ' Inkjet Printer', ' Refurbished', 99.99, 2, 9, to_date('02-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (203, ' Ergonomic Mouse', ' New', 29.99, 1, 18, to_date('11-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (204, ' Mechanical Gaming Keyboard', ' New', 99.99, 5, 7, to_date('28-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (205, ' Gaming Chair', ' Refurbished', 199.99, 5, 10, to_date('01-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (206, ' Gaming Headset', ' New', 79.99, 6, 7, to_date('24-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (207, ' Wireless Earphones', ' Refurbished', 49.99, 6, 13, to_date('10-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (208, ' Smart Fitness Band', ' New', 49.99, 12, 8, to_date('20-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (209, ' Mirrorless Camera', ' New', 999.99, 9, 19, to_date('21-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (210, ' Desk Lamp', ' Refurbished', 14.99, 10, 1, to_date('04-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (211, ' Smart Light Strip', ' New', 24.99, 10, 19, to_date('08-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (212, ' Mesh WiFi System', ' New', 199.99, 4, 10, to_date('05-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (213, ' Ethernet Cable', ' Refurbished', 9.99, 4, 21, to_date('03-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (214, ' Gaming PC', ' New', 1499.99, 5, 15, to_date('18-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (215, ' AR Headset', ' New', 799.99, 28, 15, to_date('12-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (216, ' 3D Scanner', ' Refurbished', 499.99, 29, 26, to_date('23-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (217, ' Blood Glucose Monitor', ' New', 39.99, 17, 19, to_date('30-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (218, ' Beard Trimmer', ' New', 49.99, 12, 23, to_date('15-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (219, ' Pilates Mat', ' New', 19.99, 18, 2, to_date('31-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (220, ' Adjustable Dumbbells', ' Refurbished', 199.99, 18, 22, to_date('03-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (221, ' Rowing Machine', ' New', 799.99, 18, 16, to_date('06-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (222, ' Spin Bike', ' Refurbished', 399.99, 18, 22, to_date('09-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (223, ' Full Body Workout Machine', ' New', 1499.99, 18, 29, to_date('28-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (224, ' Jump Rope', ' New', 9.99, 18, 15, to_date('25-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (225, ' Massage Roller', ' Refurbished', 9.99, 18, 9, to_date('27-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (226, ' OLED Smart TV', ' New', 1299.99, 19, 28, to_date('12-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (227, ' 4K Streaming Device', ' Refurbished', 69.99, 19, 20, to_date('27-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (228, ' Dolby Atmos Sound Bar', ' New', 299.99, 19, 15, to_date('14-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (229, ' HD Projector', ' New', 499.99, 19, 20, to_date('09-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (230, ' Gaming PC', ' Refurbished', 999.99, 19, 6, to_date('11-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (231, ' Dual Band WiFi Router', ' New', 59.99, 19, 22, to_date('16-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (232, ' Smart LED Bulbs', ' Refurbished', 19.99, 19, 19, to_date('12-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (234, ' Indoor Security Camera', ' Refurbished', 59.99, 19, 17, to_date('09-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (235, ' Video Doorbell Pro', ' New', 299.99, 19, 13, to_date('16-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (236, ' Baby Monitor with Camera', ' New', 149.99, 19, 13, to_date('19-10-2023', 'dd-mm-yyyy'));
commit;
prompt 200 records committed...
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (237, ' Smart Plug Pack', ' Refurbished', 29.99, 19, 22, to_date('05-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (239, ' Indoor Plant Collection', ' New', 99.99, 19, 4, to_date('10-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (240, ' Gardening Tool Set', ' Refurbished', 29.99, 19, 27, to_date('03-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (241, ' Gas Grill', ' New', 399.99, 19, 3, to_date('04-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (242, ' Outdoor Dining Set', ' New', 699.99, 19, 4, to_date('26-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (243, ' Hammock Chair', ' Refurbished', 29.99, 19, 16, to_date('23-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (245, ' Robotic Lawn Mower', ' New', 999.99, 19, 14, to_date('20-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (246, ' Cordless Leaf Blower', ' Refurbished', 49.99, 19, 4, to_date('16-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (247, ' Electric Pressure Washer', ' New', 199.99, 19, 23, to_date('10-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (249, ' Power Drill Kit', ' Refurbished', 59.99, 19, 11, to_date('22-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (250, ' Circular Saw', ' New', 79.99, 19, 23, to_date('22-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (251, ' Garage Workbench', ' New', 149.99, 19, 14, to_date('02-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (252, ' Safety Glasses', ' Refurbished', 9.99, 19, 22, to_date('08-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (254, ' Airless Paint Sprayer', ' New', 199.99, 19, 24, to_date('19-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (255, ' Portable Air Compressor', ' Refurbished', 49.99, 19, 26, to_date('13-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (256, ' Ratchet Wrench Set', ' New', 29.99, 19, 19, to_date('13-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (257, ' Precision Screwdriver Set', ' New', 9.99, 19, 8, to_date('13-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (259, ' Laser Distance Measurer', ' New', 49.99, 19, 22, to_date('08-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (260, ' Car Vacuum Cleaner', ' New', 29.99, 19, 1, to_date('09-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (261, ' USB Car Charger', ' Refurbished', 9.99, 19, 12, to_date('04-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (262, ' GPS Navigation System', ' New', 149.99, 19, 5, to_date('22-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (263, ' Dual Dash Cam', ' New', 99.99, 19, 27, to_date('28-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (265, ' Steering Wheel Cover', ' Refurbished', 14.99, 19, 18, to_date('11-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (266, ' Car Air Purifier', ' New', 39.99, 19, 2, to_date('22-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (267, ' Digital Tire Pressure Gauge', ' Refurbished', 9.99, 19, 23, to_date('21-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (268, ' Portable Jump Starter', ' New', 69.99, 19, 14, to_date('05-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (270, ' Sunglasses', ' New', 19.99, 19, 19, to_date('19-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (271, ' Sports Watch', ' Refurbished', 29.99, 19, 23, to_date('25-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (272, ' Leather Wallet', ' New', 39.99, 19, 21, to_date('30-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (273, ' Travel Backpack', ' New', 49.99, 19, 27, to_date('08-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (275, ' Lightweight Suitcase', ' New', 79.99, 19, 20, to_date('02-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (276, ' Travel Pillow', ' New', 14.99, 19, 29, to_date('23-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (277, ' Camera Backpack', ' Refurbished', 34.99, 19, 26, to_date('24-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (278, ' Lightweight Tripod', ' New', 49.99, 19, 23, to_date('04-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (279, ' Portable Photo Printer', ' New', 149.99, 19, 29, to_date('11-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (281, ' Smartphone Stabilizer', ' New', 79.99, 19, 22, to_date('02-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (282, ' Virtual Reality Headset', ' New', 299.99, 19, 4, to_date('28-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (283, ' Camera Drone', ' Refurbished', 249.99, 19, 8, to_date('18-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (284, ' Action Camera', ' New', 199.99, 19, 25, to_date('09-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (285, ' 3D Printer Kit', ' Refurbished', 399.99, 19, 29, to_date('29-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (286, ' Electric Scooter', ' New', 299.99, 19, 18, to_date('27-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (288, ' Portable SSD', ' Refurbished', 99.99, 11, 29, to_date('01-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (289, ' Laser Printer', ' New', 149.99, 2, 25, to_date('13-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (290, ' Ergonomic Mouse', ' New', 29.99, 1, 5, to_date('24-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (291, ' Mechanical Gaming Keyboard', ' Refurbished', 89.99, 5, 13, to_date('27-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (293, ' Gaming Headset', ' New', 79.99, 6, 9, to_date('05-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (294, ' Wireless Earphones', ' New', 59.99, 6, 1, to_date('08-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (295, ' Smart Fitness Band', ' Refurbished', 29.99, 12, 8, to_date('09-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (296, ' Mirrorless Camera', ' New', 999.99, 9, 20, to_date('12-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (298, ' Smart Light Strip', ' Refurbished', 9.99, 10, 9, to_date('12-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (299, ' Mesh WiFi System', ' New', 149.99, 4, 11, to_date('02-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (300, ' Ethernet Cable', ' New', 9.99, 4, 4, to_date('20-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (302, ' AR Headset', ' Refurbished', 499.99, 28, 17, to_date('01-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (303, ' 3D Scanner', ' New', 299.99, 29, 6, to_date('13-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (304, ' Blood Glucose Monitor', ' New', 29.99, 17, 8, to_date('28-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (306, ' Pilates Mat', ' New', 14.99, 18, 5, to_date('01-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (307, ' Adjustable Dumbbells', ' New', 249.99, 18, 22, to_date('30-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (308, ' Rowing Machine', ' Refurbished', 699.99, 18, 1, to_date('26-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (309, ' Spin Bike', ' New', 349.99, 18, 17, to_date('19-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (311, ' Jump Rope', ' Refurbished', 9.99, 18, 9, to_date('29-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (312, ' Massage Roller', ' New', 9.99, 18, 29, to_date('14-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (313, ' OLED Smart TV', ' Refurbished', 999.99, 19, 12, to_date('02-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (314, ' 4K Streaming Device', ' New', 89.99, 19, 29, to_date('25-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (315, ' Dolby Atmos Sound Bar', ' New', 399.99, 19, 25, to_date('18-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (317, ' Gaming PC', ' New', 1999.99, 19, 22, to_date('17-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (318, ' Dual Band WiFi Router', ' Refurbished', 29.99, 19, 6, to_date('21-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (319, ' Smart LED Bulbs', ' New', 14.99, 19, 10, to_date('07-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (320, ' Nest Thermostat', ' Refurbished', 99.99, 19, 13, to_date('23-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (322, ' Video Doorbell Pro', ' New', 399.99, 19, 6, to_date('16-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (323, ' Baby Monitor with Camera', ' Refurbished', 149.99, 19, 18, to_date('11-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (324, ' Smart Plug Pack', ' New', 19.99, 19, 27, to_date('05-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (325, ' Fingerprint Smart Lock', ' New', 149.99, 19, 20, to_date('25-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (327, ' Gardening Tool Set', ' New', 19.99, 19, 11, to_date('08-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (328, ' Gas Grill', ' Refurbished', 199.99, 19, 3, to_date('21-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (329, ' Outdoor Dining Set', ' Refurbished', 399.99, 19, 26, to_date('30-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (330, ' Hammock Chair', ' New', 19.99, 19, 2, to_date('01-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (331, ' Fire Table', ' Refurbished', 299.99, 19, 4, to_date('11-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (333, ' Cordless Leaf Blower', ' New', 69.99, 19, 10, to_date('04-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (334, ' Electric Pressure Washer', ' New', 299.99, 19, 5, to_date('22-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (335, ' Basic Tool Set', ' New', 9.99, 19, 27, to_date('14-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (336, ' Power Drill Kit', ' New', 39.99, 19, 3, to_date('10-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (337, ' Circular Saw', ' New', 59.99, 19, 8, to_date('26-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (339, ' Safety Glasses', ' New', 4.99, 19, 26, to_date('05-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (340, ' Mechanic Gloves', ' New', 9.99, 19, 17, to_date('17-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (341, ' Airless Paint Sprayer', ' Refurbished', 149.99, 19, 13, to_date('16-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (342, ' Portable Air Compressor', ' New', 39.99, 19, 17, to_date('20-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (343, ' Ratchet Wrench Set', ' New', 19.99, 19, 28, to_date('12-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (345, ' Socket and Wrench Set', ' New', 29.99, 19, 5, to_date('18-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (346, ' Laser Distance Measurer', ' Refurbished', 39.99, 19, 8, to_date('13-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (347, ' Car Vacuum Cleaner', ' Refurbished', 19.99, 19, 16, to_date('07-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (348, ' USB Car Charger', ' New', 9.99, 19, 2, to_date('22-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (349, ' GPS Navigation System', ' New', 79.99, 19, 7, to_date('26-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (350, ' Dual Dash Cam', ' New', 49.99, 19, 18, to_date('14-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (352, ' Steering Wheel Cover', ' New', 9.99, 19, 12, to_date('28-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (353, ' Car Air Purifier', ' New', 29.99, 19, 15, to_date('25-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (354, ' Digital Tire Pressure Gauge', ' New', 9.99, 19, 28, to_date('11-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (355, ' Portable Jump Starter', ' Refurbished', 49.99, 19, 2, to_date('21-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (356, ' Tool Chest', ' New', 99.99, 19, 13, to_date('25-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (358, ' Sports Watch', ' New', 19.99, 19, 17, to_date('23-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (359, ' Leather Wallet', ' Refurbished', 19.99, 19, 11, to_date('18-01-2023', 'dd-mm-yyyy'));
commit;
prompt 300 records committed...
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (360, ' Travel Backpack', ' New', 19.99, 19, 7, to_date('07-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (361, ' Business Handbag', ' New', 9.99, 19, 6, to_date('01-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (363, ' Travel Pillow', ' New', 4.99, 19, 19, to_date('20-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (364, ' Camera Backpack', ' New', 19.99, 19, 26, to_date('22-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (365, ' Lightweight Tripod', ' New', 29.99, 19, 29, to_date('12-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (366, ' Portable Photo Printer', ' New', 99.99, 19, 6, to_date('09-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (367, ' High-Speed Memory Card', ' New', 4.99, 19, 2, to_date('21-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (368, ' Smartphone Stabilizer', ' Refurbished', 59.99, 19, 19, to_date('26-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (369, ' Virtual Reality Headset', ' New', 199.99, 19, 1, to_date('10-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (370, ' Camera Drone', ' New', 199.99, 19, 21, to_date('21-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (371, ' Action Camera', ' Refurbished', 149.99, 19, 28, to_date('15-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (372, ' 3D Printer Kit', ' New', 299.99, 19, 6, to_date('01-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (373, ' Electric Scooter', ' Refurbished', 199.99, 19, 22, to_date('07-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (374, ' Laptop Cooling Pad', ' New', 19.99, 1, 9, to_date('17-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (375, ' Portable SSD', ' Refurbished', 79.99, 11, 19, to_date('03-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (376, ' Laser Printer', ' New', 199.99, 2, 11, to_date('29-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (377, ' Ergonomic Mouse', ' Refurbished', 14.99, 1, 14, to_date('25-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (378, ' Mechanical Gaming Keyboard', ' New', 129.99, 5, 4, to_date('13-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (379, ' Gaming Chair', ' New', 249.99, 5, 29, to_date('26-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (380, ' Gaming Headset', ' Refurbished', 39.99, 6, 26, to_date('19-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (381, ' Wireless Earphones', ' New', 69.99, 6, 19, to_date('16-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (382, ' Smart Fitness Band', ' New', 79.99, 12, 14, to_date('09-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (383, ' Mirrorless Camera', ' Refurbished', 699.99, 9, 14, to_date('18-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (384, ' Desk Lamp', ' New', 29.99, 10, 11, to_date('23-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (385, ' Smart Light Strip', ' New', 19.99, 10, 1, to_date('11-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (386, ' Mesh WiFi System', ' Refurbished', 99.99, 4, 5, to_date('29-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (387, ' Ethernet Cable', ' New', 14.99, 4, 2, to_date('21-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (388, ' Gaming PC', ' New', 1799.99, 5, 27, to_date('02-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (389, ' AR Headset', ' New', 999.99, 28, 21, to_date('12-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (390, ' 3D Scanner', ' New', 399.99, 29, 8, to_date('01-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (391, ' Blood Glucose Monitor', ' Refurbished', 19.99, 17, 9, to_date('16-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (392, ' Beard Trimmer', ' New', 29.99, 12, 14, to_date('26-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (393, ' Pilates Mat', ' New', 24.99, 18, 26, to_date('19-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (394, ' Adjustable Dumbbells', ' New', 299.99, 18, 15, to_date('22-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (395, ' Rowing Machine', ' New', 899.99, 18, 13, to_date('07-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (396, ' Spin Bike', ' New', 499.99, 18, 13, to_date('26-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (397, ' Full Body Workout Machine', ' Refurbished', 999.99, 18, 22, to_date('28-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (398, ' Jump Rope', ' New', 14.99, 18, 1, to_date('02-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (399, ' Massage Roller', ' Refurbished', 14.99, 18, 26, to_date('08-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (400, ' OLED Smart TV', ' New', 1499.99, 19, 5, to_date('25-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (401, ' 4K Streaming Device', ' Refurbished', 79.99, 19, 29, to_date('31-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (402, ' Dolby Atmos Sound Bar', ' New', 499.99, 19, 15, to_date('18-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (403, ' HD Projector', ' Refurbished', 399.99, 19, 8, to_date('22-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (404, ' Gaming PC', ' New', 2499.99, 19, 28, to_date('01-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (405, ' Dual Band WiFi Router', ' New', 39.99, 19, 27, to_date('30-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (406, ' Smart LED Bulbs', ' New', 9.99, 19, 21, to_date('04-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (407, ' Nest Thermostat', ' New', 149.99, 19, 22, to_date('26-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (408, ' Indoor Security Camera', ' New', 39.99, 19, 29, to_date('19-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (409, ' Video Doorbell Pro', ' Refurbished', 199.99, 19, 3, to_date('21-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (410, ' Baby Monitor with Camera', ' New', 99.99, 19, 1, to_date('16-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (411, ' Smart Plug Pack', ' New', 9.99, 19, 10, to_date('13-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (412, ' Fingerprint Smart Lock', ' New', 99.99, 19, 7, to_date('14-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (413, ' Indoor Plant Collection', ' Refurbished', 49.99, 19, 1, to_date('29-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (414, ' Gardening Tool Set', ' New', 9.99, 19, 25, to_date('05-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (415, ' Gas Grill', ' New', 499.99, 19, 18, to_date('28-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (416, ' Outdoor Dining Set', ' New', 899.99, 19, 6, to_date('08-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (417, ' Hammock Chair', ' New', 39.99, 19, 1, to_date('04-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (418, ' Fire Table', ' New', 599.99, 19, 20, to_date('08-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (419, ' Robotic Lawn Mower', ' New', 1299.99, 19, 23, to_date('24-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (420, ' Cordless Leaf Blower', ' New', 99.99, 19, 21, to_date('22-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (421, ' Electric Pressure Washer', ' Refurbished', 149.99, 19, 14, to_date('10-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (422, ' Basic Tool Set', ' Refurbished', 14.99, 19, 11, to_date('03-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (423, ' Power Drill Kit', ' New', 49.99, 19, 4, to_date('18-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (424, ' Circular Saw', ' Refurbished', 39.99, 19, 27, to_date('26-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (425, ' Garage Workbench', ' New', 199.99, 19, 7, to_date('12-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (426, ' Safety Glasses', ' New', 9.99, 19, 12, to_date('19-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (427, ' Mechanic Gloves', ' Refurbished', 4.99, 19, 19, to_date('26-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (428, ' Airless Paint Sprayer', ' New', 249.99, 19, 15, to_date('03-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (429, ' Portable Air Compressor', ' New', 59.99, 19, 10, to_date('17-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (430, ' Ratchet Wrench Set', ' Refurbished', 9.99, 19, 15, to_date('10-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (431, ' Precision Screwdriver Set', ' New', 14.99, 19, 16, to_date('22-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (432, ' Socket and Wrench Set', ' New', 19.99, 19, 14, to_date('24-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (433, ' Laser Distance Measurer', ' New', 69.99, 19, 19, to_date('31-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (434, ' Car Vacuum Cleaner', ' New', 39.99, 19, 7, to_date('16-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (435, ' USB Car Charger', ' New', 4.99, 19, 25, to_date('19-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (436, ' GPS Navigation System', ' Refurbished', 49.99, 19, 16, to_date('13-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (437, ' Dual Dash Cam', ' Refurbished', 29.99, 19, 6, to_date('11-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (438, ' Car Seat Cover Set', ' New', 39.99, 19, 7, to_date('12-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (439, ' Steering Wheel Cover', ' New', 4.99, 19, 11, to_date('09-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (440, ' Car Air Purifier', ' Refurbished', 19.99, 19, 3, to_date('31-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (441, ' Digital Tire Pressure Gauge', ' New', 4.99, 19, 5, to_date('13-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (442, ' Portable Jump Starter', ' New', 39.99, 19, 11, to_date('01-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (443, ' Tool Chest', ' New', 129.99, 19, 4, to_date('18-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (444, ' Sunglasses', ' Refurbished', 9.99, 19, 21, to_date('09-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (445, ' Sports Watch', ' New', 9.99, 19, 3, to_date('05-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (446, ' Leather Wallet', ' New', 14.99, 19, 27, to_date('12-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (447, ' Travel Backpack', ' Refurbished', 9.99, 19, 19, to_date('02-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (448, ' Business Handbag', ' New', 19.99, 19, 27, to_date('23-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (449, ' Lightweight Suitcase', ' New', 59.99, 19, 6, to_date('27-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (450, ' Travel Pillow', ' Refurbished', 9.99, 19, 7, to_date('28-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (451, ' Camera Backpack', ' New', 9.99, 19, 5, to_date('14-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (452, ' Lightweight Tripod', ' Refurbished', 19.99, 19, 7, to_date('04-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (453, ' Portable Photo Printer', ' New', 79.99, 19, 12, to_date('04-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (454, ' High-Speed Memory Card', ' New', 9.99, 19, 29, to_date('25-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (455, ' Smartphone Stabilizer', ' New', 49.99, 19, 3, to_date('19-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (456, ' Virtual Reality Headset', ' Refurbished', 149.99, 19, 7, to_date('11-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (457, ' Camera Drone', ' New', 249.99, 19, 27, to_date('05-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (458, ' Action Camera', ' New', 99.99, 19, 26, to_date('16-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (459, ' 3D Printer Kit', ' New', 399.99, 19, 13, to_date('03-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (460, ' Electric Scooter', ' New', 199.99, 19, 7, to_date('16-05-2023', 'dd-mm-yyyy'));
commit;
prompt 400 records committed...
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (461, ' Laptop Cooling Pad', ' Refurbished', 14.99, 1, 7, to_date('11-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (462, ' Portable SSD', ' New', 129.99, 11, 8, to_date('16-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (463, ' Laser Printer', ' Refurbished', 79.99, 2, 13, to_date('11-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (464, ' Ergonomic Mouse', ' Refurbished', 9.99, 1, 21, to_date('21-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (465, ' Mechanical Gaming Keyboard', ' New', 79.99, 5, 7, to_date('29-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (466, ' Gaming Chair', ' New', 149.99, 5, 5, to_date('29-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (467, ' Gaming Headset', ' New', 49.99, 6, 23, to_date('28-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (468, ' Wireless Earphones', ' New', 39.99, 6, 6, to_date('09-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (469, ' Smart Fitness Band', ' New', 69.99, 12, 2, to_date('16-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (470, ' Mirrorless Camera', ' Refurbished', 599.99, 9, 28, to_date('06-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (471, ' Desk Lamp', ' New', 9.99, 10, 9, to_date('08-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (472, ' Smart Light Strip', ' New', 14.99, 10, 6, to_date('13-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (473, ' Mesh WiFi System', ' New', 99.99, 4, 2, to_date('06-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (474, ' Ethernet Cable', ' New', 9.99, 4, 27, to_date('08-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (476, ' AR Headset', ' New', 699.99, 28, 17, to_date('13-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (477, ' 3D Scanner', ' New', 399.99, 29, 8, to_date('14-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (478, ' Blood Glucose Monitor', ' New', 29.99, 17, 23, to_date('20-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (480, ' Pilates Mat', ' New', 14.99, 18, 13, to_date('08-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (481, ' Adjustable Dumbbells', ' New', 199.99, 18, 19, to_date('15-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (482, ' Rowing Machine', ' New', 599.99, 18, 23, to_date('09-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (483, ' Spin Bike', ' Refurbished', 299.99, 18, 21, to_date('06-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (484, ' Full Body Workout Machine', ' New', 999.99, 18, 21, to_date('18-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (486, ' Massage Roller', ' Refurbished', 14.99, 18, 18, to_date('12-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (487, ' OLED Smart TV', ' Refurbished', 999.99, 19, 20, to_date('04-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (488, ' 4K Streaming Device', ' New', 89.99, 19, 16, to_date('05-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (490, ' HD Projector', ' New', 699.99, 19, 8, to_date('18-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (491, ' Gaming PC', ' Refurbished', 1999.99, 19, 23, to_date('26-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (492, ' Dual Band WiFi Router', ' Refurbished', 29.99, 19, 12, to_date('21-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (493, ' Smart LED Bulbs', ' New', 14.99, 19, 14, to_date('27-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (30, ' Yoga Mat', ' New', 24.99, 18, 24, to_date('13-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (34, ' Exercise Bike', ' New', 299.99, 18, 28, to_date('03-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (38, ' Foam Roller', ' Refurbished', 14.99, 18, 19, to_date('26-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (43, ' Gaming Console', ' New', 399.99, 19, 29, to_date('04-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (48, ' Video Doorbell', ' Refurbished', 199.99, 19, 2, to_date('08-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (53, ' Garden Tools Set', ' Refurbished', 49.99, 19, 8, to_date('21-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (59, ' Leaf Blower', ' Refurbished', 99.99, 19, 23, to_date('30-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (64, ' Workbench', ' New', 99.99, 19, 28, to_date('05-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (68, ' Air Compressor', ' New', 149.99, 19, 20, to_date('02-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (73, ' Car Vacuum', ' New', 29.99, 19, 6, to_date('03-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (77, ' Car Seat Cover', ' New', 49.99, 19, 28, to_date('12-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (81, ' Jump Starter', ' New', 69.99, 19, 7, to_date('26-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (86, ' Backpack', ' Refurbished', 49.99, 19, 18, to_date('26-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (90, ' Camera Bag', ' New', 34.99, 19, 8, to_date('24-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (94, ' Smartphone Gimbal', ' New', 79.99, 19, 10, to_date('12-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (99, ' Electric Scooter', ' Refurbished', 299.99, 19, 24, to_date('28-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (105, ' Noise Cancelling Headphones', ' New', 129.99, 20, 22, to_date('23-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (111, ' Smartphone Case', ' Refurbished', 14.99, 20, 12, to_date('07-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (117, ' Blender', ' New', 59.99, 20, 24, to_date('06-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (121, ' Electric Toothbrush', ' Refurbished', 39.99, 20, 20, to_date('19-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (127, ' Pulse Oximeter', ' New', 49.99, 20, 20, to_date('07-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (132, ' Resistance Bands', ' New', 19.99, 20, 3, to_date('30-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (137, ' Jump Rope', ' Refurbished', 9.99, 20, 9, to_date('11-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (142, ' Projector', ' Refurbished', 299.99, 21, 20, to_date('04-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (147, ' Security Camera', ' New', 79.99, 21, 2, to_date('15-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (152, ' Indoor Plant', ' New', 39.99, 21, 3, to_date('12-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (156, ' Hammock', ' Refurbished', 39.99, 21, 13, to_date('20-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (161, ' Tool Kit', ' New', 29.99, 21, 18, to_date('08-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (165, ' Safety Goggles', ' Refurbished', 9.99, 21, 17, to_date('07-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (170, ' Screwdriver Set', ' New', 14.99, 21, 21, to_date('18-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (175, ' GPS Navigator', ' New', 99.99, 21, 11, to_date('21-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (179, ' Car Air Purifier', ' New', 39.99, 21, 29, to_date('31-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (184, ' Wristwatch', ' New', 39.99, 21, 26, to_date('22-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (188, ' Suitcase', ' New', 79.99, 21, 6, to_date('21-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (192, ' Photo Printer', ' Refurbished', 149.99, 21, 27, to_date('18-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (233, ' Nest Thermostat', ' New', 179.99, 19, 22, to_date('20-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (238, ' Fingerprint Smart Lock', ' New', 199.99, 19, 4, to_date('17-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (244, ' Fire Table', ' New', 499.99, 19, 27, to_date('30-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (248, ' Basic Tool Set', ' New', 19.99, 19, 14, to_date('17-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (253, ' Mechanic Gloves', ' New', 14.99, 19, 5, to_date('05-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (258, ' Socket and Wrench Set', ' Refurbished', 39.99, 19, 8, to_date('07-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (264, ' Car Seat Cover Set', ' New', 59.99, 19, 11, to_date('07-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (269, ' Tool Chest', ' Refurbished', 149.99, 19, 19, to_date('31-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (274, ' Business Handbag', ' Refurbished', 24.99, 19, 17, to_date('21-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (280, ' High-Speed Memory Card', ' Refurbished', 9.99, 19, 19, to_date('17-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (287, ' Laptop Cooling Pad', ' New', 24.99, 1, 9, to_date('24-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (292, ' Gaming Chair', ' New', 199.99, 5, 5, to_date('06-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (297, ' Desk Lamp', ' New', 19.99, 10, 6, to_date('17-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (301, ' Gaming PC', ' New', 1299.99, 5, 22, to_date('03-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (305, ' Beard Trimmer', ' Refurbished', 39.99, 12, 11, to_date('09-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (310, ' Full Body Workout Machine', ' New', 1299.99, 18, 25, to_date('21-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (316, ' HD Projector', ' New', 699.99, 19, 12, to_date('01-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (321, ' Indoor Security Camera', ' New', 49.99, 19, 6, to_date('15-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (326, ' Indoor Plant Collection', ' New', 59.99, 19, 2, to_date('03-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (332, ' Robotic Lawn Mower', ' Refurbished', 499.99, 19, 18, to_date('24-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (338, ' Garage Workbench', ' Refurbished', 99.99, 19, 1, to_date('16-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (344, ' Precision Screwdriver Set', ' Refurbished', 4.99, 19, 7, to_date('14-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (351, ' Car Seat Cover Set', ' Refurbished', 29.99, 19, 3, to_date('02-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (357, ' Sunglasses', ' New', 9.99, 19, 18, to_date('03-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (362, ' Lightweight Suitcase', ' Refurbished', 49.99, 19, 26, to_date('06-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (475, ' Gaming PC', ' New', 1599.99, 5, 13, to_date('30-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (479, ' Beard Trimmer', ' Refurbished', 29.99, 12, 24, to_date('18-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (485, ' Jump Rope', ' New', 9.99, 18, 14, to_date('03-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (489, ' Dolby Atmos Sound Bar', ' New', 399.99, 19, 3, to_date('29-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, status, price, category_id, stock, available_date)
values (494, ' Nest Thermostat', ' Refurbished', 99.99, 19, 23, to_date('18-08-2023', 'dd-mm-yyyy'));
commit;
prompt 494 records loaded
prompt Loading REVIEWS...
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (1, 8.9, 'Fantastic buy', to_date('26-12-2023', 'dd-mm-yyyy'), 127, 10301);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (2, 8.9, 'Exceeded expectations', to_date('19-04-2024', 'dd-mm-yyyy'), 171, 10542);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (3, 9.9, 'Good value', to_date('15-02-2024', 'dd-mm-yyyy'), 486, 10185);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (4, 8.8, 'Fantastic buy', to_date('21-05-2023', 'dd-mm-yyyy'), 470, 10683);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (5, 1.9, 'Exceeded expectations', to_date('16-11-2023', 'dd-mm-yyyy'), 171, 10288);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (6, 8.7, 'Good value', to_date('18-11-2023', 'dd-mm-yyyy'), 278, 10584);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (7, 5.2, 'Will return', to_date('12-07-2024', 'dd-mm-yyyy'), 413, 10623);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (8, 6, 'Amazing service', to_date('25-09-2024', 'dd-mm-yyyy'), 422, 10530);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (9, 4.2, 'Excellent quality', to_date('28-11-2024', 'dd-mm-yyyy'), 114, 10411);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (10, 7.5, 'Value for money', to_date('29-08-2024', 'dd-mm-yyyy'), 97, 10282);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (11, 3.7, 'Excellent service', to_date('26-05-2023', 'dd-mm-yyyy'), 41, 10005);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (12, 3.2, 'Returned it', to_date('30-05-2023', 'dd-mm-yyyy'), 198, 10059);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (13, 5.7, 'Superb performance', to_date('22-11-2024', 'dd-mm-yyyy'), 302, 10074);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (14, 9.9, 'Excellent quality', to_date('17-01-2024', 'dd-mm-yyyy'), 62, 10308);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (15, 8.1, 'Terrible purchase', to_date('20-06-2023', 'dd-mm-yyyy'), 289, 10591);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (16, 4.7, 'Very useful', to_date('13-03-2023', 'dd-mm-yyyy'), 419, 10691);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (17, 2.7, 'Amazing service', to_date('18-03-2023', 'dd-mm-yyyy'), 135, 10199);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (18, 8.7, 'Too expensive', to_date('20-03-2023', 'dd-mm-yyyy'), 256, 10449);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (19, 5.1, 'Top-notch item', to_date('10-02-2024', 'dd-mm-yyyy'), 281, 10151);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (20, 4.1, 'Value for money', to_date('09-09-2023', 'dd-mm-yyyy'), 462, 10477);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (21, 8.5, 'Great features', to_date('29-07-2024', 'dd-mm-yyyy'), 23, 10180);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (22, 7.1, 'Top-notch item', to_date('20-11-2023', 'dd-mm-yyyy'), 91, 10291);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (23, 9.4, 'Great design', to_date('27-01-2023', 'dd-mm-yyyy'), 64, 10689);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (24, 1.8, 'Will return', to_date('23-10-2024', 'dd-mm-yyyy'), 64, 10372);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (25, 1.3, 'Would recommend', to_date('21-12-2023', 'dd-mm-yyyy'), 419, 10445);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (26, 5.3, 'Love this item', to_date('08-04-2023', 'dd-mm-yyyy'), 210, 10234);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (27, 2, 'Low quality', to_date('26-08-2024', 'dd-mm-yyyy'), 428, 10148);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (28, 9, 'Not worth it', to_date('24-06-2023', 'dd-mm-yyyy'), 99, 10355);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (29, 2.7, 'Cheap but good', to_date('27-11-2023', 'dd-mm-yyyy'), 250, 10071);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (30, 1.2, 'Will return', to_date('19-09-2023', 'dd-mm-yyyy'), 274, 10626);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (31, 9.1, 'Low quality', to_date('08-03-2023', 'dd-mm-yyyy'), 389, 10379);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (32, 8.7, 'Great product!', to_date('25-01-2023', 'dd-mm-yyyy'), 415, 10082);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (33, 6.7, 'Amazing service', to_date('01-02-2024', 'dd-mm-yyyy'), 307, 10065);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (34, 5.8, 'Terrible purchase', to_date('25-12-2023', 'dd-mm-yyyy'), 246, 10515);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (35, 3.5, 'Superb performance', to_date('24-02-2023', 'dd-mm-yyyy'), 392, 10436);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (36, 7, 'Great features', to_date('20-12-2024', 'dd-mm-yyyy'), 237, 10023);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (37, 2.9, 'Works perfectly', to_date('26-01-2024', 'dd-mm-yyyy'), 450, 10021);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (38, 9.5, 'Fast delivery', to_date('01-08-2023', 'dd-mm-yyyy'), 79, 10444);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (39, 2.3, 'Subpar quality', to_date('24-10-2023', 'dd-mm-yyyy'), 194, 10420);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (40, 8.2, 'Too expensive', to_date('22-11-2023', 'dd-mm-yyyy'), 247, 10652);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (41, 8.8, 'Not worth it', to_date('17-01-2024', 'dd-mm-yyyy'), 402, 10503);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (42, 2, 'Works perfectly', to_date('03-04-2024', 'dd-mm-yyyy'), 229, 10633);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (43, 3.8, 'Great product!', to_date('19-08-2024', 'dd-mm-yyyy'), 242, 10691);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (44, 5.9, 'Fantastic buy', to_date('08-03-2023', 'dd-mm-yyyy'), 222, 10167);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (45, 8.8, 'Five stars', to_date('11-04-2023', 'dd-mm-yyyy'), 150, 10623);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (46, 7.5, 'Very satisfied', to_date('04-12-2024', 'dd-mm-yyyy'), 123, 10048);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (47, 8.1, 'Great product!', to_date('22-05-2024', 'dd-mm-yyyy'), 175, 10327);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (48, 7.3, 'Love this item', to_date('04-11-2024', 'dd-mm-yyyy'), 22, 10561);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (49, 6.2, 'Returned it', to_date('01-05-2024', 'dd-mm-yyyy'), 85, 10013);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (50, 6, 'Disappointed', to_date('19-03-2023', 'dd-mm-yyyy'), 218, 10626);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (51, 8.8, 'Not worth it', to_date('28-04-2023', 'dd-mm-yyyy'), 71, 10283);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (52, 8.4, 'Superb performance', to_date('30-06-2023', 'dd-mm-yyyy'), 489, 10491);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (53, 9.5, 'Just okay', to_date('18-09-2023', 'dd-mm-yyyy'), 118, 10597);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (54, 3.8, 'High quality', to_date('25-11-2024', 'dd-mm-yyyy'), 82, 10114);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (55, 9.5, 'Low quality', to_date('07-02-2024', 'dd-mm-yyyy'), 276, 10089);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (56, 3.7, 'Not worth it', to_date('20-12-2023', 'dd-mm-yyyy'), 458, 10485);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (57, 2.3, 'Value for money', to_date('03-12-2023', 'dd-mm-yyyy'), 126, 10236);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (58, 5.1, 'Fast shipping', to_date('05-05-2023', 'dd-mm-yyyy'), 364, 10545);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (59, 9.9, 'Terrible purchase', to_date('21-01-2024', 'dd-mm-yyyy'), 267, 10190);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (60, 8.2, 'Returned it', to_date('17-10-2024', 'dd-mm-yyyy'), 32, 10006);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (61, 1.5, 'Good value', to_date('13-08-2024', 'dd-mm-yyyy'), 224, 10584);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (62, 5.1, 'Fantastic buy', to_date('24-04-2023', 'dd-mm-yyyy'), 335, 10058);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (63, 1.3, 'Highly recommend', to_date('20-05-2023', 'dd-mm-yyyy'), 31, 10517);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (64, 7.7, 'Will return', to_date('03-04-2024', 'dd-mm-yyyy'), 135, 10362);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (65, 5.4, 'Not worth it', to_date('01-12-2024', 'dd-mm-yyyy'), 4, 10574);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (66, 5.4, 'Returned it', to_date('19-03-2024', 'dd-mm-yyyy'), 105, 10330);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (67, 3.1, 'Low quality', to_date('28-10-2024', 'dd-mm-yyyy'), 209, 10043);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (68, 7.8, 'Not impressed', to_date('04-04-2024', 'dd-mm-yyyy'), 336, 10324);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (69, 3.4, 'Five stars', to_date('21-06-2023', 'dd-mm-yyyy'), 428, 10344);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (70, 6.9, 'Highly recommend', to_date('01-03-2024', 'dd-mm-yyyy'), 434, 10477);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (71, 3, 'Not worth it', to_date('07-07-2024', 'dd-mm-yyyy'), 302, 10148);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (72, 5.5, 'Well made', to_date('24-09-2023', 'dd-mm-yyyy'), 57, 10184);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (73, 7.5, 'Five stars', to_date('01-05-2023', 'dd-mm-yyyy'), 340, 10652);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (74, 9.9, 'Great features', to_date('16-11-2024', 'dd-mm-yyyy'), 105, 10255);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (75, 9.1, 'Not impressed', to_date('14-06-2024', 'dd-mm-yyyy'), 321, 10125);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (76, 2.5, 'Impressed', to_date('03-10-2023', 'dd-mm-yyyy'), 431, 10086);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (77, 2.5, 'Five stars', to_date('02-05-2023', 'dd-mm-yyyy'), 444, 10542);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (78, 9.6, 'Impressed', to_date('09-11-2023', 'dd-mm-yyyy'), 320, 10550);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (79, 8.8, 'Not as expected', to_date('13-05-2023', 'dd-mm-yyyy'), 475, 10581);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (80, 5.4, 'Value for money', to_date('03-03-2023', 'dd-mm-yyyy'), 332, 10296);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (81, 3.5, 'Great product!', to_date('12-12-2023', 'dd-mm-yyyy'), 32, 10378);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (82, 4.2, 'Fantastic buy', to_date('02-11-2024', 'dd-mm-yyyy'), 31, 10547);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (83, 2.8, 'Fast shipping', to_date('14-05-2023', 'dd-mm-yyyy'), 93, 10610);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (84, 3.5, 'Low quality', to_date('11-11-2023', 'dd-mm-yyyy'), 388, 10095);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (85, 6.8, 'Decent purchase', to_date('15-04-2024', 'dd-mm-yyyy'), 43, 10028);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (86, 5.4, 'Highly recommend', to_date('23-12-2023', 'dd-mm-yyyy'), 328, 10219);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (87, 1.7, 'Happy customer', to_date('22-03-2024', 'dd-mm-yyyy'), 10, 10665);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (88, 5.9, 'Will return', to_date('09-06-2023', 'dd-mm-yyyy'), 346, 10522);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (89, 7.4, 'Great product!', to_date('06-05-2023', 'dd-mm-yyyy'), 472, 10396);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (90, 3.9, 'Exceeded expectations', to_date('12-09-2023', 'dd-mm-yyyy'), 51, 10170);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (91, 7.1, 'Great design', to_date('18-07-2023', 'dd-mm-yyyy'), 451, 10138);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (92, 9.8, 'Superb performance', to_date('15-07-2023', 'dd-mm-yyyy'), 396, 10280);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (93, 2.1, 'Value for money', to_date('05-01-2023', 'dd-mm-yyyy'), 12, 10511);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (94, 8.9, 'Superb performance', to_date('01-10-2024', 'dd-mm-yyyy'), 494, 10129);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (95, 3.8, 'Will return', to_date('24-10-2023', 'dd-mm-yyyy'), 397, 10527);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (96, 2.8, 'Decent purchase', to_date('16-06-2024', 'dd-mm-yyyy'), 450, 10208);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (97, 9.7, 'Just okay', to_date('15-01-2023', 'dd-mm-yyyy'), 35, 10131);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (98, 10, 'Very useful', to_date('18-05-2023', 'dd-mm-yyyy'), 160, 10375);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (99, 5.8, 'Well made', to_date('12-07-2023', 'dd-mm-yyyy'), 96, 10051);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (100, 10, 'Will buy again', to_date('18-05-2023', 'dd-mm-yyyy'), 360, 10366);
commit;
prompt 100 records committed...
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (101, 4.9, 'Very satisfied', to_date('24-06-2024', 'dd-mm-yyyy'), 298, 10427);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (102, 4.8, 'Low quality', to_date('02-02-2023', 'dd-mm-yyyy'), 130, 10042);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (103, 1, 'Would recommend', to_date('13-05-2024', 'dd-mm-yyyy'), 92, 10047);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (104, 7.8, 'Low quality', to_date('19-10-2023', 'dd-mm-yyyy'), 217, 10583);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (105, 2.9, 'Good value', to_date('25-09-2024', 'dd-mm-yyyy'), 79, 10433);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (106, 7, 'Terrible purchase', to_date('05-01-2023', 'dd-mm-yyyy'), 264, 10427);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (107, 1.5, 'Great design', to_date('13-08-2024', 'dd-mm-yyyy'), 169, 10255);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (108, 4.4, 'Cheap but good', to_date('15-07-2024', 'dd-mm-yyyy'), 34, 10077);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (109, 2.4, 'Works perfectly', to_date('15-10-2023', 'dd-mm-yyyy'), 287, 10403);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (110, 2.3, 'Amazing service', to_date('12-04-2023', 'dd-mm-yyyy'), 148, 10618);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (111, 4.2, 'Returned it', to_date('14-11-2023', 'dd-mm-yyyy'), 242, 10173);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (112, 7.5, 'Great product!', to_date('19-11-2024', 'dd-mm-yyyy'), 187, 10338);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (113, 4.1, 'Not impressed', to_date('19-09-2023', 'dd-mm-yyyy'), 241, 10303);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (114, 6, 'Fantastic buy', to_date('05-06-2024', 'dd-mm-yyyy'), 49, 10193);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (115, 2.6, 'Impressed', to_date('22-02-2024', 'dd-mm-yyyy'), 405, 10039);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (116, 3.6, 'Five stars', to_date('28-03-2023', 'dd-mm-yyyy'), 159, 10242);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (117, 6.5, 'Very satisfied', to_date('04-02-2024', 'dd-mm-yyyy'), 224, 10011);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (118, 6.2, 'Great product!', to_date('13-04-2024', 'dd-mm-yyyy'), 236, 10168);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (119, 1.7, 'Not as expected', to_date('05-06-2023', 'dd-mm-yyyy'), 430, 10080);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (120, 5.7, 'Too expensive', to_date('04-11-2024', 'dd-mm-yyyy'), 192, 10524);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (121, 9.3, 'Five stars', to_date('09-05-2024', 'dd-mm-yyyy'), 299, 10329);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (122, 2.9, 'Value for money', to_date('10-04-2024', 'dd-mm-yyyy'), 122, 10501);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (123, 1.1, 'Very useful', to_date('24-11-2023', 'dd-mm-yyyy'), 147, 10326);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (124, 2.7, 'Would recommend', to_date('09-12-2024', 'dd-mm-yyyy'), 185, 10636);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (125, 4.5, 'Good value', to_date('17-09-2024', 'dd-mm-yyyy'), 314, 10517);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (126, 4.8, 'Decent purchase', to_date('07-09-2023', 'dd-mm-yyyy'), 254, 10367);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (127, 3, 'Works perfectly', to_date('18-09-2023', 'dd-mm-yyyy'), 251, 10677);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (128, 5.6, 'Excellent quality', to_date('19-12-2023', 'dd-mm-yyyy'), 175, 10571);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (129, 7.5, 'Top-notch item', to_date('04-10-2023', 'dd-mm-yyyy'), 222, 10201);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (130, 9, 'Returned it', to_date('06-10-2024', 'dd-mm-yyyy'), 463, 10570);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (131, 5.1, 'Five stars', to_date('03-09-2023', 'dd-mm-yyyy'), 253, 10381);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (132, 2.8, 'Terrible purchase', to_date('07-02-2024', 'dd-mm-yyyy'), 466, 10126);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (133, 4.7, 'Love this item', to_date('16-04-2023', 'dd-mm-yyyy'), 474, 10325);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (134, 1.2, 'Disappointed', to_date('26-03-2024', 'dd-mm-yyyy'), 428, 10649);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (135, 2.4, 'Not worth it', to_date('13-08-2024', 'dd-mm-yyyy'), 315, 10454);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (136, 4, 'Disappointed', to_date('19-10-2024', 'dd-mm-yyyy'), 52, 10125);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (137, 9.1, 'Happy customer', to_date('06-07-2023', 'dd-mm-yyyy'), 363, 10131);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (138, 6.3, 'Top-notch item', to_date('20-01-2023', 'dd-mm-yyyy'), 139, 10207);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (139, 9.5, 'Not worth it', to_date('04-12-2023', 'dd-mm-yyyy'), 458, 10150);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (140, 9.2, 'Happy customer', to_date('06-08-2023', 'dd-mm-yyyy'), 39, 10544);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (141, 6.4, 'Will buy again', to_date('23-02-2024', 'dd-mm-yyyy'), 244, 10614);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (142, 6.1, 'Very useful', to_date('17-01-2023', 'dd-mm-yyyy'), 349, 10158);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (143, 5.2, 'Well made', to_date('06-12-2023', 'dd-mm-yyyy'), 178, 10470);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (144, 5.9, 'Not as expected', to_date('09-11-2024', 'dd-mm-yyyy'), 104, 10399);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (145, 6.2, 'Low quality', to_date('04-08-2023', 'dd-mm-yyyy'), 341, 10558);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (146, 1.3, 'Subpar quality', to_date('24-03-2023', 'dd-mm-yyyy'), 265, 10472);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (147, 2.7, 'Cheap but good', to_date('30-07-2023', 'dd-mm-yyyy'), 112, 10553);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (148, 4.6, 'Disappointed', to_date('24-09-2023', 'dd-mm-yyyy'), 363, 10277);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (149, 1.5, 'Value for money', to_date('17-09-2024', 'dd-mm-yyyy'), 324, 10169);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (150, 3.2, 'Amazing service', to_date('25-05-2023', 'dd-mm-yyyy'), 209, 10273);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (151, 1.5, 'Amazing service', to_date('27-03-2023', 'dd-mm-yyyy'), 144, 10296);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (152, 6.5, 'Cheap but good', to_date('19-12-2024', 'dd-mm-yyyy'), 406, 10150);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (153, 2.8, 'Not as expected', to_date('06-05-2024', 'dd-mm-yyyy'), 32, 10152);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (154, 3.9, 'Top-notch item', to_date('01-12-2024', 'dd-mm-yyyy'), 325, 10011);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (155, 9.4, 'Love this item', to_date('05-12-2024', 'dd-mm-yyyy'), 296, 10311);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (156, 6.6, 'Cheap but good', to_date('24-11-2024', 'dd-mm-yyyy'), 197, 10673);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (157, 8.8, 'Will buy again', to_date('11-02-2024', 'dd-mm-yyyy'), 323, 10403);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (158, 1.4, 'Will buy again', to_date('28-02-2023', 'dd-mm-yyyy'), 357, 10008);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (159, 2.8, 'Terrible purchase', to_date('16-11-2024', 'dd-mm-yyyy'), 5, 10286);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (160, 2.8, 'Great design', to_date('22-03-2023', 'dd-mm-yyyy'), 291, 10271);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (161, 3.1, 'Value for money', to_date('28-08-2024', 'dd-mm-yyyy'), 243, 10509);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (162, 6.3, 'Terrible purchase', to_date('28-07-2024', 'dd-mm-yyyy'), 207, 10364);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (163, 9.5, 'Terrible purchase', to_date('12-09-2023', 'dd-mm-yyyy'), 423, 10527);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (164, 2, 'Subpar quality', to_date('11-11-2023', 'dd-mm-yyyy'), 386, 10069);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (165, 4.7, 'Fast shipping', to_date('12-11-2023', 'dd-mm-yyyy'), 115, 10278);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (166, 5.8, 'Fast shipping', to_date('16-11-2023', 'dd-mm-yyyy'), 131, 10367);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (167, 7.7, 'Highly recommend', to_date('23-01-2024', 'dd-mm-yyyy'), 156, 10404);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (168, 7.6, 'Well made', to_date('03-08-2024', 'dd-mm-yyyy'), 315, 10202);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (169, 6.3, 'Fast delivery', to_date('12-03-2024', 'dd-mm-yyyy'), 62, 10045);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (170, 3.2, 'Cheap but good', to_date('20-04-2023', 'dd-mm-yyyy'), 38, 10633);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (171, 8.7, 'Top-notch item', to_date('13-03-2024', 'dd-mm-yyyy'), 170, 10204);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (172, 9.6, 'Returned it', to_date('27-08-2023', 'dd-mm-yyyy'), 289, 10634);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (173, 3.5, 'Happy customer', to_date('11-09-2024', 'dd-mm-yyyy'), 362, 10018);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (174, 4.2, 'Exceeded expectations', to_date('30-05-2024', 'dd-mm-yyyy'), 435, 10181);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (175, 3.6, 'Five stars', to_date('01-02-2024', 'dd-mm-yyyy'), 155, 10491);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (176, 3.7, 'Amazing service', to_date('10-02-2024', 'dd-mm-yyyy'), 296, 10157);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (177, 6, 'Five stars', to_date('19-10-2023', 'dd-mm-yyyy'), 305, 10175);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (178, 3.1, 'Just okay', to_date('20-05-2023', 'dd-mm-yyyy'), 309, 10422);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (179, 2.9, 'Decent purchase', to_date('17-08-2023', 'dd-mm-yyyy'), 335, 10207);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (180, 1.8, 'Decent purchase', to_date('04-02-2023', 'dd-mm-yyyy'), 150, 10039);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (181, 7.2, 'Does the job', to_date('30-06-2023', 'dd-mm-yyyy'), 230, 10309);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (182, 5.5, 'Would recommend', to_date('19-04-2023', 'dd-mm-yyyy'), 162, 10205);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (183, 5.7, 'Great product!', to_date('15-09-2024', 'dd-mm-yyyy'), 149, 10573);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (184, 9.1, 'Highly recommend', to_date('28-09-2023', 'dd-mm-yyyy'), 352, 10077);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (185, 3.2, 'Will buy again', to_date('27-12-2023', 'dd-mm-yyyy'), 195, 10693);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (186, 9.5, 'Highly recommend', to_date('20-05-2023', 'dd-mm-yyyy'), 292, 10553);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (187, 6.2, 'Too expensive', to_date('22-06-2023', 'dd-mm-yyyy'), 144, 10272);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (188, 9.7, 'Five stars', to_date('18-12-2023', 'dd-mm-yyyy'), 60, 10135);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (189, 6.3, 'Works perfectly', to_date('23-05-2024', 'dd-mm-yyyy'), 199, 10504);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (190, 5.6, 'Excellent service', to_date('23-08-2023', 'dd-mm-yyyy'), 321, 10090);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (191, 5.7, 'Fast delivery', to_date('12-08-2023', 'dd-mm-yyyy'), 229, 10518);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (192, 9.6, 'Will buy again', to_date('30-10-2024', 'dd-mm-yyyy'), 491, 10195);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (193, 7.1, 'Excellent quality', to_date('12-08-2023', 'dd-mm-yyyy'), 122, 10442);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (194, 1.7, 'Returned it', to_date('27-11-2023', 'dd-mm-yyyy'), 198, 10135);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (195, 6.3, 'Well made', to_date('29-01-2024', 'dd-mm-yyyy'), 388, 10256);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (196, 5.2, 'Great design', to_date('02-10-2023', 'dd-mm-yyyy'), 417, 10454);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (197, 2.4, 'Just okay', to_date('15-12-2023', 'dd-mm-yyyy'), 82, 10014);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (198, 4.6, 'Will buy again', to_date('11-09-2024', 'dd-mm-yyyy'), 23, 10116);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (199, 3, 'Great features', to_date('07-01-2023', 'dd-mm-yyyy'), 196, 10431);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (200, 2.2, 'Great features', to_date('09-03-2024', 'dd-mm-yyyy'), 221, 10423);
commit;
prompt 200 records committed...
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (201, 4.5, 'Good value', to_date('07-08-2024', 'dd-mm-yyyy'), 119, 10482);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (202, 2.9, 'Well made', to_date('16-12-2023', 'dd-mm-yyyy'), 152, 10520);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (203, 2.7, 'Value for money', to_date('17-04-2024', 'dd-mm-yyyy'), 52, 10033);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (204, 2.3, 'Good value', to_date('02-02-2024', 'dd-mm-yyyy'), 448, 10335);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (205, 9.7, 'Value for money', to_date('04-07-2024', 'dd-mm-yyyy'), 169, 10095);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (206, 4.9, 'Very satisfied', to_date('14-01-2024', 'dd-mm-yyyy'), 173, 10004);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (207, 8.4, 'Great features', to_date('03-06-2023', 'dd-mm-yyyy'), 209, 10398);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (208, 6, 'Happy customer', to_date('28-10-2023', 'dd-mm-yyyy'), 181, 10656);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (209, 6.6, 'High quality', to_date('06-11-2024', 'dd-mm-yyyy'), 455, 10645);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (210, 2.7, 'Does the job', to_date('14-12-2023', 'dd-mm-yyyy'), 435, 10013);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (211, 9.3, 'Just okay', to_date('11-04-2024', 'dd-mm-yyyy'), 259, 10130);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (212, 8.1, 'Top-notch item', to_date('03-10-2024', 'dd-mm-yyyy'), 222, 10558);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (213, 7.8, 'Cheap but good', to_date('02-08-2023', 'dd-mm-yyyy'), 53, 10428);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (214, 7.1, 'Fast delivery', to_date('17-05-2024', 'dd-mm-yyyy'), 21, 10387);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (215, 4.4, 'High quality', to_date('06-06-2024', 'dd-mm-yyyy'), 365, 10269);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (216, 2.6, 'High quality', to_date('07-04-2024', 'dd-mm-yyyy'), 333, 10596);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (217, 1.3, 'High quality', to_date('29-03-2023', 'dd-mm-yyyy'), 423, 10689);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (218, 4.9, 'Exceeded expectations', to_date('28-04-2023', 'dd-mm-yyyy'), 32, 10358);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (219, 2.5, 'Cheap but good', to_date('28-05-2023', 'dd-mm-yyyy'), 211, 10313);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (220, 3.8, 'Does the job', to_date('05-05-2023', 'dd-mm-yyyy'), 217, 10304);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (221, 6.6, 'Highly recommend', to_date('06-07-2023', 'dd-mm-yyyy'), 77, 10294);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (222, 4.8, 'Works perfectly', to_date('29-12-2024', 'dd-mm-yyyy'), 411, 10656);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (223, 4.5, 'Subpar quality', to_date('05-10-2024', 'dd-mm-yyyy'), 177, 10188);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (224, 7.1, 'Decent purchase', to_date('18-07-2023', 'dd-mm-yyyy'), 166, 10495);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (225, 1.4, 'Decent purchase', to_date('09-10-2024', 'dd-mm-yyyy'), 233, 10446);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (226, 9.5, 'Great product!', to_date('08-10-2024', 'dd-mm-yyyy'), 387, 10492);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (227, 6.3, 'Very satisfied', to_date('27-04-2023', 'dd-mm-yyyy'), 462, 10309);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (228, 9.1, 'Value for money', to_date('07-07-2024', 'dd-mm-yyyy'), 429, 10633);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (229, 8.9, 'Very useful', to_date('01-02-2023', 'dd-mm-yyyy'), 476, 10145);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (230, 4.2, 'Very satisfied', to_date('17-10-2023', 'dd-mm-yyyy'), 402, 10172);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (231, 4.9, 'Not impressed', to_date('06-05-2023', 'dd-mm-yyyy'), 439, 10469);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (232, 5, 'Great features', to_date('06-10-2023', 'dd-mm-yyyy'), 415, 10015);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (233, 6.8, 'Fantastic buy', to_date('28-10-2023', 'dd-mm-yyyy'), 98, 10360);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (234, 2.1, 'Very satisfied', to_date('19-02-2023', 'dd-mm-yyyy'), 62, 10668);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (235, 5.9, 'Well made', to_date('06-02-2024', 'dd-mm-yyyy'), 152, 10577);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (236, 6.1, 'Cheap but good', to_date('09-12-2024', 'dd-mm-yyyy'), 4, 10477);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (237, 5.5, 'Great design', to_date('06-06-2023', 'dd-mm-yyyy'), 161, 10060);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (238, 6.3, 'Five stars', to_date('29-12-2023', 'dd-mm-yyyy'), 81, 10048);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (239, 9.4, 'Value for money', to_date('18-07-2023', 'dd-mm-yyyy'), 44, 10106);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (240, 1.5, 'Low quality', to_date('01-05-2023', 'dd-mm-yyyy'), 361, 10110);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (241, 8.9, 'Cheap but good', to_date('15-07-2023', 'dd-mm-yyyy'), 473, 10320);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (242, 5.6, 'Excellent quality', to_date('25-11-2024', 'dd-mm-yyyy'), 43, 10142);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (243, 6.4, 'Subpar quality', to_date('21-07-2023', 'dd-mm-yyyy'), 93, 10325);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (244, 9.1, 'Very useful', to_date('14-10-2023', 'dd-mm-yyyy'), 360, 10556);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (245, 10, 'Fast shipping', to_date('26-11-2023', 'dd-mm-yyyy'), 125, 10005);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (246, 5.2, 'Will return', to_date('05-06-2023', 'dd-mm-yyyy'), 209, 10597);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (247, 9.3, 'Not impressed', to_date('08-07-2024', 'dd-mm-yyyy'), 135, 10240);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (248, 9.5, 'Five stars', to_date('14-10-2024', 'dd-mm-yyyy'), 101, 10219);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (249, 8.2, 'Subpar quality', to_date('04-05-2023', 'dd-mm-yyyy'), 455, 10291);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (250, 3.2, 'Top-notch item', to_date('21-04-2024', 'dd-mm-yyyy'), 427, 10339);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (251, 2, 'Impressed', to_date('17-08-2023', 'dd-mm-yyyy'), 317, 10461);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (252, 3, 'Just okay', to_date('23-11-2024', 'dd-mm-yyyy'), 435, 10509);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (253, 1.1, 'Works perfectly', to_date('17-03-2024', 'dd-mm-yyyy'), 70, 10481);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (254, 3.2, 'Impressed', to_date('26-06-2024', 'dd-mm-yyyy'), 160, 10056);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (255, 8.8, 'Terrible purchase', to_date('15-09-2023', 'dd-mm-yyyy'), 251, 10659);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (256, 5.3, 'Impressed', to_date('12-04-2024', 'dd-mm-yyyy'), 384, 10594);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (257, 1.5, 'Highly recommend', to_date('27-07-2024', 'dd-mm-yyyy'), 304, 10631);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (258, 3.8, 'Five stars', to_date('31-01-2024', 'dd-mm-yyyy'), 360, 10173);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (259, 8.4, 'Highly recommend', to_date('15-12-2023', 'dd-mm-yyyy'), 10, 10299);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (260, 1.4, 'Value for money', to_date('21-07-2024', 'dd-mm-yyyy'), 363, 10450);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (261, 4.2, 'Terrible purchase', to_date('30-07-2024', 'dd-mm-yyyy'), 135, 10070);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (262, 5.4, 'Very satisfied', to_date('29-08-2024', 'dd-mm-yyyy'), 92, 10167);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (263, 6.7, 'Will return', to_date('02-06-2024', 'dd-mm-yyyy'), 308, 10548);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (264, 3.3, 'Works perfectly', to_date('23-08-2024', 'dd-mm-yyyy'), 6, 10623);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (265, 9.6, 'Subpar quality', to_date('29-03-2024', 'dd-mm-yyyy'), 158, 10009);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (266, 7.6, 'Fantastic buy', to_date('07-11-2024', 'dd-mm-yyyy'), 223, 10352);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (267, 6.5, 'Excellent service', to_date('14-07-2024', 'dd-mm-yyyy'), 306, 10600);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (268, 7.9, 'Great design', to_date('22-11-2024', 'dd-mm-yyyy'), 242, 10633);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (269, 7.1, 'Not worth it', to_date('04-02-2024', 'dd-mm-yyyy'), 315, 10364);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (270, 4.6, 'High quality', to_date('02-10-2023', 'dd-mm-yyyy'), 436, 10438);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (271, 4.8, 'Fantastic buy', to_date('05-08-2024', 'dd-mm-yyyy'), 19, 10677);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (272, 7.9, 'Excellent quality', to_date('15-02-2024', 'dd-mm-yyyy'), 145, 10197);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (273, 2.7, 'Highly recommend', to_date('07-12-2024', 'dd-mm-yyyy'), 387, 10015);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (274, 4.6, 'Highly recommend', to_date('05-02-2023', 'dd-mm-yyyy'), 142, 10538);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (275, 2.6, 'Highly recommend', to_date('03-07-2023', 'dd-mm-yyyy'), 86, 10366);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (276, 7.8, 'Decent purchase', to_date('29-11-2024', 'dd-mm-yyyy'), 418, 10646);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (277, 7, 'Very satisfied', to_date('24-02-2023', 'dd-mm-yyyy'), 18, 10107);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (278, 8.5, 'Impressed', to_date('26-08-2023', 'dd-mm-yyyy'), 174, 10669);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (279, 8.5, 'Happy customer', to_date('15-08-2024', 'dd-mm-yyyy'), 200, 10043);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (280, 4.6, 'Cheap but good', to_date('17-09-2024', 'dd-mm-yyyy'), 342, 10574);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (281, 1.5, 'Impressed', to_date('20-10-2024', 'dd-mm-yyyy'), 128, 10358);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (282, 8.9, 'Decent purchase', to_date('18-10-2023', 'dd-mm-yyyy'), 268, 10586);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (283, 9.3, 'Great features', to_date('27-01-2024', 'dd-mm-yyyy'), 72, 10666);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (284, 7.7, 'Impressed', to_date('23-02-2023', 'dd-mm-yyyy'), 307, 10217);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (285, 8.5, 'Fantastic buy', to_date('04-01-2024', 'dd-mm-yyyy'), 265, 10210);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (286, 2.9, 'High quality', to_date('16-10-2024', 'dd-mm-yyyy'), 342, 10541);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (287, 9.3, 'Would recommend', to_date('06-05-2024', 'dd-mm-yyyy'), 27, 10242);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (288, 7.1, 'Works perfectly', to_date('09-02-2024', 'dd-mm-yyyy'), 429, 10578);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (289, 3.1, 'Just okay', to_date('19-09-2023', 'dd-mm-yyyy'), 416, 10064);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (290, 9.4, 'Will buy again', to_date('31-08-2023', 'dd-mm-yyyy'), 331, 10245);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (291, 8.1, 'Would recommend', to_date('21-07-2024', 'dd-mm-yyyy'), 412, 10113);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (292, 5.3, 'Fantastic buy', to_date('05-12-2023', 'dd-mm-yyyy'), 230, 10239);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (293, 8.5, 'Exceeded expectations', to_date('08-07-2023', 'dd-mm-yyyy'), 102, 10073);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (294, 2.9, 'Not as expected', to_date('16-03-2023', 'dd-mm-yyyy'), 395, 10485);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (295, 4.9, 'High quality', to_date('28-02-2023', 'dd-mm-yyyy'), 130, 10097);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (296, 8.7, 'Returned it', to_date('26-04-2023', 'dd-mm-yyyy'), 22, 10007);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (297, 3.1, 'Does the job', to_date('07-07-2023', 'dd-mm-yyyy'), 61, 10471);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (298, 8.5, 'Works perfectly', to_date('11-01-2023', 'dd-mm-yyyy'), 477, 10128);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (299, 3.2, 'Exceeded expectations', to_date('19-07-2023', 'dd-mm-yyyy'), 145, 10190);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (300, 7.7, 'Low quality', to_date('18-04-2023', 'dd-mm-yyyy'), 296, 10518);
commit;
prompt 300 records committed...
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (301, 4.1, 'Good value', to_date('01-12-2023', 'dd-mm-yyyy'), 90, 10596);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (302, 3.9, 'Top-notch item', to_date('11-03-2024', 'dd-mm-yyyy'), 286, 10306);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (303, 9.4, 'Just okay', to_date('01-04-2023', 'dd-mm-yyyy'), 163, 10121);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (304, 8.7, 'Works perfectly', to_date('09-11-2023', 'dd-mm-yyyy'), 26, 10464);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (305, 2.9, 'Impressed', to_date('24-05-2024', 'dd-mm-yyyy'), 78, 10204);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (306, 6.4, 'Just okay', to_date('24-04-2024', 'dd-mm-yyyy'), 394, 10458);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (307, 3, 'Superb performance', to_date('19-03-2024', 'dd-mm-yyyy'), 32, 10104);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (308, 7.1, 'Disappointed', to_date('10-07-2024', 'dd-mm-yyyy'), 315, 10537);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (309, 6.1, 'Decent purchase', to_date('23-10-2023', 'dd-mm-yyyy'), 20, 10588);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (310, 2.1, 'Value for money', to_date('27-08-2024', 'dd-mm-yyyy'), 355, 10490);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (311, 2.6, 'Fast shipping', to_date('04-12-2023', 'dd-mm-yyyy'), 226, 10030);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (312, 4.9, 'Great design', to_date('08-08-2024', 'dd-mm-yyyy'), 208, 10104);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (313, 5.9, 'Highly recommend', to_date('07-06-2023', 'dd-mm-yyyy'), 367, 10361);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (314, 9.6, 'Disappointed', to_date('06-03-2023', 'dd-mm-yyyy'), 204, 10372);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (315, 3.5, 'Very satisfied', to_date('16-09-2023', 'dd-mm-yyyy'), 359, 10102);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (316, 4, 'Too expensive', to_date('08-04-2023', 'dd-mm-yyyy'), 235, 10440);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (317, 2.9, 'Excellent quality', to_date('19-03-2023', 'dd-mm-yyyy'), 236, 10560);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (318, 4.8, 'Not impressed', to_date('02-01-2024', 'dd-mm-yyyy'), 11, 10571);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (319, 4.9, 'Fast shipping', to_date('15-02-2023', 'dd-mm-yyyy'), 231, 10496);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (320, 8, 'Superb performance', to_date('03-04-2024', 'dd-mm-yyyy'), 270, 10504);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (321, 8.6, 'Fantastic buy', to_date('18-03-2023', 'dd-mm-yyyy'), 6, 10278);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (322, 1.8, 'Five stars', to_date('01-04-2024', 'dd-mm-yyyy'), 149, 10606);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (323, 6.7, 'Works perfectly', to_date('19-09-2023', 'dd-mm-yyyy'), 122, 10614);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (324, 7.5, 'Works perfectly', to_date('08-05-2024', 'dd-mm-yyyy'), 110, 10128);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (325, 2, 'Well made', to_date('10-10-2024', 'dd-mm-yyyy'), 158, 10625);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (326, 3.3, 'Returned it', to_date('25-09-2023', 'dd-mm-yyyy'), 150, 10166);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (327, 8.7, 'Excellent quality', to_date('05-01-2024', 'dd-mm-yyyy'), 148, 10045);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (328, 3.3, 'Excellent service', to_date('02-06-2023', 'dd-mm-yyyy'), 453, 10446);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (329, 6.4, 'Too expensive', to_date('31-07-2024', 'dd-mm-yyyy'), 167, 10696);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (330, 3.8, 'Will buy again', to_date('01-07-2023', 'dd-mm-yyyy'), 60, 10433);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (331, 4.8, 'Love this item', to_date('13-02-2024', 'dd-mm-yyyy'), 77, 10056);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (332, 9.6, 'Not as expected', to_date('26-02-2024', 'dd-mm-yyyy'), 107, 10689);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (333, 4.2, 'Superb performance', to_date('02-02-2023', 'dd-mm-yyyy'), 406, 10178);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (334, 6.3, 'Amazing service', to_date('10-08-2023', 'dd-mm-yyyy'), 419, 10585);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (335, 1.2, 'Low quality', to_date('15-09-2024', 'dd-mm-yyyy'), 171, 10397);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (336, 7.1, 'Not worth it', to_date('29-04-2024', 'dd-mm-yyyy'), 193, 10426);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (337, 3.9, 'Returned it', to_date('21-07-2023', 'dd-mm-yyyy'), 270, 10324);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (338, 5.2, 'Very useful', to_date('27-03-2023', 'dd-mm-yyyy'), 97, 10088);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (339, 9.6, 'Terrible purchase', to_date('18-10-2023', 'dd-mm-yyyy'), 257, 10361);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (340, 9, 'Five stars', to_date('30-08-2024', 'dd-mm-yyyy'), 44, 10427);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (341, 9.7, 'Terrible purchase', to_date('23-02-2024', 'dd-mm-yyyy'), 147, 10085);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (342, 9.7, 'Impressed', to_date('14-06-2024', 'dd-mm-yyyy'), 214, 10003);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (343, 4.9, 'Terrible purchase', to_date('18-02-2023', 'dd-mm-yyyy'), 290, 10655);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (344, 7, 'Just okay', to_date('05-03-2024', 'dd-mm-yyyy'), 276, 10372);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (345, 3.7, 'Fast shipping', to_date('22-04-2024', 'dd-mm-yyyy'), 223, 10483);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (346, 2.1, 'Works perfectly', to_date('24-09-2023', 'dd-mm-yyyy'), 278, 10247);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (347, 9.8, 'Value for money', to_date('13-07-2024', 'dd-mm-yyyy'), 372, 10666);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (348, 9.3, 'Five stars', to_date('03-02-2023', 'dd-mm-yyyy'), 442, 10230);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (349, 3.1, 'Too expensive', to_date('28-11-2024', 'dd-mm-yyyy'), 25, 10349);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (350, 8.2, 'Will return', to_date('09-08-2023', 'dd-mm-yyyy'), 452, 10407);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (351, 2.1, 'Subpar quality', to_date('04-01-2023', 'dd-mm-yyyy'), 270, 10630);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (352, 5.5, 'Exceeded expectations', to_date('07-02-2024', 'dd-mm-yyyy'), 73, 10394);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (353, 9.3, 'Fast delivery', to_date('29-04-2024', 'dd-mm-yyyy'), 342, 10361);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (354, 7.1, 'Just okay', to_date('19-06-2023', 'dd-mm-yyyy'), 288, 10682);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (355, 2.1, 'Great features', to_date('25-01-2024', 'dd-mm-yyyy'), 104, 10135);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (356, 3.2, 'Great features', to_date('11-03-2023', 'dd-mm-yyyy'), 151, 10038);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (357, 5.5, 'Disappointed', to_date('04-01-2023', 'dd-mm-yyyy'), 310, 10282);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (358, 7.1, 'Will buy again', to_date('19-12-2024', 'dd-mm-yyyy'), 181, 10407);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (359, 3.8, 'Five stars', to_date('14-12-2024', 'dd-mm-yyyy'), 25, 10017);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (360, 2.5, 'Superb performance', to_date('30-09-2023', 'dd-mm-yyyy'), 244, 10335);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (361, 5.4, 'Just okay', to_date('31-08-2023', 'dd-mm-yyyy'), 440, 10348);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (362, 2.3, 'Excellent quality', to_date('29-12-2023', 'dd-mm-yyyy'), 65, 10182);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (363, 3.7, 'Amazing service', to_date('06-04-2024', 'dd-mm-yyyy'), 303, 10133);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (364, 3.7, 'Good value', to_date('17-02-2024', 'dd-mm-yyyy'), 430, 10444);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (365, 6.2, 'Cheap but good', to_date('02-08-2024', 'dd-mm-yyyy'), 183, 10470);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (366, 3.7, 'Disappointed', to_date('07-09-2023', 'dd-mm-yyyy'), 394, 10516);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (367, 2.3, 'Value for money', to_date('15-09-2024', 'dd-mm-yyyy'), 396, 10412);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (368, 8.3, 'Terrible purchase', to_date('01-07-2023', 'dd-mm-yyyy'), 44, 10263);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (369, 7.4, 'Fast shipping', to_date('29-04-2024', 'dd-mm-yyyy'), 57, 10169);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (370, 9.3, 'Low quality', to_date('12-06-2023', 'dd-mm-yyyy'), 161, 10547);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (371, 3, 'Top-notch item', to_date('24-05-2024', 'dd-mm-yyyy'), 137, 10133);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (372, 6.5, 'Will return', to_date('10-01-2023', 'dd-mm-yyyy'), 160, 10307);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (373, 7.2, 'Amazing service', to_date('15-03-2024', 'dd-mm-yyyy'), 149, 10223);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (374, 4.1, 'Does the job', to_date('18-06-2023', 'dd-mm-yyyy'), 208, 10605);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (375, 5.1, 'Subpar quality', to_date('29-06-2024', 'dd-mm-yyyy'), 383, 10366);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (376, 4.5, 'Very satisfied', to_date('23-04-2024', 'dd-mm-yyyy'), 84, 10458);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (377, 6.8, 'Amazing service', to_date('15-10-2023', 'dd-mm-yyyy'), 327, 10217);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (378, 2.4, 'Exceeded expectations', to_date('23-08-2024', 'dd-mm-yyyy'), 413, 10642);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (379, 9.9, 'Subpar quality', to_date('27-07-2023', 'dd-mm-yyyy'), 84, 10679);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (380, 8.9, 'Excellent quality', to_date('09-02-2023', 'dd-mm-yyyy'), 483, 10183);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (381, 1.3, 'Fantastic buy', to_date('16-12-2024', 'dd-mm-yyyy'), 147, 10327);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (382, 1.9, 'Too expensive', to_date('29-06-2024', 'dd-mm-yyyy'), 239, 10017);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (383, 6.9, 'Terrible purchase', to_date('03-07-2023', 'dd-mm-yyyy'), 207, 10299);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (384, 7.9, 'Superb performance', to_date('10-03-2023', 'dd-mm-yyyy'), 192, 10237);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (385, 3.3, 'Happy customer', to_date('15-08-2024', 'dd-mm-yyyy'), 73, 10467);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (386, 2.3, 'Amazing service', to_date('09-11-2023', 'dd-mm-yyyy'), 368, 10131);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (387, 7.2, 'Amazing service', to_date('09-04-2024', 'dd-mm-yyyy'), 370, 10085);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (388, 5.3, 'Good value', to_date('25-06-2023', 'dd-mm-yyyy'), 80, 10380);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (389, 8.3, 'Excellent quality', to_date('29-08-2024', 'dd-mm-yyyy'), 293, 10588);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (390, 8.9, 'Superb performance', to_date('09-01-2024', 'dd-mm-yyyy'), 330, 10355);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (391, 6.4, 'Fantastic buy', to_date('28-06-2023', 'dd-mm-yyyy'), 326, 10440);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (392, 10, 'Just okay', to_date('03-04-2024', 'dd-mm-yyyy'), 263, 10487);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (393, 6.2, 'Value for money', to_date('07-04-2024', 'dd-mm-yyyy'), 451, 10499);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (394, 4.4, 'Five stars', to_date('28-02-2024', 'dd-mm-yyyy'), 483, 10272);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (395, 2.1, 'Highly recommend', to_date('09-01-2023', 'dd-mm-yyyy'), 321, 10278);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (396, 2.1, 'Value for money', to_date('14-07-2024', 'dd-mm-yyyy'), 357, 10627);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (397, 9.1, 'Fast shipping', to_date('01-03-2024', 'dd-mm-yyyy'), 293, 10567);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (398, 4.2, 'Fantastic buy', to_date('11-07-2023', 'dd-mm-yyyy'), 25, 10444);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (399, 6.6, 'Fast shipping', to_date('06-07-2023', 'dd-mm-yyyy'), 363, 10221);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (400, 1.2, 'Very satisfied', to_date('26-06-2023', 'dd-mm-yyyy'), 154, 10123);
commit;
prompt 400 records loaded
prompt Loading SELLERS...
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Shannyn Beatty', 11111, '520000000', '609 Parsons Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Connie Craddock', 11112, '520000001', '94 McConaughey Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Armand Tolkan', 11113, '520000002', '81 São paulo Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Stevie Holeman', 11114, '520000003', '98 Sapulpa Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Hazel Breslin', 11115, '520000004', '641 Kelly Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Cuba Carter', 11116, '520000005', '68 Dwight Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jimmie Duvall', 11117, '520000006', '365 Hampton Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Desmond Stiles', 11118, '520000007', '20 Li Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Coley Katt', 11119, '520000008', '68 Richmond Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ramsey Loring', 11120, '520000009', '43 Angelina Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Vertical Mould', 11121, '520000010', '33rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ahmad Streep', 11122, '520000011', '67 Elvis Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jodie Lattimore', 11123, '520000012', '29 Dawson');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lea Kotto', 11124, '520000013', '4 Fremont');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rodney Morse', 11125, '520000014', '78 North bethesda');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Richie Scaggs', 11126, '520000015', '16 Oldham Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Alan Tisdale', 11127, '520000016', '720 Corey Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rosco Sedaka', 11128, '520000017', '69 Wong Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Robbie Cassel', 11129, '520000018', '31st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Vertical Pullman', 11130, '520000019', '92 Dafoe Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lauren Archer', 11131, '520000020', '1000 Luedenscheid Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Andrae Cummings', 11132, '520000021', '43 Mary-Louise Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kylie Hagerty', 11133, '520000022', '67 Hiatt Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Miles Avalon', 11134, '520000023', '44 Stormare Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Denis Alda', 11135, '520000024', '22 Hunter Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Benicio Kershaw', 11136, '520000025', '429 Yolanda Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Pat Patton', 11137, '520000026', '444 Suffern Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Cate Emmett', 11138, '520000027', '31st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Natasha Wariner', 11139, '520000028', '36 Starr Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Edgar Crystal', 11140, '520000029', '94 Arkenstone Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Bette Penn', 11141, '520000030', '857 Juno Beach Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Desmond Loeb', 11142, '520000031', '349 Child Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Will Heatherly', 11143, '520000032', '803 Cross Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Melanie Mitchell', 11144, '520000033', '63rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Cole Johansen', 11145, '520000034', '15 Lachey Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('John Bandy', 11146, '520000035', '93rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Luke McKennitt', 11147, '520000036', '11 Parker Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Dean Marshall', 11148, '520000037', '82 La Plata Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Fairuza Chaykin', 11149, '520000038', '227 Knight Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Etta Gertner', 11150, '520000039', '71 Geraldine Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Suzi Horizon', 11151, '520000040', '89 Curtis Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Bette Patillo', 11152, '520000041', '86 Koyana Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Johnnie Summer', 11153, '520000042', '4 Checker Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ed Kretschmann', 11154, '520000043', '21 Miko Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Vivica Krumholtz', 11155, '520000044', '44 Palo Alto');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Betty Snider', 11156, '520000045', '17 Hurley Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rebecca Rock', 11157, '520000046', '54 Heatherly Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Dave Shelton', 11158, '520000047', '35 McCann Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Gabrielle Danger', 11159, '520000048', '77 Henstridge Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Luke Playboys', 11160, '520000049', '10 Hjallerup');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Hope Lang', 11161, '520000050', '52 Hohenfels Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Cate Thomson', 11162, '520000051', '891 Meg Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Clea Pride', 11163, '520000052', '87 Miller Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Oliver Rawls', 11164, '520000053', '198 Lyngby Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Liquid Cox', 11165, '520000054', '94 New Hope Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ricardo Heche', 11166, '520000055', '25 Howard Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rhona Carlyle', 11167, '520000056', '53rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Elvis Schreiber', 11168, '520000057', '4 Teng Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Nils Tomlin', 11169, '520000058', '68 Pacino Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Vince Moss', 11170, '520000059', '75 Paltrow');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Gilberto Niven', 11171, '520000060', '59 Rankin Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Earl Moffat', 11172, '520000061', '100 Presley Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Curtis Snipes', 11173, '520000062', '82 Kathy Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Aaron Hayek', 11174, '520000063', '13 Wayans Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Crispin Duchovny', 11175, '520000064', '340 Lima Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Elias Knight', 11176, '520000065', '41 Winans Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Joy Palmer', 11177, '520000066', '589 Bonham Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Powers Costner', 11178, '520000067', '52nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Joseph Flanagan', 11179, '520000068', '15 Dardilly Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Avenged Suchet', 11180, '520000069', '36 Rush Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Geggy Albright', 11181, '520000070', '12nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Mykelti Reno', 11182, '520000071', '48 Cottbus Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Tyrone Moody', 11183, '520000072', '81 Bloch Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Anita Channing', 11184, '520000073', '650 Dafoe Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Pelvic Makowicz', 11185, '520000074', '69 Landau Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Spencer Murdock', 11186, '520000075', '496 Thames Ditton Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Meredith Easton', 11187, '520000076', '12nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Danni Cohn', 11188, '520000077', '28 Driver Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Connie English', 11189, '520000078', '60 Mellencamp Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Chanté Singh', 11190, '520000079', '64 Potter Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Amanda D''Onofrio', 11191, '520000080', '26 Whitmore Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Wendy Alston', 11192, '520000081', '86 Stuttgart Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Gord O''Hara', 11193, '520000082', '478 Marina Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Juliette Jackman', 11194, '520000083', '350 Watley Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Avril Bergen', 11195, '520000084', '91 Paymer Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Allan Chan', 11196, '520000085', '22 Wilkinson Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Petula Curfman', 11197, '520000086', '32nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Joan Brooke', 11198, '520000087', '85 Palo Alto Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Meryl McCready', 11199, '520000088', '71 Laguna Bbeach Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Drew Avalon', 11200, '520000089', '50 Jerusalem Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Moe Garfunkel', 11201, '520000090', '29 Thame Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Eileen Napolitano', 11202, '520000091', '2 Xander Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Merle Valentin', 11203, '520000092', '25 Penders Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Annette Pearce', 11204, '520000093', '73 Condition Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Chalee O''Donnell', 11205, '520000094', '58 Wincott');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Angie Cantrell', 11206, '520000095', '58 Summer Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Catherine Arnold', 11207, '520000096', '57 Douala Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Sarah Rickman', 11208, '520000097', '70 Toshiro Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Etta Elliott', 11209, '520000098', '822 Benson Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lily Diesel', 11210, '520000099', '88 Riverdale');
commit;
prompt 100 records committed...
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Donna Perez', 11211, '520000100', '90 League city');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ming-Na Stuart', 11212, '520000101', '62nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Zooey David', 11213, '520000102', '27 Mark Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Tia Warden', 11214, '520000103', '11st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Emilio Atlas', 11215, '520000104', '21st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Tal Bell', 11216, '520000105', '54 Kinnear Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lucy Mollard', 11217, '520000106', '19 Levy Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jennifer Michaels', 11218, '520000107', '280 Walter Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rawlins Soul', 11219, '520000108', '64 Portman Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Sander Arnold', 11220, '520000109', '22nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Arnold Caviezel', 11221, '520000110', '52 Tyne & Wear Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Sam Phifer', 11222, '520000111', '92 LeVar Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Deborah Griffiths', 11223, '520000112', '66 Janssen Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Coley Reeves', 11224, '520000113', '93 Calle Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Balthazar Pearce', 11225, '520000114', '283 Shearer Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Bradley McDonald', 11226, '520000115', '3 Wills Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Bo Palmieri', 11227, '520000116', '27 Snider Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Chuck El-Saher', 11228, '520000117', '16 Edward Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Clint Torn', 11229, '520000118', '10 Cage Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Emilio Heche', 11230, '520000119', '28 Mechelen Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Olympia Quinlan', 11231, '520000120', '20 Bkk Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Dabney McKennitt', 11232, '520000121', '44 Sihung-si Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rhys urban', 11233, '520000122', '49 Matheson Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Sam Jeffreys', 11234, '520000123', '200 Sendai Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Nicole Gilley', 11235, '520000124', '784 Illeana');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Mae Hidalgo', 11236, '520000125', '72nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Patricia Shalhoub', 11237, '520000126', '100 Pantoliano Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Geoffrey Cattrall', 11238, '520000127', '632 Billerica Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Demi Melvin', 11239, '520000128', '34 Atkinson Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Melba Overstreet', 11240, '520000129', '16 Lari Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lydia Chandler', 11241, '520000130', '94 Thalwil Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Wallace Davison', 11242, '520000131', '63 Carrack Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Emily Garza', 11243, '520000132', '47 Day-Lewis Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lynn Palminteri', 11244, '520000133', '950 Banbury Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Pat Jessee', 11245, '520000134', '46 Malone Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Todd Adkins', 11246, '520000135', '51 Jody Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Sean Palmieri', 11247, '520000136', '24 Janice Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Meryl Parish', 11248, '520000137', '35 Heald Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Miki Kirkwood', 11249, '520000138', '71 Palma de Mallorca Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Tara Salonga', 11250, '520000139', '676 Wright Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Elvis Beatty', 11251, '520000140', '33rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rory Hagerty', 11252, '520000141', '954 Diddley Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Geggy Rankin', 11253, '520000142', '29 King Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Dorry McGovern', 11254, '520000143', '74 Austin');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Crispin Paquin', 11255, '520000144', '24 Patricia Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Balthazar Hall', 11256, '520000145', '97 Katt Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Tobey Sedgwick', 11257, '520000146', '92nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ashley DeVita', 11258, '520000147', '59 Tobolowsky Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Minnie Danes', 11259, '520000148', '93 Amy Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Sarah Biggs', 11260, '520000149', '76 Freeman Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jonathan Sizemore', 11261, '520000150', '11 Randall Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Thelma Cross', 11262, '520000151', '83rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ivan Goldberg', 11263, '520000152', '92 Stevie Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kenny Stone', 11264, '520000153', '22nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Tori Zahn', 11265, '520000154', '315 Gill Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Elias Bradford', 11266, '520000155', '45 McFadden Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Wade Jay', 11267, '520000156', '19 Colombes Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Warren Love', 11268, '520000157', '273 Monterey Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Horace Hauer', 11269, '520000158', '61 Vincent Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Meg Moore', 11270, '520000159', '2 Saucedo Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ani Whitman', 11271, '520000160', '884 Boyd Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kyra Statham', 11272, '520000161', '77 Essex Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Sissy Mahoney', 11273, '520000162', '26 Ceili Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Larry Shatner', 11274, '520000163', '89 Hampton Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kirsten Carrack', 11275, '520000164', '33 Dartmouth');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Teena Day-Lewis', 11276, '520000165', '375 Marianne Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Loreena Conley', 11277, '520000166', '85 Molina Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ned Elizondo', 11278, '520000167', '55 Ani Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Dan Adams', 11279, '520000168', '3 Hewitt Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jim Franks', 11280, '520000169', '1 Wopat Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Shannyn Houston', 11281, '520000170', '12nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Toshiro Santana', 11282, '520000171', '1 Chrissie Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ming-Na Landau', 11283, '520000172', '41st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Phoebe Wopat', 11284, '520000173', '85 Ifans Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Terrence Torres', 11285, '520000174', '330 McPherson Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Faye McDonald', 11286, '520000175', '22 Margulies Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Natascha Roundtree', 11287, '520000176', '27 Uggams Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Sydney Quaid', 11288, '520000177', '17 Loeb Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jared Tanon', 11289, '520000178', '304 MacLachlan Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Howard Margolyes', 11290, '520000179', '81 Illeana Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Adrien Brock', 11291, '520000180', '80 Salvador Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kevn Watson', 11292, '520000181', '41 Nagoya');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Steve Solido', 11293, '520000182', '21 Laws Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Merrilee Nolte', 11294, '520000183', '79 Swayze');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Carlos Freeman', 11295, '520000184', '37 Keaton Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Geena Derringer', 11296, '520000185', '743 Debbie Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Carol Blackwell', 11297, '520000186', '20 Natascha Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Isaiah Doucette', 11298, '520000187', '34 Gandolfini Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Percy Stowe', 11299, '520000188', '82 Perlman Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Marie Ali', 11300, '520000189', '16 Santa Rosa');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Crispin Weisz', 11301, '520000190', '99 Rossellini Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Shelby Condition', 11302, '520000191', '20 Debbie Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('LeVar Harrison', 11303, '520000192', '4 Powers Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Gloria Van Helden', 11304, '520000193', '42 Arjona');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Doug Paul', 11305, '520000194', '52nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kate Willis', 11306, '520000195', '58 St Kilda Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Don Dukakis', 11307, '520000196', '67 Kadison Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('James Kirshner', 11308, '520000197', '97 Cochran Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Hank Rourke', 11309, '520000198', '3 Tilda Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Thelma Rain', 11310, '520000199', '4 Aykroyd Road');
commit;
prompt 200 records committed...
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ellen Short', 11311, '520000200', '776 Trey Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Hope Baez', 11312, '520000201', '86 Shepard Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Milla Garner', 11313, '520000202', '44 Yucca Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rupert Polito', 11314, '520000203', '65 Bonham Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Mac Holden', 11315, '520000204', '37 Leary Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Elle Sewell', 11316, '520000205', '266 Nagoya Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ethan Lightfoot', 11317, '520000206', '208 Greenwood Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Swoosie Gosdin', 11318, '520000207', '93rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Matt Rea', 11319, '520000208', '27 Bradenton Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Balthazar Cumming', 11320, '520000209', '3 Lippetal Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Dave Chung', 11321, '520000210', '23 Jean Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Tom Holeman', 11322, '520000211', '51st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Mena DiFranco', 11323, '520000212', '38 Mahoney Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Denis Rosas', 11324, '520000213', '82 Burns Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Laura Rossellini', 11325, '520000214', '78 Redmond Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Bonnie Nivola', 11326, '520000215', '74 Frost Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jesse DeVita', 11327, '520000216', '900 Corey Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lupe Stills', 11328, '520000217', '67 Patti Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('LeVar Winwood', 11329, '520000218', '2 Lakewood Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Christmas Knight', 11330, '520000219', '61 Union Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Mint Paxton', 11331, '520000220', '502 Turturro');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Edgar Krumholtz', 11332, '520000221', '57 Varzea grande Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jamie Makowicz', 11333, '520000222', '8 Jakarta Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Noah Sledge', 11334, '520000223', '722 Gwyneth Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Daryle Paymer', 11335, '520000224', '73rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Adam Karyo', 11336, '520000225', '45 Kyra Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Campbell Green', 11337, '520000226', '840 Holeman Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Angie Winslet', 11338, '520000227', '50 Cozier Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Frederic Kinnear', 11339, '520000228', '70 Baranski Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Joan Hoskins', 11340, '520000229', '51st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kylie Harrison', 11341, '520000230', '83 Bassett Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jose Haslam', 11342, '520000231', '97 Conway Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Leelee Azaria', 11343, '520000232', '61 Clayton Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Mos Gold', 11344, '520000233', '85 Gambon Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('First Singletary', 11345, '520000234', '815 Natasha Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Latin Kattan', 11346, '520000235', '578 Bobby Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Leslie Dooley', 11347, '520000236', '97 Davis Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Dabney Leary', 11348, '520000237', '416 Cara Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Sona Vega', 11349, '520000238', '39 Weir Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Joely Orbit', 11350, '520000239', '39 Van Damme Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Demi Holmes', 11351, '520000240', '31st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jennifer Fiorentino', 11352, '520000241', '688 Heiligenhaus Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Peabo Neville', 11353, '520000242', '97 Petula Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('William MacLachlan', 11354, '520000243', '13 Latin');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Belinda Goldwyn', 11355, '520000244', '879 Cape town Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jack Posey', 11356, '520000245', '65 Thames Ditton Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jesse Latifah', 11357, '520000246', '33 De Niro Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lauren Posener', 11358, '520000247', '47 McIntosh Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Sophie Thomson', 11359, '520000248', '97 Oszajca Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Todd Posener', 11360, '520000249', '4 Kaysville');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Chet Polito', 11361, '520000250', '597 Rosanne');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Eileen Dunst', 11362, '520000251', '44 Lipnicki Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Keanu Tripplehorn', 11363, '520000252', '77 Caviezel Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Mykelti Kutcher', 11364, '520000253', '20 Mandy Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Trick Tyler', 11365, '520000254', '1 Earl Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Susan Lowe', 11366, '520000255', '154 Connie Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Brendan Diggs', 11367, '520000256', '447 Bragg Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ricardo Whitmore', 11368, '520000257', '61 Reisterstown Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Nanci Noseworthy', 11369, '520000258', '11 Wilmington Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Naomi Favreau', 11370, '520000259', '464 Malmö Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Vonda Tarantino', 11371, '520000260', '42 Linney Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jeff Holden', 11372, '520000261', '669 Diaz Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Boz Sisto', 11373, '520000262', '76 Andrews Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Shirley Sewell', 11374, '520000263', '13 Munich Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Salma Branagh', 11375, '520000264', '57 Harsum Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Spencer Rodgers', 11376, '520000265', '58 Wallace Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Frankie Owen', 11377, '520000266', '13 Avril Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Tia Holden', 11378, '520000267', '91 Tooele Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Julianne Diddley', 11379, '520000268', '92nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Joseph Pepper', 11380, '520000269', '25 Loren Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Sigourney Austin', 11381, '520000270', '20 Brasília Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Colleen Stills', 11382, '520000271', '247 James Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Russell Tierney', 11383, '520000272', '51 Skerritt Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Loren Tucker', 11384, '520000273', '3 Fiorentino Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Glen Chappelle', 11385, '520000274', '90 Sheffield Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Maury Borden', 11386, '520000275', '13 Lisa Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Dennis Henstridge', 11387, '520000276', '27 Crowe Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Reese Reinhold', 11388, '520000277', '12 Casey Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Fiona Sinatra', 11389, '520000278', '64 Chambers Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Breckin Clayton', 11390, '520000279', '72 Logue Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Debra Plowright', 11391, '520000280', '80 Sherman Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Willem Beckham', 11392, '520000281', '98 Freda Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jeffrey Biggs', 11393, '520000282', '82 Dupree Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Emma Levine', 11394, '520000283', '95 Dan Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Wendy Firth', 11395, '520000284', '78 Sursee Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Nikka Cage', 11396, '520000285', '82 Singapore Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Martin Ponty', 11397, '520000286', '70 Nicks');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Loren Beals', 11398, '520000287', '12nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Terri Marley', 11399, '520000288', '61st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Eddie Gagnon', 11400, '520000289', '81 Vendetta Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Gloria Ammons', 11401, '520000290', '9 Harnes Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Candice Stuermer', 11402, '520000291', '3 Mitchell Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ronnie Imbruglia', 11403, '520000292', '831 Chanté Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Arturo Loggia', 11404, '520000293', '20 Avalon Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Celia Rispoli', 11405, '520000294', '806 Smyrna Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Anne Bragg', 11406, '520000295', '21st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Natalie Gill', 11407, '520000296', '33 Ashley Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Eugene Elizabeth', 11408, '520000297', '64 Jean Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Crystal Murdock', 11409, '520000298', '50 Meyer Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Gran Blanchett', 11410, '520000299', '90 Utrecht Drive');
commit;
prompt 300 records committed...
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Meryl McLachlan', 11411, '520000300', '62 Denzel Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jill Fariq', 11412, '520000301', '74 Arden Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lenny Craddock', 11413, '520000302', '47 Borger Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Bobbi Everett', 11414, '520000303', '30 Oakenfold Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Brian Weisz', 11415, '520000304', '53 Victoria');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Diane Sossamon', 11416, '520000305', '92 Greenwood Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jessica Lavigne', 11417, '520000306', '58 Patrick Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Tal McBride', 11418, '520000307', '28 Sobieski Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Victoria MacLachlan', 11419, '520000308', '83rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ritchie Lonsdale', 11420, '520000309', '5 Marsden Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Armand Curtis', 11421, '520000310', '871 Savage Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Edward McNeice', 11422, '520000311', '77 Tate Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Mike King', 11423, '520000312', '29 McFadden Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rowan Hagar', 11424, '520000313', '68 Jean-Luc');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Solomon Stone', 11425, '520000314', '14 Peebles Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Temuera Craven', 11426, '520000315', '5 Marx');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Saul Chung', 11427, '520000316', '83 Miles Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Geoff Willis', 11428, '520000317', '28 Conroy Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Gavin Diehl', 11429, '520000318', '15 Alexander Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Trick Paul', 11430, '520000319', '916 Akins Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Radney Eckhart', 11431, '520000320', '97 Takapuna');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ike Balaban', 11432, '520000321', '370 Askew Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ray Salonga', 11433, '520000322', '12 Patton Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Davis Applegate', 11434, '520000323', '58 Rip Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Fionnula Cartlidge', 11435, '520000324', '80 Francis Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jean-Luc Dunn', 11436, '520000325', '45 Cazale Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('John Myles', 11437, '520000326', '100 Burke Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Pat Shand', 11438, '520000327', '96 Rich Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jim Faithfull', 11439, '520000328', '49 Wilkinson Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Sal Carrere', 11440, '520000329', '94 Plummer Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Christine Crowell', 11441, '520000330', '36 DeVito Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rose Ribisi', 11442, '520000331', '18 Adamstown Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lou Garfunkel', 11443, '520000332', '94 Rain');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Austin Franks', 11444, '520000333', '91 Reeves Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Giancarlo Holy', 11445, '520000334', '66 DiFranco Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ice Madonna', 11446, '520000335', '23 Wagner Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Cledus Moreno', 11447, '520000336', '73rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Morgan Kurtz', 11448, '520000337', '34 Patrick Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Nile Crouch', 11449, '520000338', '19 Sinatra Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Chloe Owen', 11450, '520000339', '61 Rockville Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Juliette Lynch', 11451, '520000340', '52 Denny Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('George Morse', 11452, '520000341', '48 Alice Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ron Affleck', 11453, '520000342', '77 Quinones Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Warren Crowell', 11454, '520000343', '11st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kieran Foley', 11455, '520000344', '445 Paquin Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Buddy Holy', 11456, '520000345', '38 Mexico City Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Sylvester Balaban', 11457, '520000346', '56 Miriam Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Donald Frost', 11458, '520000347', '5 Kurtwood Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Fionnula Skarsgard', 11459, '520000348', '51 Cummings Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kitty Elwes', 11460, '520000349', '28 Bkk');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Maxine Magnuson', 11461, '520000350', '42nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Eddie Craven', 11462, '520000351', '35 Howie Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Norm Masur', 11463, '520000352', '61 Friedrichshafe Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Robert Ruiz', 11464, '520000353', '14 Shelton Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Alex Rea', 11465, '520000354', '43 Suwon Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Keith Weber', 11466, '520000355', '21st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Elle Choice', 11467, '520000356', '62 Wagner Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Praga Donovan', 11468, '520000357', '72 Edwardstown Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Bobby Rooker', 11469, '520000358', '61 Farina Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Willie Kline', 11470, '520000359', '41st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Liev Whitwam', 11471, '520000360', '69 Oshkosh Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Chazz Anderson', 11472, '520000361', '893 Humphrey Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Vanessa Hawkins', 11473, '520000362', '245 Lynn Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Robert Hagar', 11474, '520000363', '45 McFerrin Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Whoopi Matarazzo', 11475, '520000364', '2 Dillane Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kirk Kinnear', 11476, '520000365', '53 Judd Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Henry Robbins', 11477, '520000366', '20 Warley Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Halle Balk', 11478, '520000367', '11 Brickell Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Juliet Pearce', 11479, '520000368', '42 Preston Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Carrie-Anne Cleary', 11480, '520000369', '86 Bethesda Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Don Gere', 11481, '520000370', '83 Winger Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Derek Van Shelton', 11482, '520000371', '14 Furtado Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Minnie Gyllenhaal', 11483, '520000372', '43 Tripplehorn Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rik Paige', 11484, '520000373', '11st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Carole Lapointe', 11485, '520000374', '75 Kurtz Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Tony Estevez', 11486, '520000375', '61st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ron Michael', 11487, '520000376', '85 Cathy Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Geoffrey Cooper', 11488, '520000377', '55 Reeve Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Busta Maxwell', 11489, '520000378', '22 Apple');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Chalee Sanders', 11490, '520000379', '82 Horsham Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Maria Cale', 11491, '520000380', '347 Key Biscayne');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Buffy Strong', 11492, '520000381', '24 Barcelona');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Albertina Rio', 11493, '520000382', '93rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Oded Crimson', 11494, '520000383', '62nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Owen Tisdale', 11495, '520000384', '185 Luongo Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Azucar Chapman', 11496, '520000385', '80 Paquin Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kenneth Margolyes', 11497, '520000386', '83 Southampton Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lennie Thornton', 11498, '520000387', '98 Brasília Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rose Rebhorn', 11499, '520000388', '47 Tobolowsky Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Anthony Butler', 11500, '520000389', '10 Lattimore Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Madeline Cleary', 11501, '520000390', '93 Bacon Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rick Checker', 11502, '520000391', '13 Brent Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Mos Hauer', 11503, '520000392', '74 Rod Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Helen Janney', 11504, '520000393', '70 Holliston Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Benjamin Bradford', 11505, '520000394', '23 Holiday Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Will Schwarzenegger', 11506, '520000395', '943 New Hope Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Billy Bullock', 11507, '520000396', '84 Rickman Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Elvis Tsettos', 11508, '520000397', '93 Northbrook');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Nils Meniketti', 11509, '520000398', '17 Garza Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Nancy Johansen', 11510, '520000399', '33rd Street');
commit;
prompt 400 records committed...
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Martin Loggins', 11511, '520000400', '48 Hughes Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Denis Rivers', 11512, '520000401', '31st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Roger Heston', 11513, '520000402', '34 Wiedlin Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Bobbi Leachman', 11514, '520000403', '635 Dafoe Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Hank Mantegna', 11515, '520000404', '11 Breslin Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Giovanni Paymer', 11516, '520000405', '50 DiFranco Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lesley McDiarmid', 11517, '520000406', '51st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Denise Stanley', 11518, '520000407', '25 Wiest Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Tom Day-Lewis', 11519, '520000408', '1 Garofalo Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lloyd Shaw', 11520, '520000409', '81st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Mekhi Adams', 11521, '520000410', '63 Whitwam Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('David Lee', 11522, '520000411', '72 San Francisco Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Maggie England', 11523, '520000412', '72 Thomson Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Carlos Akins', 11524, '520000413', '61st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Billy Gatlin', 11525, '520000414', '97 Hector Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Winona Costner', 11526, '520000415', '30 Skerritt Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lauren Pepper', 11527, '520000416', '3 Chalee');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Eileen Eldard', 11528, '520000417', '30 Rollins');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Carla McAnally', 11529, '520000418', '40 Solido Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Joaquin Winslet', 11530, '520000419', '45 Kilmer Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Hal Galecki', 11531, '520000420', '26 Shandling Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Elle Skerritt', 11532, '520000421', '79 Aaron Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ice Mann', 11533, '520000422', '14 Allison Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Chalee Domino', 11534, '520000423', '47 Shirley Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Charles Margulies', 11535, '520000424', '70 Laurel Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Karen DeGraw', 11536, '520000425', '17 Tartu Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Andrew Evanswood', 11537, '520000426', '768 Echirolles');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Hector Oldman', 11538, '520000427', '75 Milsons Point Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lorraine Fichtner', 11539, '520000428', '39 Farris Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Phoebe Head', 11540, '520000429', '47 Dale');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Trace Carlisle', 11541, '520000430', '14 Colm Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Shannyn Hopkins', 11542, '520000431', '12 Waldorf Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Herbie Mills', 11543, '520000432', '60 Tampa Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Elizabeth Jackman', 11544, '520000433', '826 Winwood Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Saul Reilly', 11545, '520000434', '79 Gosdin Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Maury Kinski', 11546, '520000435', '87 Charleston Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Coley Arden', 11547, '520000436', '27 Ittigen Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Charlie Wariner', 11548, '520000437', '12 Jenkins Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Liv Cleary', 11549, '520000438', '83 LaSalle Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Nickel Renfro', 11550, '520000439', '38 Kelly Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Nicole Carrere', 11551, '520000440', '66 Simon Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jonatha Blanchett', 11552, '520000441', '32 Jarvis Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Elijah Beckham', 11553, '520000442', '86 Place Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Joely Roth', 11554, '520000443', '98 Judge Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Scott Hayek', 11555, '520000444', '33 Eat World');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jim Byrne', 11556, '520000445', '36 McGriff Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Karen Sawa', 11557, '520000446', '744 Zagreb Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Marlon LaPaglia', 11558, '520000447', '16 Carlin Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Dom Thomas', 11559, '520000448', '72 Michelle Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Curt Wagner', 11560, '520000449', '9 Cocker Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Terrence Bailey', 11561, '520000450', '94 Bradley Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Tilda Cummings', 11562, '520000451', '88 Leonardo Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Nikka Harmon', 11563, '520000452', '32 Johnnie Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Nils Moore', 11564, '520000453', '77 Hurt Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ryan Worrell', 11565, '520000454', '63 Goodman');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Fisher Redgrave', 11566, '520000455', '63rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Bradley Pressly', 11567, '520000456', '17 Gin');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Curtis Foley', 11568, '520000457', '77 Slater Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Toshiro Marley', 11569, '520000458', '25 Goodman Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Bill Shepherd', 11570, '520000459', '62 Depp Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Gordon Sedgwick', 11571, '520000460', '50 San Jose Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kazem Ruiz', 11572, '520000461', '98 Richie Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lena Tippe', 11573, '520000462', '28 Rosario Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Chanté Pesci', 11574, '520000463', '38 Coward Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Charlton Hawthorne', 11575, '520000464', '70 Jonny Lee Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lili Shaye', 11576, '520000465', '43 Porter Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jerry Carrington', 11577, '520000466', '48 Freddie Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Omar Visnjic', 11578, '520000467', '582 Carrey Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Freddie Place', 11579, '520000468', '68 Aidan Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Mel Hauser', 11580, '520000469', '22 Sawa Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Helen Ricci', 11581, '520000470', '703 Bruxelles Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Loren Tolkan', 11582, '520000471', '43 Downey Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Nile Chandler', 11583, '520000472', '33 Garth Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Catherine O''Neill', 11584, '520000473', '68 Maarssen Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Raymond Gellar', 11585, '520000474', '53 Folds');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kim Bandy', 11586, '520000475', '61 English Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Mekhi Crystal', 11587, '520000476', '9 Coquitlam Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Aimee Connery', 11588, '520000477', '57 Domingo Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Maria Lawrence', 11589, '520000478', '43 Joe Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Bryan Reinhold', 11590, '520000479', '39 Weiland Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Johnnie O''Neill', 11591, '520000480', '934 Johnette Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Collective Gayle', 11592, '520000481', '97 Edmunds Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Leo Shatner', 11593, '520000482', '166 Lawrence Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lenny Cetera', 11594, '520000483', '810 Allan Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Regina Studi', 11595, '520000484', '31st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ronny Warburton', 11596, '520000485', '82 Rupert');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Merle Santana', 11597, '520000486', '98 Twilley Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('William Imbruglia', 11598, '520000487', '99 Jeffreys Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Brent Olin', 11599, '520000488', '61st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Tcheky Palin', 11600, '520000489', '51st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Red Drive', 11601, '520000490', '280 Warwick');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Elijah Thornton', 11602, '520000491', '43 Eisenhüttenstadt Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jessica Lorenz', 11603, '520000492', '67 Golden Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Carl Tambor', 11604, '520000493', '44 Roma Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Keith Ferrell', 11605, '520000494', '93 Miko Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Cole Osment', 11606, '520000495', '79 Bridges');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Annie Westerberg', 11607, '520000496', '37 Whitaker Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kathleen Firth', 11608, '520000497', '29 Marty');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Max Rebhorn', 11609, '520000498', '3 Kid Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kelly Tennison', 11610, '520000499', '62 Visnjic Street');
commit;
prompt 500 records committed...
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Maggie Prowse', 11611, '520000500', '60 West Sussex');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Queen Pastore', 11612, '520000501', '64 Cheryl Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Val Pitney', 11613, '520000502', '448 Boone Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('William Westerberg', 11614, '520000503', '42nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kelly Dillane', 11615, '520000504', '59 Pirmasens Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Stephen Benet', 11616, '520000505', '24 Pesci Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Judy Leguizamo', 11617, '520000506', '87 Ingelheim Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ronny Galecki', 11618, '520000507', '701 Swank Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Albert Willard', 11619, '520000508', '118 Stony Point Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Frances Metcalf', 11620, '520000509', '32 Sant Cugat Del Valle Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Geraldine Guzman', 11621, '520000510', '63 Tempest Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rachael Scorsese', 11622, '520000511', '99 Viterelli Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Mindy Osment', 11623, '520000512', '264 Rankin Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Christian Koyana', 11624, '520000513', '832 Appenzell Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('John Lineback', 11625, '520000514', '82 Loveless Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Judge Llewelyn', 11626, '520000515', '486 Trini Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jon Flack', 11627, '520000516', '93rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Blair Torres', 11628, '520000517', '84 Preston');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ewan Pfeiffer', 11629, '520000518', '4 Bachman Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Tal Badalucco', 11630, '520000519', '75 Gerald');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Tamala Peet', 11631, '520000520', '100 Penn Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Deborah Mitra', 11632, '520000521', '963 Lauper');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Allison Sylvian', 11633, '520000522', '72nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Sissy Whitmore', 11634, '520000523', '45 Hewitt Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Morgan Vinton', 11635, '520000524', '1 Nick Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Chloe Ramirez', 11636, '520000525', '421 Feuerstein Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Albertina Rankin', 11637, '520000526', '6 Janney Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('William Warden', 11638, '520000527', '55 Ben');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Danni Rickman', 11639, '520000528', '94 Paltrow Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Stockard Buckingham', 11640, '520000529', '42 Ronny Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Maury Rhames', 11641, '520000530', '89 Skaggs Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Willem Humphrey', 11642, '520000531', '72nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Alessandro Whitmore', 11643, '520000532', '81 Powers Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Faye Cornell', 11644, '520000533', '36 Wiest Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('James Balk', 11645, '520000534', '97 Dianne Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Joshua Kinnear', 11646, '520000535', '27 Neeson Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Goldie Vance', 11647, '520000536', '42nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rosario Oates', 11648, '520000537', '964 Zagreb Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Albertina Dillane', 11649, '520000538', '44 Heatherly');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Isabella Davison', 11650, '520000539', '86 Verwood Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Glenn Arjona', 11651, '520000540', '59 Orleans Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Juliana McCormack', 11652, '520000541', '74 Miguel Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Salma Allison', 11653, '520000542', '1 Julianna Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kyle Moreno', 11654, '520000543', '61 Whitley Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Leslie Sayer', 11655, '520000544', '91 Buckingham');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Geraldine Hartnett', 11656, '520000545', '90 Jerry Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lili Kier', 11657, '520000546', '943 Fountain Hills Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Joy Hewett', 11658, '520000547', '24 Frampton Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jonathan Margulies', 11659, '520000548', '19 Ronny Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Nils Marie', 11660, '520000549', '284 McConaughey Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Russell Tempest', 11661, '520000550', '43 Griffin Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Wes Edmunds', 11662, '520000551', '83 Winona');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rik Candy', 11663, '520000552', '972 Kungki Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Tea Driver', 11664, '520000553', '61 Cloris Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Clint Gray', 11665, '520000554', '82 Tara Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lea Cornell', 11666, '520000555', '57 Voight Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kelli Vannelli', 11667, '520000556', '72nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Vickie Gilliam', 11668, '520000557', '64 Brandt Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Mac Hong', 11669, '520000558', '45 Genève');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Elizabeth Gershon', 11670, '520000559', '53 Middletown Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Saffron Murray', 11671, '520000560', '57 Clark Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Connie Brooke', 11672, '520000561', '98 Devon Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jeff McPherson', 11673, '520000562', '44 Casselberry Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Liv Ferrell', 11674, '520000563', '4 McNeice Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Celia Hagar', 11675, '520000564', '86 Stockholm Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Frankie Swinton', 11676, '520000565', '6 Media Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Temuera Biel', 11677, '520000566', '28 Port Macquarie Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rachid Culkin', 11678, '520000567', '28 Chung Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jackson Austin', 11679, '520000568', '90 Rio Rancho Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Johnette Lapointe', 11680, '520000569', '15 Runcorn Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Vendetta Kirkwood', 11681, '520000570', '49 Hewett Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Vin Lonsdale', 11682, '520000571', '32 Lincoln Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Melanie Austin', 11683, '520000572', '57 O''Hara Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Madeleine Hagar', 11684, '520000573', '90 Leguizamo Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Corey Weaving', 11685, '520000574', '50 Taylor Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Derek Breslin', 11686, '520000575', '53 Freising Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Christina Farina', 11687, '520000576', '63 Thomson Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Allison Dalton', 11688, '520000577', '42 Wichita Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lloyd McDonnell', 11689, '520000578', '454 Ramirez Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Dermot McFerrin', 11690, '520000579', '93 Haysbert Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Sophie Gosdin', 11691, '520000580', '95 Lerner Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Taryn Paxton', 11692, '520000581', '98 Gettysburg');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Giancarlo Moffat', 11693, '520000582', '61st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rufus Allen', 11694, '520000583', '32 Julianne Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Campbell Potter', 11695, '520000584', '677 McGill Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Seann Loveless', 11696, '520000585', '59 Gloria Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Al Glenn', 11697, '520000586', '58 Dustin Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Meg Savage', 11698, '520000587', '52 Lila Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rachid Langella', 11699, '520000588', '8 Gaby Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Holly Blaine', 11700, '520000589', '70 Collin Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Marlon Burns', 11701, '520000590', '350 Fort gordon Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Regina Tierney', 11702, '520000591', '15 Glenn Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Garland Costner', 11703, '520000592', '24 LeVar Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Clea Goldblum', 11704, '520000593', '641 Hank Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kirk Shorter', 11705, '520000594', '20 Minneapolis Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Omar Imbruglia', 11706, '520000595', '46 Horace Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Maureen Giraldo', 11707, '520000596', '93rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Roy Andrews', 11708, '520000597', '31st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Samuel Peterson', 11709, '520000598', '853 Ribisi Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Judd Culkin', 11710, '520000599', '86 Stiles Street');
commit;
prompt 600 records committed...
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rob Goldberg', 11711, '520000600', '13 Rory Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Liam Stuermer', 11712, '520000601', '53rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Beth McDowell', 11713, '520000602', '73 Gunton Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Javon Idle', 11714, '520000603', '60 Jared Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jodie Keeslar', 11715, '520000604', '39 North Yorkshire Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Owen Pleasure', 11716, '520000605', '3 Boyd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Bret McKean', 11717, '520000606', '81st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Etta Lyonne', 11718, '520000607', '18 Clayton Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Cledus Molina', 11719, '520000608', '440 Patricia Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Angelina Mellencamp', 11720, '520000609', '607 Vannelli Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Miles Cromwell', 11721, '520000610', '52nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Chris MacIsaac', 11722, '520000611', '31 Smyrna Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('LeVar Biehn', 11723, '520000612', '478 Nina Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Elijah Derringer', 11724, '520000613', '63rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Sinead Gugino', 11725, '520000614', '26 Archer Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Courtney Berkley', 11726, '520000615', '226 Adelaide Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rosanne Burmester', 11727, '520000616', '69 Miriam Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Solomon Keeslar', 11728, '520000617', '35 Anna Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Graham Olyphant', 11729, '520000618', '92 Brosnan Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Adam Pony', 11730, '520000619', '808 Goodman Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lee Beatty', 11731, '520000620', '87 Diane Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jena Kershaw', 11732, '520000621', '74 Vienna Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jonny Blige', 11733, '520000622', '27 Rufus Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Charles Wen', 11734, '520000623', '20 Lodi Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jim Cromwell', 11735, '520000624', '512 Arquette Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Oro Miller', 11736, '520000625', '69 Oldwick Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jessica Lyonne', 11737, '520000626', '5 Joe Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Shelby Winans', 11738, '520000627', '561 Loeb');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Faye Reeves', 11739, '520000628', '896 Coquitlam Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Alessandro Pride', 11740, '520000629', '42nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Giovanni Gaynor', 11741, '520000630', '441 New boston Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Alan Arquette', 11742, '520000631', '22 Keeslar Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Nathan Knight', 11743, '520000632', '211 Springfield Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Milla Hutton', 11744, '520000633', '44 Niven Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Barry Santa Rosa', 11745, '520000634', '38 Evanswood Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Mos Colman', 11746, '520000635', '40 Cassel Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Brittany McCracken', 11747, '520000636', '427 Moorestown Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Armin Duke', 11748, '520000637', '229 Cleese Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Robert Roberts', 11749, '520000638', '200 Gough Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Spencer Klein', 11750, '520000639', '10 Mandy Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Halle Lang', 11751, '520000640', '97 Garry Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Sal Clooney', 11752, '520000641', '35 Goldblum Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Juliana Hayes', 11753, '520000642', '81 Caan Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jerry Cube', 11754, '520000643', '85 George Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Bradley Lindo', 11755, '520000644', '603 Singletary Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jay Dourif', 11756, '520000645', '98 Celia Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lila Hershey', 11757, '520000646', '47 Dionne Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rowan Ermey', 11758, '520000647', '90 Curtis-Hall Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Chaka Hutton', 11759, '520000648', '73 Taipei Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Eric Sarsgaard', 11760, '520000649', '43 Lynch Road');
commit;
prompt 650 records loaded
prompt Loading SELL...
insert into SELL (seller_id, product_id)
values (11636, 362);
insert into SELL (seller_id, product_id)
values (11668, 226);
insert into SELL (seller_id, product_id)
values (11239, 109);
insert into SELL (seller_id, product_id)
values (11303, 270);
insert into SELL (seller_id, product_id)
values (11447, 187);
insert into SELL (seller_id, product_id)
values (11496, 77);
insert into SELL (seller_id, product_id)
values (11195, 488);
insert into SELL (seller_id, product_id)
values (11758, 487);
insert into SELL (seller_id, product_id)
values (11500, 467);
insert into SELL (seller_id, product_id)
values (11157, 16);
insert into SELL (seller_id, product_id)
values (11374, 490);
insert into SELL (seller_id, product_id)
values (11124, 287);
insert into SELL (seller_id, product_id)
values (11213, 373);
insert into SELL (seller_id, product_id)
values (11512, 177);
insert into SELL (seller_id, product_id)
values (11420, 29);
insert into SELL (seller_id, product_id)
values (11363, 412);
insert into SELL (seller_id, product_id)
values (11589, 311);
insert into SELL (seller_id, product_id)
values (11680, 9);
insert into SELL (seller_id, product_id)
values (11244, 323);
insert into SELL (seller_id, product_id)
values (11184, 129);
insert into SELL (seller_id, product_id)
values (11279, 425);
insert into SELL (seller_id, product_id)
values (11545, 438);
insert into SELL (seller_id, product_id)
values (11566, 3);
insert into SELL (seller_id, product_id)
values (11661, 331);
insert into SELL (seller_id, product_id)
values (11365, 3);
insert into SELL (seller_id, product_id)
values (11722, 247);
insert into SELL (seller_id, product_id)
values (11562, 28);
insert into SELL (seller_id, product_id)
values (11505, 361);
insert into SELL (seller_id, product_id)
values (11407, 240);
insert into SELL (seller_id, product_id)
values (11603, 23);
insert into SELL (seller_id, product_id)
values (11439, 103);
insert into SELL (seller_id, product_id)
values (11468, 436);
insert into SELL (seller_id, product_id)
values (11710, 488);
insert into SELL (seller_id, product_id)
values (11345, 334);
insert into SELL (seller_id, product_id)
values (11463, 445);
insert into SELL (seller_id, product_id)
values (11641, 267);
insert into SELL (seller_id, product_id)
values (11399, 347);
insert into SELL (seller_id, product_id)
values (11301, 52);
insert into SELL (seller_id, product_id)
values (11362, 489);
insert into SELL (seller_id, product_id)
values (11391, 303);
insert into SELL (seller_id, product_id)
values (11414, 175);
insert into SELL (seller_id, product_id)
values (11492, 272);
insert into SELL (seller_id, product_id)
values (11388, 462);
insert into SELL (seller_id, product_id)
values (11289, 170);
insert into SELL (seller_id, product_id)
values (11374, 24);
insert into SELL (seller_id, product_id)
values (11116, 479);
insert into SELL (seller_id, product_id)
values (11152, 403);
insert into SELL (seller_id, product_id)
values (11182, 222);
insert into SELL (seller_id, product_id)
values (11350, 467);
insert into SELL (seller_id, product_id)
values (11352, 302);
insert into SELL (seller_id, product_id)
values (11416, 68);
insert into SELL (seller_id, product_id)
values (11548, 288);
insert into SELL (seller_id, product_id)
values (11408, 355);
insert into SELL (seller_id, product_id)
values (11700, 436);
insert into SELL (seller_id, product_id)
values (11710, 235);
insert into SELL (seller_id, product_id)
values (11651, 52);
insert into SELL (seller_id, product_id)
values (11515, 421);
insert into SELL (seller_id, product_id)
values (11567, 260);
insert into SELL (seller_id, product_id)
values (11554, 448);
insert into SELL (seller_id, product_id)
values (11628, 83);
insert into SELL (seller_id, product_id)
values (11166, 365);
insert into SELL (seller_id, product_id)
values (11237, 54);
insert into SELL (seller_id, product_id)
values (11404, 135);
insert into SELL (seller_id, product_id)
values (11374, 55);
insert into SELL (seller_id, product_id)
values (11315, 293);
insert into SELL (seller_id, product_id)
values (11589, 409);
insert into SELL (seller_id, product_id)
values (11364, 122);
insert into SELL (seller_id, product_id)
values (11412, 85);
insert into SELL (seller_id, product_id)
values (11487, 85);
insert into SELL (seller_id, product_id)
values (11251, 307);
insert into SELL (seller_id, product_id)
values (11553, 104);
insert into SELL (seller_id, product_id)
values (11204, 250);
insert into SELL (seller_id, product_id)
values (11143, 156);
insert into SELL (seller_id, product_id)
values (11595, 295);
insert into SELL (seller_id, product_id)
values (11554, 471);
insert into SELL (seller_id, product_id)
values (11410, 256);
insert into SELL (seller_id, product_id)
values (11417, 146);
insert into SELL (seller_id, product_id)
values (11371, 387);
insert into SELL (seller_id, product_id)
values (11511, 88);
insert into SELL (seller_id, product_id)
values (11627, 256);
insert into SELL (seller_id, product_id)
values (11369, 482);
insert into SELL (seller_id, product_id)
values (11140, 79);
insert into SELL (seller_id, product_id)
values (11658, 401);
insert into SELL (seller_id, product_id)
values (11426, 329);
insert into SELL (seller_id, product_id)
values (11746, 389);
insert into SELL (seller_id, product_id)
values (11235, 22);
insert into SELL (seller_id, product_id)
values (11551, 70);
insert into SELL (seller_id, product_id)
values (11425, 127);
insert into SELL (seller_id, product_id)
values (11322, 257);
insert into SELL (seller_id, product_id)
values (11722, 376);
insert into SELL (seller_id, product_id)
values (11623, 377);
insert into SELL (seller_id, product_id)
values (11158, 146);
insert into SELL (seller_id, product_id)
values (11389, 452);
insert into SELL (seller_id, product_id)
values (11750, 311);
insert into SELL (seller_id, product_id)
values (11201, 163);
insert into SELL (seller_id, product_id)
values (11531, 197);
insert into SELL (seller_id, product_id)
values (11526, 42);
insert into SELL (seller_id, product_id)
values (11537, 132);
insert into SELL (seller_id, product_id)
values (11442, 59);
insert into SELL (seller_id, product_id)
values (11467, 494);
commit;
prompt 100 records committed...
insert into SELL (seller_id, product_id)
values (11574, 361);
insert into SELL (seller_id, product_id)
values (11154, 105);
insert into SELL (seller_id, product_id)
values (11479, 208);
insert into SELL (seller_id, product_id)
values (11745, 433);
insert into SELL (seller_id, product_id)
values (11383, 90);
insert into SELL (seller_id, product_id)
values (11292, 417);
insert into SELL (seller_id, product_id)
values (11438, 358);
insert into SELL (seller_id, product_id)
values (11730, 481);
insert into SELL (seller_id, product_id)
values (11572, 122);
insert into SELL (seller_id, product_id)
values (11475, 307);
insert into SELL (seller_id, product_id)
values (11272, 361);
insert into SELL (seller_id, product_id)
values (11338, 278);
insert into SELL (seller_id, product_id)
values (11407, 433);
insert into SELL (seller_id, product_id)
values (11561, 317);
insert into SELL (seller_id, product_id)
values (11251, 80);
insert into SELL (seller_id, product_id)
values (11750, 342);
insert into SELL (seller_id, product_id)
values (11588, 312);
insert into SELL (seller_id, product_id)
values (11336, 251);
insert into SELL (seller_id, product_id)
values (11529, 198);
insert into SELL (seller_id, product_id)
values (11611, 475);
insert into SELL (seller_id, product_id)
values (11560, 485);
insert into SELL (seller_id, product_id)
values (11446, 245);
insert into SELL (seller_id, product_id)
values (11419, 459);
insert into SELL (seller_id, product_id)
values (11719, 300);
insert into SELL (seller_id, product_id)
values (11736, 195);
insert into SELL (seller_id, product_id)
values (11121, 27);
insert into SELL (seller_id, product_id)
values (11637, 289);
insert into SELL (seller_id, product_id)
values (11308, 442);
insert into SELL (seller_id, product_id)
values (11535, 123);
insert into SELL (seller_id, product_id)
values (11138, 297);
insert into SELL (seller_id, product_id)
values (11712, 312);
insert into SELL (seller_id, product_id)
values (11523, 411);
insert into SELL (seller_id, product_id)
values (11684, 281);
insert into SELL (seller_id, product_id)
values (11629, 318);
insert into SELL (seller_id, product_id)
values (11660, 315);
insert into SELL (seller_id, product_id)
values (11125, 93);
insert into SELL (seller_id, product_id)
values (11691, 271);
insert into SELL (seller_id, product_id)
values (11223, 100);
insert into SELL (seller_id, product_id)
values (11423, 84);
insert into SELL (seller_id, product_id)
values (11353, 409);
insert into SELL (seller_id, product_id)
values (11580, 449);
insert into SELL (seller_id, product_id)
values (11436, 275);
insert into SELL (seller_id, product_id)
values (11324, 149);
insert into SELL (seller_id, product_id)
values (11715, 178);
insert into SELL (seller_id, product_id)
values (11388, 29);
insert into SELL (seller_id, product_id)
values (11344, 143);
insert into SELL (seller_id, product_id)
values (11593, 458);
insert into SELL (seller_id, product_id)
values (11668, 46);
insert into SELL (seller_id, product_id)
values (11689, 35);
insert into SELL (seller_id, product_id)
values (11404, 325);
insert into SELL (seller_id, product_id)
values (11598, 442);
insert into SELL (seller_id, product_id)
values (11702, 153);
insert into SELL (seller_id, product_id)
values (11219, 228);
insert into SELL (seller_id, product_id)
values (11460, 135);
insert into SELL (seller_id, product_id)
values (11402, 469);
insert into SELL (seller_id, product_id)
values (11197, 419);
insert into SELL (seller_id, product_id)
values (11379, 395);
insert into SELL (seller_id, product_id)
values (11391, 41);
insert into SELL (seller_id, product_id)
values (11730, 244);
insert into SELL (seller_id, product_id)
values (11538, 494);
insert into SELL (seller_id, product_id)
values (11347, 58);
insert into SELL (seller_id, product_id)
values (11153, 336);
insert into SELL (seller_id, product_id)
values (11702, 72);
insert into SELL (seller_id, product_id)
values (11455, 358);
insert into SELL (seller_id, product_id)
values (11355, 61);
insert into SELL (seller_id, product_id)
values (11507, 455);
insert into SELL (seller_id, product_id)
values (11483, 65);
insert into SELL (seller_id, product_id)
values (11515, 77);
insert into SELL (seller_id, product_id)
values (11138, 128);
insert into SELL (seller_id, product_id)
values (11540, 417);
insert into SELL (seller_id, product_id)
values (11399, 231);
insert into SELL (seller_id, product_id)
values (11499, 224);
insert into SELL (seller_id, product_id)
values (11342, 262);
insert into SELL (seller_id, product_id)
values (11427, 451);
insert into SELL (seller_id, product_id)
values (11417, 481);
insert into SELL (seller_id, product_id)
values (11721, 463);
insert into SELL (seller_id, product_id)
values (11397, 90);
insert into SELL (seller_id, product_id)
values (11333, 286);
insert into SELL (seller_id, product_id)
values (11641, 46);
insert into SELL (seller_id, product_id)
values (11138, 273);
insert into SELL (seller_id, product_id)
values (11667, 82);
insert into SELL (seller_id, product_id)
values (11652, 64);
insert into SELL (seller_id, product_id)
values (11224, 255);
insert into SELL (seller_id, product_id)
values (11351, 315);
insert into SELL (seller_id, product_id)
values (11400, 212);
insert into SELL (seller_id, product_id)
values (11346, 436);
insert into SELL (seller_id, product_id)
values (11548, 310);
insert into SELL (seller_id, product_id)
values (11543, 6);
insert into SELL (seller_id, product_id)
values (11602, 7);
insert into SELL (seller_id, product_id)
values (11512, 327);
insert into SELL (seller_id, product_id)
values (11314, 377);
insert into SELL (seller_id, product_id)
values (11265, 182);
insert into SELL (seller_id, product_id)
values (11128, 480);
insert into SELL (seller_id, product_id)
values (11204, 303);
insert into SELL (seller_id, product_id)
values (11751, 136);
insert into SELL (seller_id, product_id)
values (11305, 487);
insert into SELL (seller_id, product_id)
values (11587, 43);
insert into SELL (seller_id, product_id)
values (11731, 152);
insert into SELL (seller_id, product_id)
values (11145, 207);
insert into SELL (seller_id, product_id)
values (11352, 368);
commit;
prompt 200 records committed...
insert into SELL (seller_id, product_id)
values (11557, 204);
insert into SELL (seller_id, product_id)
values (11256, 90);
insert into SELL (seller_id, product_id)
values (11423, 19);
insert into SELL (seller_id, product_id)
values (11598, 232);
insert into SELL (seller_id, product_id)
values (11574, 305);
insert into SELL (seller_id, product_id)
values (11133, 131);
insert into SELL (seller_id, product_id)
values (11464, 39);
insert into SELL (seller_id, product_id)
values (11133, 282);
insert into SELL (seller_id, product_id)
values (11683, 77);
insert into SELL (seller_id, product_id)
values (11231, 119);
insert into SELL (seller_id, product_id)
values (11166, 445);
insert into SELL (seller_id, product_id)
values (11581, 2);
insert into SELL (seller_id, product_id)
values (11305, 116);
insert into SELL (seller_id, product_id)
values (11155, 400);
insert into SELL (seller_id, product_id)
values (11336, 203);
insert into SELL (seller_id, product_id)
values (11675, 266);
insert into SELL (seller_id, product_id)
values (11416, 299);
insert into SELL (seller_id, product_id)
values (11499, 181);
insert into SELL (seller_id, product_id)
values (11342, 6);
insert into SELL (seller_id, product_id)
values (11618, 172);
insert into SELL (seller_id, product_id)
values (11251, 490);
insert into SELL (seller_id, product_id)
values (11681, 172);
insert into SELL (seller_id, product_id)
values (11647, 445);
insert into SELL (seller_id, product_id)
values (11209, 174);
insert into SELL (seller_id, product_id)
values (11729, 371);
insert into SELL (seller_id, product_id)
values (11711, 436);
insert into SELL (seller_id, product_id)
values (11276, 85);
insert into SELL (seller_id, product_id)
values (11591, 199);
insert into SELL (seller_id, product_id)
values (11458, 156);
insert into SELL (seller_id, product_id)
values (11655, 133);
insert into SELL (seller_id, product_id)
values (11183, 82);
insert into SELL (seller_id, product_id)
values (11691, 176);
insert into SELL (seller_id, product_id)
values (11499, 438);
insert into SELL (seller_id, product_id)
values (11713, 277);
insert into SELL (seller_id, product_id)
values (11242, 369);
insert into SELL (seller_id, product_id)
values (11204, 455);
insert into SELL (seller_id, product_id)
values (11700, 215);
insert into SELL (seller_id, product_id)
values (11541, 97);
insert into SELL (seller_id, product_id)
values (11189, 389);
insert into SELL (seller_id, product_id)
values (11356, 68);
insert into SELL (seller_id, product_id)
values (11557, 126);
insert into SELL (seller_id, product_id)
values (11402, 412);
insert into SELL (seller_id, product_id)
values (11332, 311);
insert into SELL (seller_id, product_id)
values (11195, 416);
insert into SELL (seller_id, product_id)
values (11749, 412);
insert into SELL (seller_id, product_id)
values (11726, 481);
insert into SELL (seller_id, product_id)
values (11352, 419);
insert into SELL (seller_id, product_id)
values (11395, 476);
insert into SELL (seller_id, product_id)
values (11178, 9);
insert into SELL (seller_id, product_id)
values (11734, 199);
insert into SELL (seller_id, product_id)
values (11746, 171);
insert into SELL (seller_id, product_id)
values (11285, 308);
insert into SELL (seller_id, product_id)
values (11186, 256);
insert into SELL (seller_id, product_id)
values (11689, 225);
insert into SELL (seller_id, product_id)
values (11402, 368);
insert into SELL (seller_id, product_id)
values (11430, 19);
insert into SELL (seller_id, product_id)
values (11375, 346);
insert into SELL (seller_id, product_id)
values (11597, 38);
insert into SELL (seller_id, product_id)
values (11730, 46);
insert into SELL (seller_id, product_id)
values (11393, 126);
insert into SELL (seller_id, product_id)
values (11308, 347);
insert into SELL (seller_id, product_id)
values (11587, 347);
insert into SELL (seller_id, product_id)
values (11718, 437);
insert into SELL (seller_id, product_id)
values (11749, 338);
insert into SELL (seller_id, product_id)
values (11607, 431);
insert into SELL (seller_id, product_id)
values (11347, 473);
insert into SELL (seller_id, product_id)
values (11488, 200);
insert into SELL (seller_id, product_id)
values (11273, 220);
insert into SELL (seller_id, product_id)
values (11188, 245);
insert into SELL (seller_id, product_id)
values (11235, 78);
insert into SELL (seller_id, product_id)
values (11340, 179);
insert into SELL (seller_id, product_id)
values (11640, 265);
insert into SELL (seller_id, product_id)
values (11689, 421);
insert into SELL (seller_id, product_id)
values (11145, 312);
insert into SELL (seller_id, product_id)
values (11486, 425);
insert into SELL (seller_id, product_id)
values (11443, 396);
insert into SELL (seller_id, product_id)
values (11537, 290);
insert into SELL (seller_id, product_id)
values (11695, 417);
insert into SELL (seller_id, product_id)
values (11176, 324);
insert into SELL (seller_id, product_id)
values (11625, 358);
insert into SELL (seller_id, product_id)
values (11753, 188);
insert into SELL (seller_id, product_id)
values (11235, 173);
insert into SELL (seller_id, product_id)
values (11114, 374);
insert into SELL (seller_id, product_id)
values (11526, 12);
insert into SELL (seller_id, product_id)
values (11408, 466);
insert into SELL (seller_id, product_id)
values (11657, 268);
insert into SELL (seller_id, product_id)
values (11364, 152);
insert into SELL (seller_id, product_id)
values (11147, 32);
insert into SELL (seller_id, product_id)
values (11554, 155);
insert into SELL (seller_id, product_id)
values (11586, 110);
insert into SELL (seller_id, product_id)
values (11248, 398);
insert into SELL (seller_id, product_id)
values (11180, 44);
insert into SELL (seller_id, product_id)
values (11411, 238);
insert into SELL (seller_id, product_id)
values (11624, 487);
insert into SELL (seller_id, product_id)
values (11231, 304);
insert into SELL (seller_id, product_id)
values (11451, 122);
insert into SELL (seller_id, product_id)
values (11732, 152);
insert into SELL (seller_id, product_id)
values (11520, 200);
insert into SELL (seller_id, product_id)
values (11604, 402);
insert into SELL (seller_id, product_id)
values (11683, 219);
commit;
prompt 300 records committed...
insert into SELL (seller_id, product_id)
values (11719, 380);
insert into SELL (seller_id, product_id)
values (11598, 22);
insert into SELL (seller_id, product_id)
values (11199, 160);
insert into SELL (seller_id, product_id)
values (11319, 6);
insert into SELL (seller_id, product_id)
values (11171, 252);
insert into SELL (seller_id, product_id)
values (11302, 138);
insert into SELL (seller_id, product_id)
values (11352, 188);
insert into SELL (seller_id, product_id)
values (11668, 90);
insert into SELL (seller_id, product_id)
values (11379, 349);
insert into SELL (seller_id, product_id)
values (11362, 454);
insert into SELL (seller_id, product_id)
values (11449, 149);
insert into SELL (seller_id, product_id)
values (11257, 178);
insert into SELL (seller_id, product_id)
values (11507, 121);
insert into SELL (seller_id, product_id)
values (11119, 322);
insert into SELL (seller_id, product_id)
values (11672, 282);
insert into SELL (seller_id, product_id)
values (11309, 120);
insert into SELL (seller_id, product_id)
values (11519, 104);
insert into SELL (seller_id, product_id)
values (11417, 154);
insert into SELL (seller_id, product_id)
values (11227, 117);
insert into SELL (seller_id, product_id)
values (11176, 355);
insert into SELL (seller_id, product_id)
values (11240, 345);
insert into SELL (seller_id, product_id)
values (11367, 461);
insert into SELL (seller_id, product_id)
values (11167, 304);
insert into SELL (seller_id, product_id)
values (11301, 294);
insert into SELL (seller_id, product_id)
values (11411, 450);
insert into SELL (seller_id, product_id)
values (11315, 315);
insert into SELL (seller_id, product_id)
values (11406, 159);
insert into SELL (seller_id, product_id)
values (11329, 68);
insert into SELL (seller_id, product_id)
values (11539, 301);
insert into SELL (seller_id, product_id)
values (11637, 161);
insert into SELL (seller_id, product_id)
values (11670, 294);
insert into SELL (seller_id, product_id)
values (11199, 206);
insert into SELL (seller_id, product_id)
values (11678, 411);
insert into SELL (seller_id, product_id)
values (11242, 93);
insert into SELL (seller_id, product_id)
values (11192, 467);
insert into SELL (seller_id, product_id)
values (11293, 235);
insert into SELL (seller_id, product_id)
values (11657, 474);
insert into SELL (seller_id, product_id)
values (11645, 8);
insert into SELL (seller_id, product_id)
values (11701, 60);
insert into SELL (seller_id, product_id)
values (11651, 147);
insert into SELL (seller_id, product_id)
values (11651, 38);
insert into SELL (seller_id, product_id)
values (11654, 167);
insert into SELL (seller_id, product_id)
values (11338, 184);
insert into SELL (seller_id, product_id)
values (11555, 293);
insert into SELL (seller_id, product_id)
values (11486, 321);
insert into SELL (seller_id, product_id)
values (11522, 178);
insert into SELL (seller_id, product_id)
values (11632, 17);
insert into SELL (seller_id, product_id)
values (11429, 202);
insert into SELL (seller_id, product_id)
values (11286, 258);
insert into SELL (seller_id, product_id)
values (11614, 357);
insert into SELL (seller_id, product_id)
values (11498, 214);
insert into SELL (seller_id, product_id)
values (11197, 263);
insert into SELL (seller_id, product_id)
values (11518, 101);
insert into SELL (seller_id, product_id)
values (11443, 34);
insert into SELL (seller_id, product_id)
values (11692, 41);
insert into SELL (seller_id, product_id)
values (11619, 351);
insert into SELL (seller_id, product_id)
values (11115, 249);
insert into SELL (seller_id, product_id)
values (11669, 210);
insert into SELL (seller_id, product_id)
values (11491, 108);
insert into SELL (seller_id, product_id)
values (11429, 348);
insert into SELL (seller_id, product_id)
values (11504, 219);
insert into SELL (seller_id, product_id)
values (11264, 196);
insert into SELL (seller_id, product_id)
values (11279, 305);
insert into SELL (seller_id, product_id)
values (11351, 59);
insert into SELL (seller_id, product_id)
values (11561, 249);
insert into SELL (seller_id, product_id)
values (11542, 83);
insert into SELL (seller_id, product_id)
values (11259, 374);
insert into SELL (seller_id, product_id)
values (11322, 42);
insert into SELL (seller_id, product_id)
values (11715, 88);
insert into SELL (seller_id, product_id)
values (11457, 163);
insert into SELL (seller_id, product_id)
values (11517, 132);
insert into SELL (seller_id, product_id)
values (11335, 352);
insert into SELL (seller_id, product_id)
values (11592, 411);
insert into SELL (seller_id, product_id)
values (11713, 247);
insert into SELL (seller_id, product_id)
values (11472, 350);
insert into SELL (seller_id, product_id)
values (11346, 195);
insert into SELL (seller_id, product_id)
values (11597, 441);
insert into SELL (seller_id, product_id)
values (11443, 383);
insert into SELL (seller_id, product_id)
values (11317, 318);
insert into SELL (seller_id, product_id)
values (11546, 445);
insert into SELL (seller_id, product_id)
values (11288, 160);
insert into SELL (seller_id, product_id)
values (11753, 484);
insert into SELL (seller_id, product_id)
values (11547, 25);
insert into SELL (seller_id, product_id)
values (11702, 142);
insert into SELL (seller_id, product_id)
values (11687, 218);
insert into SELL (seller_id, product_id)
values (11177, 367);
insert into SELL (seller_id, product_id)
values (11236, 8);
insert into SELL (seller_id, product_id)
values (11508, 311);
insert into SELL (seller_id, product_id)
values (11142, 11);
insert into SELL (seller_id, product_id)
values (11258, 183);
insert into SELL (seller_id, product_id)
values (11547, 379);
insert into SELL (seller_id, product_id)
values (11307, 269);
insert into SELL (seller_id, product_id)
values (11617, 360);
insert into SELL (seller_id, product_id)
values (11432, 267);
insert into SELL (seller_id, product_id)
values (11487, 494);
insert into SELL (seller_id, product_id)
values (11227, 274);
insert into SELL (seller_id, product_id)
values (11378, 425);
insert into SELL (seller_id, product_id)
values (11437, 404);
insert into SELL (seller_id, product_id)
values (11498, 262);
insert into SELL (seller_id, product_id)
values (11329, 122);
commit;
prompt 400 records committed...
insert into SELL (seller_id, product_id)
values (11373, 196);
insert into SELL (seller_id, product_id)
values (11484, 472);
insert into SELL (seller_id, product_id)
values (11246, 124);
insert into SELL (seller_id, product_id)
values (11476, 120);
insert into SELL (seller_id, product_id)
values (11250, 179);
insert into SELL (seller_id, product_id)
values (11492, 22);
insert into SELL (seller_id, product_id)
values (11343, 196);
insert into SELL (seller_id, product_id)
values (11568, 486);
insert into SELL (seller_id, product_id)
values (11261, 253);
insert into SELL (seller_id, product_id)
values (11345, 219);
insert into SELL (seller_id, product_id)
values (11215, 71);
insert into SELL (seller_id, product_id)
values (11482, 169);
insert into SELL (seller_id, product_id)
values (11613, 156);
insert into SELL (seller_id, product_id)
values (11504, 267);
insert into SELL (seller_id, product_id)
values (11556, 242);
insert into SELL (seller_id, product_id)
values (11395, 11);
insert into SELL (seller_id, product_id)
values (11209, 130);
insert into SELL (seller_id, product_id)
values (11399, 157);
insert into SELL (seller_id, product_id)
values (11628, 232);
insert into SELL (seller_id, product_id)
values (11156, 389);
insert into SELL (seller_id, product_id)
values (11623, 233);
insert into SELL (seller_id, product_id)
values (11419, 365);
insert into SELL (seller_id, product_id)
values (11147, 337);
insert into SELL (seller_id, product_id)
values (11335, 248);
insert into SELL (seller_id, product_id)
values (11378, 312);
insert into SELL (seller_id, product_id)
values (11385, 462);
insert into SELL (seller_id, product_id)
values (11562, 57);
insert into SELL (seller_id, product_id)
values (11381, 482);
insert into SELL (seller_id, product_id)
values (11301, 111);
insert into SELL (seller_id, product_id)
values (11328, 106);
insert into SELL (seller_id, product_id)
values (11525, 146);
insert into SELL (seller_id, product_id)
values (11399, 309);
insert into SELL (seller_id, product_id)
values (11476, 46);
insert into SELL (seller_id, product_id)
values (11334, 436);
insert into SELL (seller_id, product_id)
values (11498, 372);
insert into SELL (seller_id, product_id)
values (11694, 471);
insert into SELL (seller_id, product_id)
values (11490, 148);
insert into SELL (seller_id, product_id)
values (11758, 428);
insert into SELL (seller_id, product_id)
values (11255, 385);
insert into SELL (seller_id, product_id)
values (11372, 413);
insert into SELL (seller_id, product_id)
values (11361, 149);
insert into SELL (seller_id, product_id)
values (11200, 83);
insert into SELL (seller_id, product_id)
values (11325, 261);
insert into SELL (seller_id, product_id)
values (11221, 304);
insert into SELL (seller_id, product_id)
values (11217, 220);
insert into SELL (seller_id, product_id)
values (11350, 54);
insert into SELL (seller_id, product_id)
values (11220, 198);
insert into SELL (seller_id, product_id)
values (11743, 10);
insert into SELL (seller_id, product_id)
values (11656, 380);
insert into SELL (seller_id, product_id)
values (11146, 200);
insert into SELL (seller_id, product_id)
values (11607, 372);
insert into SELL (seller_id, product_id)
values (11563, 435);
insert into SELL (seller_id, product_id)
values (11552, 58);
insert into SELL (seller_id, product_id)
values (11697, 25);
insert into SELL (seller_id, product_id)
values (11325, 459);
insert into SELL (seller_id, product_id)
values (11394, 335);
insert into SELL (seller_id, product_id)
values (11753, 280);
insert into SELL (seller_id, product_id)
values (11177, 1);
insert into SELL (seller_id, product_id)
values (11585, 287);
insert into SELL (seller_id, product_id)
values (11228, 436);
insert into SELL (seller_id, product_id)
values (11664, 83);
insert into SELL (seller_id, product_id)
values (11127, 342);
insert into SELL (seller_id, product_id)
values (11115, 162);
insert into SELL (seller_id, product_id)
values (11132, 62);
insert into SELL (seller_id, product_id)
values (11727, 494);
insert into SELL (seller_id, product_id)
values (11428, 171);
insert into SELL (seller_id, product_id)
values (11742, 349);
insert into SELL (seller_id, product_id)
values (11118, 80);
insert into SELL (seller_id, product_id)
values (11385, 262);
insert into SELL (seller_id, product_id)
values (11489, 55);
insert into SELL (seller_id, product_id)
values (11674, 219);
insert into SELL (seller_id, product_id)
values (11373, 332);
insert into SELL (seller_id, product_id)
values (11643, 149);
insert into SELL (seller_id, product_id)
values (11146, 493);
insert into SELL (seller_id, product_id)
values (11159, 22);
insert into SELL (seller_id, product_id)
values (11559, 418);
insert into SELL (seller_id, product_id)
values (11165, 450);
insert into SELL (seller_id, product_id)
values (11284, 317);
insert into SELL (seller_id, product_id)
values (11695, 339);
insert into SELL (seller_id, product_id)
values (11126, 401);
insert into SELL (seller_id, product_id)
values (11515, 158);
insert into SELL (seller_id, product_id)
values (11570, 429);
insert into SELL (seller_id, product_id)
values (11376, 209);
insert into SELL (seller_id, product_id)
values (11290, 418);
insert into SELL (seller_id, product_id)
values (11385, 232);
insert into SELL (seller_id, product_id)
values (11153, 36);
insert into SELL (seller_id, product_id)
values (11330, 356);
insert into SELL (seller_id, product_id)
values (11531, 205);
insert into SELL (seller_id, product_id)
values (11268, 101);
insert into SELL (seller_id, product_id)
values (11676, 206);
insert into SELL (seller_id, product_id)
values (11149, 133);
insert into SELL (seller_id, product_id)
values (11647, 16);
insert into SELL (seller_id, product_id)
values (11665, 255);
insert into SELL (seller_id, product_id)
values (11560, 411);
insert into SELL (seller_id, product_id)
values (11506, 76);
insert into SELL (seller_id, product_id)
values (11588, 448);
insert into SELL (seller_id, product_id)
values (11344, 47);
insert into SELL (seller_id, product_id)
values (11700, 413);
insert into SELL (seller_id, product_id)
values (11614, 146);
commit;
prompt 499 records loaded
prompt Enabling foreign key constraints for ORDERS...
alter table ORDERS enable constraint SYS_C008645;
prompt Enabling foreign key constraints for INCLUDE_PRODUCTS...
alter table INCLUDE_PRODUCTS enable constraint SYS_C008667;
prompt Enabling foreign key constraints for ORDERDETAILS...
alter table ORDERDETAILS enable constraint SYS_C008662;
prompt Enabling foreign key constraints for PRODUCTS...
alter table PRODUCTS enable constraint SYS_C008680;
prompt Enabling foreign key constraints for REVIEWS...
alter table REVIEWS enable constraint SYS_C008652;
prompt Enabling foreign key constraints for SELL...
alter table SELL enable constraint SYS_C008656;
prompt Enabling triggers for BUYERS...
alter table BUYERS enable all triggers;
prompt Enabling triggers for CATEGORIES...
alter table CATEGORIES enable all triggers;
prompt Enabling triggers for ORDERS...
alter table ORDERS enable all triggers;
prompt Enabling triggers for INCLUDE_PRODUCTS...
alter table INCLUDE_PRODUCTS enable all triggers;
prompt Enabling triggers for ORDERDETAILS...
alter table ORDERDETAILS enable all triggers;
prompt Enabling triggers for PRODUCTS...
alter table PRODUCTS enable all triggers;
prompt Enabling triggers for REVIEWS...
alter table REVIEWS enable all triggers;
prompt Enabling triggers for SELLERS...
alter table SELLERS enable all triggers;
prompt Enabling triggers for SELL...
alter table SELL enable all triggers;

set feedback on
set define on
prompt Done
