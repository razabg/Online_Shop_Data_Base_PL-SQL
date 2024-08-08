prompt PL/SQL Developer Export Tables for user C##RAZ@XE
prompt Created by razab on יום חמישי 08 אוגוסט 2024
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

prompt Creating ORDERDETAILS...
create table ORDERDETAILS
(
  product_id      INTEGER not null,
  delivery_method VARCHAR2(20) not null,
  order_status    VARCHAR2(20)
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

prompt Creating ORDERS...
create table ORDERS
(
  order_id        INTEGER not null,
  order_date      DATE not null,
  tracking_number VARCHAR2(20) not null,
  product_id      INTEGER not null,
  buyer_id        INTEGER not null
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
alter table ORDERS
  add foreign key (PRODUCT_ID)
  references ORDERDETAILS (PRODUCT_ID);
alter table ORDERS
  add foreign key (BUYER_ID)
  references BUYERS (BUYER_ID);
alter table ORDERS
  add constraint CHECK_ORDER_DATE
  check (order_date >= DATE '2023-01-01');

prompt Creating INCLUDE_PRODUCTS...
create table INCLUDE_PRODUCTS
(
  order_id   INTEGER not null,
  product_id INTEGER not null,
  quantity   INTEGER
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
  add foreign key (ORDER_ID, PRODUCT_ID)
  references ORDERS (ORDER_ID, PRODUCT_ID);

prompt Creating PRODUCTS...
create table PRODUCTS
(
  product_id     INTEGER not null,
  product_name   VARCHAR2(200) not null,
  information    VARCHAR2(50),
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
  add foreign key (PRODUCT_ID)
  references PRODUCTS (PRODUCT_ID);
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
alter table SELL
  add foreign key (PRODUCT_ID)
  references PRODUCTS (PRODUCT_ID);

prompt Disabling triggers for BUYERS...
alter table BUYERS disable all triggers;
prompt Disabling triggers for CATEGORIES...
alter table CATEGORIES disable all triggers;
prompt Disabling triggers for ORDERDETAILS...
alter table ORDERDETAILS disable all triggers;
prompt Disabling triggers for ORDERS...
alter table ORDERS disable all triggers;
prompt Disabling triggers for INCLUDE_PRODUCTS...
alter table INCLUDE_PRODUCTS disable all triggers;
prompt Disabling triggers for PRODUCTS...
alter table PRODUCTS disable all triggers;
prompt Disabling triggers for REVIEWS...
alter table REVIEWS disable all triggers;
prompt Disabling triggers for SELLERS...
alter table SELLERS disable all triggers;
prompt Disabling triggers for SELL...
alter table SELL disable all triggers;
prompt Disabling foreign key constraints for ORDERS...
alter table ORDERS disable constraint SYS_C008592;
alter table ORDERS disable constraint SYS_C008593;
prompt Disabling foreign key constraints for INCLUDE_PRODUCTS...
alter table INCLUDE_PRODUCTS disable constraint SYS_C008609;
prompt Disabling foreign key constraints for REVIEWS...
alter table REVIEWS disable constraint SYS_C008599;
alter table REVIEWS disable constraint SYS_C008600;
prompt Disabling foreign key constraints for SELL...
alter table SELL disable constraint SYS_C008604;
alter table SELL disable constraint SYS_C008605;
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
prompt Deleting INCLUDE_PRODUCTS...
delete from INCLUDE_PRODUCTS;
commit;
prompt Deleting ORDERS...
delete from ORDERS;
commit;
prompt Deleting ORDERDETAILS...
delete from ORDERDETAILS;
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
prompt Loading ORDERDETAILS...
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (396, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (176, 'pick up from store', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (249, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (388, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (113, 'pick up from store', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (154, 'pick up from store', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (335, 'pick up from store', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (67, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (207, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (338, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (76, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (178, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (450, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (255, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (28, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (441, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (47, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (431, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (285, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (83, 'home delivery', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (146, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (289, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (302, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (300, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (145, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (494, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (1, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (185, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (294, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (175, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (10, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (234, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (349, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (470, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (293, 'home delivery', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (279, 'home delivery', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (363, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (100, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (99, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (372, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (84, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (283, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (68, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (17, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (457, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (452, 'pick up from store', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (209, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (128, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (49, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (208, 'pick up from store', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (309, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (244, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (262, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (483, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (87, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (358, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (298, 'home delivery', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (152, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (360, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (80, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (444, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (287, 'pick up from store', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (267, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (318, 'home delivery', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (328, 'home delivery', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (367, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (405, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (101, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (333, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (162, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (171, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (97, 'home delivery', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (356, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (88, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (46, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (65, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (340, 'home delivery', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (350, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (74, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (459, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (66, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (436, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (461, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (23, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (57, 'home delivery', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (484, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (361, 'home delivery', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (427, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (260, 'pick up from store', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (129, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (263, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (275, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (140, 'home delivery', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (201, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (134, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (122, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (225, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (482, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (130, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (276, 'pick up spots', 'Shipped');
commit;
prompt 100 records committed...
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (186, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (448, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (331, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (203, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (266, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (475, 'home delivery', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (170, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (195, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (282, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (378, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (222, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (403, 'home delivery', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (286, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (359, 'home delivery', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (366, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (330, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (226, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (36, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (299, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (95, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (337, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (123, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (199, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (292, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (224, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (77, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (144, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (241, 'home delivery', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (291, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (177, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (18, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (306, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (14, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (121, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (278, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (63, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (197, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (420, 'home delivery', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (69, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (490, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (460, 'pick up from store', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (467, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (126, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (307, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (192, 'home delivery', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (212, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (462, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (39, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (387, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (56, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (301, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (264, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (493, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (391, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (281, 'home delivery', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (206, 'home delivery', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (102, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (480, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (142, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (397, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (464, 'home delivery', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (365, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (45, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (165, 'home delivery', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (246, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (316, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (478, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (313, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (20, 'home delivery', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (168, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (114, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (324, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (105, 'home delivery', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (329, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (439, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (85, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (92, 'home delivery', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (139, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (158, 'home delivery', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (362, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (91, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (19, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (236, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (346, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (304, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (109, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (187, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (334, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (491, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (62, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (446, 'home delivery', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (400, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (196, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (110, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (342, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (96, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (370, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (251, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (395, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (402, 'pick up spots', 'Pending');
commit;
prompt 200 records committed...
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (55, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (202, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (107, 'home delivery', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (297, 'home delivery', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (157, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (94, 'pick up from store', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (189, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (53, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (26, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (50, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (81, 'pick up from store', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (25, 'home delivery', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (310, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (6, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (270, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (89, 'pick up from store', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (368, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (254, 'home delivery', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (352, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (413, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (341, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (230, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (314, 'home delivery', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (213, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (408, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (184, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (471, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (492, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (272, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (393, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (111, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (377, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (280, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (269, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (481, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (13, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (215, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (351, 'home delivery', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (188, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (220, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (268, 'pick up from store', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (117, 'home delivery', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (416, 'home delivery', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (355, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (125, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (194, 'home delivery', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (343, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (401, 'home delivery', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (332, 'home delivery', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (15, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (22, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (386, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (216, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (489, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (259, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (41, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (232, 'pick up from store', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (7, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (412, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (423, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (277, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (245, 'home delivery', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (221, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (104, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (354, 'home delivery', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (156, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (229, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (167, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (182, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (317, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (415, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (54, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (72, 'home delivery', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (404, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (425, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (147, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (371, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (274, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (238, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (392, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (52, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (200, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (469, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (252, 'home delivery', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (58, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (449, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (108, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (37, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (410, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (239, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (60, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (271, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (305, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (474, 'home delivery', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (303, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (233, 'pick up from store', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (8, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (223, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (440, 'pick up from store', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (390, 'pick up from store', 'Pending');
commit;
prompt 300 records committed...
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (296, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (385, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (243, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (345, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (409, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (166, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (228, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (321, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (173, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (327, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (477, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (476, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (454, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (486, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (30, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (115, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (437, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (422, 'home delivery', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (426, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (149, 'home delivery', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (455, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (453, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (179, 'home delivery', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (160, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (181, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (311, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (487, 'home delivery', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (59, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (11, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (143, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (137, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (315, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (485, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (375, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (218, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (106, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (376, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (163, 'pick up from store', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (319, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (394, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (398, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (488, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (434, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (421, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (383, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (161, 'pick up from store', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (34, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (473, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (31, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (256, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (214, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (118, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (468, 'home delivery', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (33, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (339, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (479, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (153, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (98, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (90, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (242, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (250, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (204, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (472, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (132, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (399, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (164, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (414, 'home delivery', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (116, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (466, 'home delivery', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (379, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (257, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (308, 'home delivery', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (159, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (430, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (24, 'home delivery', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (71, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (191, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (428, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (172, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (369, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (21, 'home delivery', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (384, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (312, 'pick up spots', 'Pending');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (120, 'pick up from store', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (27, 'pick up spots', 'Shipped');
insert into ORDERDETAILS (product_id, delivery_method, order_status)
values (86, 'pick up spots', 'Shipped');
commit;
prompt 386 records loaded
prompt Loading ORDERS...
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (32421, to_date('09-07-2023', 'dd-mm-yyyy'), 'IBB-034', 491, 10641);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (89411, to_date('18-12-2023', 'dd-mm-yyyy'), 'SW-011', 54, 10520);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (93304, to_date('05-12-2023', 'dd-mm-yyyy'), 'IBB-005', 216, 10682);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (64821, to_date('04-12-2024', 'dd-mm-yyyy'), 'SK-013', 345, 10575);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (84942, to_date('12-10-2024', 'dd-mm-yyyy'), 'CMA-157', 448, 10036);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (10729, to_date('03-05-2023', 'dd-mm-yyyy'), 'CMI-099', 106, 10590);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (95320, to_date('08-09-2024', 'dd-mm-yyyy'), 'CMA-113', 238, 10403);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (29081, to_date('28-03-2023', 'dd-mm-yyyy'), 'CMI-109', 76, 10597);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (78231, to_date('23-08-2024', 'dd-mm-yyyy'), 'ML-028', 375, 10177);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (34196, to_date('03-07-2024', 'dd-mm-yyyy'), 'MB-006', 392, 10368);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (53488, to_date('16-03-2023', 'dd-mm-yyyy'), 'ABB-116', 128, 10013);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (75409, to_date('10-12-2023', 'dd-mm-yyyy'), 'CMI-013', 55, 10144);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (88802, to_date('21-07-2024', 'dd-mm-yyyy'), 'CS-031', 472, 10540);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (53192, to_date('05-09-2023', 'dd-mm-yyyy'), 'CS-055', 441, 10625);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (43454, to_date('25-06-2024', 'dd-mm-yyyy'), 'ABB-113', 171, 10303);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (28902, to_date('16-01-2023', 'dd-mm-yyyy'), 'ABB-098', 7, 10354);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (28460, to_date('08-03-2023', 'dd-mm-yyyy'), 'RD-007', 461, 10488);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (67321, to_date('01-11-2023', 'dd-mm-yyyy'), 'KB-002', 310, 10645);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (78131, to_date('10-04-2024', 'dd-mm-yyyy'), 'ABB-089', 449, 10663);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (31999, to_date('28-04-2023', 'dd-mm-yyyy'), 'UP-001', 303, 10057);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (53995, to_date('04-05-2024', 'dd-mm-yyyy'), 'CMI-094', 96, 10621);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (74834, to_date('01-04-2023', 'dd-mm-yyyy'), 'MB-010', 230, 10355);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (17121, to_date('26-11-2023', 'dd-mm-yyyy'), 'CP-048', 368, 10300);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (18911, to_date('20-04-2024', 'dd-mm-yyyy'), 'CS-032', 13, 10653);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (26991, to_date('27-10-2024', 'dd-mm-yyyy'), 'PT-004', 160, 10319);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (18018, to_date('19-10-2024', 'dd-mm-yyyy'), 'ME-025', 431, 10007);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (47518, to_date('19-07-2024', 'dd-mm-yyyy'), 'ML-013', 450, 10088);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (43028, to_date('02-01-2023', 'dd-mm-yyyy'), 'KB-009', 289, 10106);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (81515, to_date('13-05-2023', 'dd-mm-yyyy'), 'MS-001', 362, 10526);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (35244, to_date('09-05-2023', 'dd-mm-yyyy'), 'HD-023', 14, 10205);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (47177, to_date('25-05-2023', 'dd-mm-yyyy'), 'ME-017', 41, 10477);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (55276, to_date('14-09-2023', 'dd-mm-yyyy'), 'CMA-114', 14, 10335);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (81995, to_date('11-04-2024', 'dd-mm-yyyy'), 'ABB-057', 53, 10293);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (33876, to_date('31-08-2023', 'dd-mm-yyyy'), 'CMI-100', 55, 10410);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (34049, to_date('30-05-2024', 'dd-mm-yyyy'), 'RD-035', 280, 10195);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (93890, to_date('17-05-2023', 'dd-mm-yyyy'), 'CMA-131', 87, 10642);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (96159, to_date('19-11-2023', 'dd-mm-yyyy'), 'CMA-127', 220, 10285);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (50771, to_date('01-11-2023', 'dd-mm-yyyy'), 'ABB-055', 300, 10495);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (57676, to_date('07-03-2023', 'dd-mm-yyyy'), 'CMA-149', 161, 10605);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (68571, to_date('08-02-2024', 'dd-mm-yyyy'), 'RD-029', 69, 10405);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (70359, to_date('20-04-2024', 'dd-mm-yyyy'), 'CS-020', 276, 10036);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (99585, to_date('13-09-2023', 'dd-mm-yyyy'), 'SY-012', 399, 10310);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (71434, to_date('29-07-2023', 'dd-mm-yyyy'), 'ME-031', 188, 10501);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (54496, to_date('12-02-2024', 'dd-mm-yyyy'), 'CMI-080', 400, 10115);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (67137, to_date('23-09-2023', 'dd-mm-yyyy'), 'CMA-053', 129, 10392);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (26608, to_date('14-03-2024', 'dd-mm-yyyy'), 'ABB-107', 69, 10090);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (76627, to_date('23-08-2024', 'dd-mm-yyyy'), 'ABB-079', 376, 10582);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (54152, to_date('10-09-2023', 'dd-mm-yyyy'), 'MS-002', 60, 10552);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (17362, to_date('06-10-2024', 'dd-mm-yyyy'), 'CMI-095', 239, 10375);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (99337, to_date('24-02-2024', 'dd-mm-yyyy'), 'ABB-025', 60, 10512);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (42017, to_date('21-07-2024', 'dd-mm-yyyy'), 'HD-020', 278, 10599);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (97458, to_date('02-09-2024', 'dd-mm-yyyy'), 'ABB-082', 46, 10014);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (31803, to_date('01-12-2024', 'dd-mm-yyyy'), 'CP-033', 122, 10268);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (14514, to_date('18-05-2023', 'dd-mm-yyyy'), 'SK-010', 154, 10688);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (24886, to_date('24-11-2024', 'dd-mm-yyyy'), 'NC-020', 409, 10390);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (43151, to_date('01-10-2024', 'dd-mm-yyyy'), 'MB-035', 63, 10255);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (89461, to_date('04-11-2023', 'dd-mm-yyyy'), 'CMI-095', 100, 10502);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (64854, to_date('06-10-2023', 'dd-mm-yyyy'), 'IBB-022', 108, 10250);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (42230, to_date('12-04-2023', 'dd-mm-yyyy'), 'ABB-103', 296, 10048);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (86898, to_date('28-04-2024', 'dd-mm-yyyy'), 'NC-022', 370, 10394);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (12509, to_date('06-06-2024', 'dd-mm-yyyy'), 'KB-017', 23, 10083);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (36152, to_date('21-01-2024', 'dd-mm-yyyy'), 'SW-010', 91, 10657);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (73166, to_date('08-06-2024', 'dd-mm-yyyy'), 'IBB-033', 450, 10266);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (34101, to_date('23-01-2024', 'dd-mm-yyyy'), 'MT-010', 349, 10287);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (30207, to_date('08-05-2023', 'dd-mm-yyyy'), 'ME-033', 58, 10609);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (69040, to_date('01-01-2023', 'dd-mm-yyyy'), 'CS-099', 341, 10330);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (56163, to_date('27-10-2024', 'dd-mm-yyyy'), 'CMI-100', 436, 10581);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (97881, to_date('07-12-2023', 'dd-mm-yyyy'), 'UP-004', 137, 10002);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (96586, to_date('04-02-2023', 'dd-mm-yyyy'), 'MB-055', 488, 10350);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (92051, to_date('20-09-2023', 'dd-mm-yyyy'), 'CS-014', 330, 10113);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (37172, to_date('07-12-2023', 'dd-mm-yyyy'), 'ML-101', 111, 10393);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (65177, to_date('11-12-2024', 'dd-mm-yyyy'), 'CMA-160', 91, 10411);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (19298, to_date('09-03-2024', 'dd-mm-yyyy'), 'CMA-152', 397, 10193);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (35260, to_date('29-10-2024', 'dd-mm-yyyy'), 'VC-016', 312, 10697);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (17265, to_date('02-04-2024', 'dd-mm-yyyy'), 'SK-004', 212, 10133);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (86472, to_date('01-04-2023', 'dd-mm-yyyy'), 'CP-035', 245, 10299);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (49446, to_date('03-08-2024', 'dd-mm-yyyy'), 'CMA-104', 366, 10687);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (86196, to_date('28-03-2024', 'dd-mm-yyyy'), 'CP-052', 388, 10447);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (60866, to_date('28-02-2024', 'dd-mm-yyyy'), 'CS-004', 439, 10115);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (67069, to_date('23-11-2024', 'dd-mm-yyyy'), 'MB-055', 116, 10268);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (74737, to_date('01-12-2023', 'dd-mm-yyyy'), 'IBB-010', 362, 10424);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (92240, to_date('25-02-2024', 'dd-mm-yyyy'), 'MT-005', 264, 10158);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (78169, to_date('15-08-2024', 'dd-mm-yyyy'), 'MT-005', 285, 10386);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (60423, to_date('24-11-2023', 'dd-mm-yyyy'), 'ABB-095', 365, 10065);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (80820, to_date('02-08-2024', 'dd-mm-yyyy'), 'CMA-110', 259, 10551);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (26247, to_date('20-02-2024', 'dd-mm-yyyy'), 'CP-015', 355, 10386);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (67848, to_date('13-01-2023', 'dd-mm-yyyy'), 'CMA-147', 430, 10165);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (36478, to_date('15-11-2024', 'dd-mm-yyyy'), 'NC-013', 477, 10665);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (68129, to_date('13-06-2024', 'dd-mm-yyyy'), 'SK-017', 228, 10093);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (34594, to_date('18-11-2023', 'dd-mm-yyyy'), 'IBB-037', 493, 10349);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (98636, to_date('23-01-2024', 'dd-mm-yyyy'), 'KB-003', 426, 10532);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (30479, to_date('16-12-2023', 'dd-mm-yyyy'), 'HD-023', 104, 10209);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (64104, to_date('07-01-2024', 'dd-mm-yyyy'), 'HD-022', 402, 10537);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (49376, to_date('12-06-2023', 'dd-mm-yyyy'), 'CP-010', 355, 10506);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (50874, to_date('11-10-2023', 'dd-mm-yyyy'), 'CMI-116', 80, 10211);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (80240, to_date('13-03-2024', 'dd-mm-yyyy'), 'MB-018', 45, 10348);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (83099, to_date('22-11-2023', 'dd-mm-yyyy'), 'MB-056', 216, 10512);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (48980, to_date('11-08-2023', 'dd-mm-yyyy'), 'CP-036', 197, 10635);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (61636, to_date('07-01-2024', 'dd-mm-yyyy'), 'CMI-013', 441, 10357);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (12313, to_date('07-03-2024', 'dd-mm-yyyy'), 'ABB-054', 292, 10567);
commit;
prompt 100 records committed...
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (88851, to_date('15-06-2024', 'dd-mm-yyyy'), 'CMA-127', 405, 10045);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (93733, to_date('17-03-2023', 'dd-mm-yyyy'), 'MS-006', 397, 10086);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (29492, to_date('18-03-2024', 'dd-mm-yyyy'), 'CS-031', 402, 10130);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (60066, to_date('29-01-2023', 'dd-mm-yyyy'), 'IBB-013', 282, 10177);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (36835, to_date('21-06-2024', 'dd-mm-yyyy'), 'sy-006', 207, 10500);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (95873, to_date('07-12-2024', 'dd-mm-yyyy'), 'CMA-134', 34, 10068);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (67545, to_date('10-08-2024', 'dd-mm-yyyy'), 'CS-066', 121, 10042);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (79085, to_date('02-11-2023', 'dd-mm-yyyy'), 'ME-019', 62, 10598);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (96364, to_date('15-08-2023', 'dd-mm-yyyy'), 'ABB-095', 121, 10421);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (25532, to_date('10-08-2023', 'dd-mm-yyyy'), 'ML-001', 143, 10307);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (35798, to_date('08-03-2023', 'dd-mm-yyyy'), 'NC-022', 187, 10087);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (97921, to_date('06-10-2024', 'dd-mm-yyyy'), 'SK-004', 266, 10687);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (94755, to_date('18-08-2024', 'dd-mm-yyyy'), 'VC-012', 172, 10329);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (16970, to_date('12-05-2023', 'dd-mm-yyyy'), 'IBB-014', 307, 10076);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (86468, to_date('07-02-2023', 'dd-mm-yyyy'), 'SC-009', 262, 10187);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (14619, to_date('02-03-2024', 'dd-mm-yyyy'), 'ML-018', 434, 10465);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (38434, to_date('12-01-2023', 'dd-mm-yyyy'), 'CMA-154', 384, 10261);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (41772, to_date('11-09-2024', 'dd-mm-yyyy'), 'Ml-009', 23, 10490);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (38329, to_date('05-02-2024', 'dd-mm-yyyy'), 'CP-002', 469, 10143);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (52010, to_date('29-04-2023', 'dd-mm-yyyy'), 'FM-006', 221, 10052);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (78300, to_date('17-03-2023', 'dd-mm-yyyy'), 'IBB-108', 421, 10635);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (98220, to_date('24-11-2024', 'dd-mm-yyyy'), 'YS-006', 412, 10207);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (98687, to_date('12-07-2023', 'dd-mm-yyyy'), 'CMA-104', 196, 10644);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (97225, to_date('24-06-2023', 'dd-mm-yyyy'), 'CS-015', 203, 10422);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (19197, to_date('02-10-2023', 'dd-mm-yyyy'), 'UP-020', 86, 10386);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (88572, to_date('13-10-2023', 'dd-mm-yyyy'), 'CMI-105', 371, 10687);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (74071, to_date('04-08-2023', 'dd-mm-yyyy'), 'MT-010', 331, 10082);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (33410, to_date('20-01-2023', 'dd-mm-yyyy'), 'RD-027', 331, 10132);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (25854, to_date('13-10-2023', 'dd-mm-yyyy'), 'VC-004', 168, 10508);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (18464, to_date('21-03-2023', 'dd-mm-yyyy'), 'CMA-110', 254, 10205);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (83240, to_date('23-05-2023', 'dd-mm-yyyy'), 'KB-008', 362, 10281);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (44118, to_date('12-11-2023', 'dd-mm-yyyy'), 'ME-022', 313, 10584);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (60109, to_date('15-04-2024', 'dd-mm-yyyy'), 'RD-029', 365, 10290);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (95139, to_date('02-06-2023', 'dd-mm-yyyy'), 'NC-025', 375, 10103);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (48598, to_date('28-04-2023', 'dd-mm-yyyy'), 'MS-006', 67, 10144);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (73310, to_date('28-06-2023', 'dd-mm-yyyy'), 'ABB-109', 161, 10325);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (16785, to_date('07-02-2023', 'dd-mm-yyyy'), 'PT-002', 262, 10342);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (53732, to_date('20-06-2023', 'dd-mm-yyyy'), 'ABB-083', 1, 10041);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (34614, to_date('17-07-2023', 'dd-mm-yyyy'), 'YS-022', 408, 10455);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (76488, to_date('16-07-2023', 'dd-mm-yyyy'), 'CMI-087', 83, 10398);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (28052, to_date('06-08-2024', 'dd-mm-yyyy'), 'ML-015', 302, 10046);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (33352, to_date('09-01-2024', 'dd-mm-yyyy'), 'CMI-099', 427, 10476);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (14333, to_date('24-11-2024', 'dd-mm-yyyy'), 'ML-015', 383, 10599);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (20880, to_date('26-01-2024', 'dd-mm-yyyy'), 'CMI-100', 185, 10201);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (68614, to_date('05-09-2023', 'dd-mm-yyyy'), 'SC-003', 343, 10360);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (37128, to_date('16-09-2024', 'dd-mm-yyyy'), 'CS-048', 369, 10681);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (97577, to_date('28-02-2023', 'dd-mm-yyyy'), 'ABB-081', 303, 10308);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (55177, to_date('19-10-2024', 'dd-mm-yyyy'), 'CMA-162', 367, 10604);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (86571, to_date('20-03-2024', 'dd-mm-yyyy'), 'NC-010', 164, 10693);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (72989, to_date('15-02-2023', 'dd-mm-yyyy'), 'ABB-108', 461, 10388);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (26933, to_date('25-11-2023', 'dd-mm-yyyy'), 'CMA-063', 251, 10114);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (31772, to_date('31-05-2024', 'dd-mm-yyyy'), 'CMI-086', 87, 10442);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (17304, to_date('17-06-2024', 'dd-mm-yyyy'), 'CS-057', 214, 10402);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (34366, to_date('22-12-2024', 'dd-mm-yyyy'), 'CMA-070', 200, 10001);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (10117, to_date('05-11-2023', 'dd-mm-yyyy'), 'KB-004', 484, 10683);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (16989, to_date('16-08-2023', 'dd-mm-yyyy'), 'CMI-086', 145, 10688);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (50219, to_date('17-07-2024', 'dd-mm-yyyy'), 'KB-009', 91, 10284);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (22551, to_date('31-03-2023', 'dd-mm-yyyy'), 'ABB-100', 101, 10130);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (29804, to_date('26-01-2023', 'dd-mm-yyyy'), 'CP-036', 111, 10662);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (27241, to_date('23-03-2024', 'dd-mm-yyyy'), 'CS-015', 95, 10663);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (10687, to_date('09-09-2023', 'dd-mm-yyyy'), 'MB-017', 415, 10284);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (34920, to_date('13-12-2024', 'dd-mm-yyyy'), 'IBB-013', 454, 10639);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (14527, to_date('11-11-2024', 'dd-mm-yyyy'), 'IBB-013', 99, 10557);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (41626, to_date('17-11-2024', 'dd-mm-yyyy'), 'IBB-041', 450, 10236);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (72050, to_date('14-03-2023', 'dd-mm-yyyy'), 'MB-056', 17, 10307);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (35742, to_date('17-05-2024', 'dd-mm-yyyy'), 'IBB-010', 294, 10301);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (36735, to_date('05-08-2024', 'dd-mm-yyyy'), 'IBB-042', 278, 10032);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (13886, to_date('23-10-2024', 'dd-mm-yyyy'), 'CS-043', 66, 10439);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (84999, to_date('26-10-2023', 'dd-mm-yyyy'), 'MB-045', 271, 10031);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (98803, to_date('14-04-2024', 'dd-mm-yyyy'), 'CMA-135', 204, 10404);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (86598, to_date('25-06-2023', 'dd-mm-yyyy'), 'YS-023', 161, 10689);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (79243, to_date('01-03-2023', 'dd-mm-yyyy'), 'VC-013', 251, 10675);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (54210, to_date('24-07-2024', 'dd-mm-yyyy'), 'ABB-106', 350, 10066);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (63546, to_date('11-02-2023', 'dd-mm-yyyy'), 'YS-006', 312, 10460);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (72661, to_date('08-07-2023', 'dd-mm-yyyy'), 'YS-020', 270, 10670);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (94028, to_date('26-03-2024', 'dd-mm-yyyy'), 'CMI-080', 162, 10016);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (84546, to_date('12-08-2024', 'dd-mm-yyyy'), 'IBB-112', 483, 10670);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (58965, to_date('11-07-2024', 'dd-mm-yyyy'), 'CMA-164', 408, 10212);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (92941, to_date('22-06-2024', 'dd-mm-yyyy'), 'sy-006', 343, 10496);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (98633, to_date('10-04-2023', 'dd-mm-yyyy'), 'ABB-108', 275, 10409);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (31682, to_date('21-05-2024', 'dd-mm-yyyy'), 'VC-016', 479, 10048);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (31951, to_date('28-05-2024', 'dd-mm-yyyy'), 'MT-009', 170, 10617);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (52547, to_date('18-04-2024', 'dd-mm-yyyy'), 'MB-006', 202, 10531);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (76698, to_date('08-02-2024', 'dd-mm-yyyy'), 'UP-011', 222, 10024);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (14508, to_date('30-04-2024', 'dd-mm-yyyy'), 'CMI-075', 236, 10696);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (39327, to_date('01-09-2024', 'dd-mm-yyyy'), 'CMI-068', 218, 10182);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (66442, to_date('17-09-2024', 'dd-mm-yyyy'), 'HD-020', 289, 10037);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (16037, to_date('14-04-2024', 'dd-mm-yyyy'), 'MB-051', 110, 10149);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (89133, to_date('30-07-2024', 'dd-mm-yyyy'), 'CMI-087', 489, 10240);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (25284, to_date('29-11-2023', 'dd-mm-yyyy'), 'NC-001', 394, 10666);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (48407, to_date('15-06-2024', 'dd-mm-yyyy'), 'VC-048', 221, 10254);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (39265, to_date('20-12-2023', 'dd-mm-yyyy'), 'ML-018', 275, 10175);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (16847, to_date('19-01-2023', 'dd-mm-yyyy'), 'MB-048', 383, 10107);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (78429, to_date('08-05-2023', 'dd-mm-yyyy'), 'ME-020', 36, 10665);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (59836, to_date('20-11-2024', 'dd-mm-yyyy'), 'IBB-043', 341, 10126);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (34578, to_date('13-04-2023', 'dd-mm-yyyy'), 'MB-010', 399, 10244);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (80892, to_date('27-01-2024', 'dd-mm-yyyy'), 'CMA-063', 259, 10424);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (25178, to_date('04-01-2023', 'dd-mm-yyyy'), 'ABB-001', 340, 10566);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (44430, to_date('24-05-2023', 'dd-mm-yyyy'), 'IBB-021', 452, 10055);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (39681, to_date('03-05-2023', 'dd-mm-yyyy'), 'ABB-116', 202, 10462);
commit;
prompt 200 records committed...
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (59354, to_date('17-02-2024', 'dd-mm-yyyy'), 'HD-044', 84, 10111);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (28704, to_date('28-08-2023', 'dd-mm-yyyy'), 'YS-029', 162, 10519);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (27399, to_date('22-05-2024', 'dd-mm-yyyy'), 'ML-017', 479, 10555);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (44314, to_date('06-09-2024', 'dd-mm-yyyy'), 'KB-015', 257, 10488);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (54064, to_date('06-11-2023', 'dd-mm-yyyy'), 'CP-043', 218, 10344);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (15160, to_date('31-05-2024', 'dd-mm-yyyy'), 'KB-004', 249, 10565);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (80253, to_date('16-04-2024', 'dd-mm-yyyy'), 'CMA-071', 492, 10336);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (59350, to_date('06-05-2023', 'dd-mm-yyyy'), 'SC-010', 84, 10647);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (57814, to_date('09-10-2023', 'dd-mm-yyyy'), 'CMA-158', 55, 10590);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (91392, to_date('21-07-2024', 'dd-mm-yyyy'), 'CMA-064', 184, 10330);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (94784, to_date('09-04-2023', 'dd-mm-yyyy'), 'CP-049', 143, 10641);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (62930, to_date('21-03-2023', 'dd-mm-yyyy'), 'CP-005', 222, 10341);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (24755, to_date('25-01-2024', 'dd-mm-yyyy'), 'CP-015', 18, 10433);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (90870, to_date('01-06-2024', 'dd-mm-yyyy'), 'CP-047', 292, 10062);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (62338, to_date('28-02-2023', 'dd-mm-yyyy'), 'NC-014', 448, 10416);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (86622, to_date('08-01-2024', 'dd-mm-yyyy'), 'CS-078', 144, 10149);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (71306, to_date('20-09-2024', 'dd-mm-yyyy'), 'ABB-108', 276, 10250);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (97053, to_date('10-12-2024', 'dd-mm-yyyy'), 'MB-010', 385, 10075);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (46956, to_date('08-05-2023', 'dd-mm-yyyy'), 'CP-017', 146, 10688);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (97040, to_date('03-07-2024', 'dd-mm-yyyy'), 'ABB-106', 22, 10234);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (97429, to_date('01-05-2023', 'dd-mm-yyyy'), 'ABB-010', 370, 10315);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (35893, to_date('07-10-2023', 'dd-mm-yyyy'), 'CMI-102', 68, 10024);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (53489, to_date('01-01-2023', 'dd-mm-yyyy'), 'CMA-135', 421, 10280);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (70921, to_date('11-03-2023', 'dd-mm-yyyy'), 'ABB-001', 437, 10416);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (30610, to_date('05-02-2024', 'dd-mm-yyyy'), 'VC-045', 337, 10124);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (51727, to_date('09-05-2024', 'dd-mm-yyyy'), 'CS-021', 17, 10331);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (14278, to_date('14-06-2024', 'dd-mm-yyyy'), 'IBB-019', 152, 10176);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (54121, to_date('12-04-2023', 'dd-mm-yyyy'), 'CMI-081', 369, 10461);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (27386, to_date('28-01-2024', 'dd-mm-yyyy'), 'IBB-039', 267, 10674);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (73234, to_date('27-02-2023', 'dd-mm-yyyy'), 'NC-012', 386, 10534);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (50490, to_date('11-02-2023', 'dd-mm-yyyy'), 'IBB-112', 184, 10446);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (17484, to_date('07-01-2023', 'dd-mm-yyyy'), 'SK-004', 134, 10000);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (79762, to_date('02-05-2023', 'dd-mm-yyyy'), 'ABB-055', 159, 10652);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (58716, to_date('30-03-2024', 'dd-mm-yyyy'), 'CMA-107', 421, 10022);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (16706, to_date('05-10-2023', 'dd-mm-yyyy'), 'CMI-112', 99, 10357);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (65077, to_date('21-03-2023', 'dd-mm-yyyy'), 'NC-027', 493, 10481);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (26371, to_date('26-01-2024', 'dd-mm-yyyy'), 'VC-031', 334, 10093);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (92398, to_date('12-05-2023', 'dd-mm-yyyy'), 'HD-036', 95, 10492);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (59862, to_date('01-07-2023', 'dd-mm-yyyy'), 'CMA-147', 192, 10651);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (42738, to_date('19-02-2024', 'dd-mm-yyyy'), 'SW-005', 421, 10521);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (90712, to_date('07-04-2024', 'dd-mm-yyyy'), 'YS-004', 387, 10031);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (65974, to_date('08-12-2023', 'dd-mm-yyyy'), 'RD-030', 215, 10520);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (76113, to_date('18-04-2024', 'dd-mm-yyyy'), 'ME-016', 243, 10075);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (47418, to_date('03-06-2024', 'dd-mm-yyyy'), 'CMI-081', 271, 10001);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (21304, to_date('24-01-2024', 'dd-mm-yyyy'), 'CP-019', 184, 10155);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (52112, to_date('14-12-2023', 'dd-mm-yyyy'), 'ML-003', 159, 10157);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (21751, to_date('28-05-2024', 'dd-mm-yyyy'), 'UP-017', 307, 10158);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (30290, to_date('07-06-2023', 'dd-mm-yyyy'), 'RD-038', 201, 10426);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (61123, to_date('27-04-2023', 'dd-mm-yyyy'), 'MB-010', 246, 10127);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (69145, to_date('05-03-2023', 'dd-mm-yyyy'), 'IBB-032', 172, 10676);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (86736, to_date('09-07-2024', 'dd-mm-yyyy'), 'CS-004', 167, 10210);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (39070, to_date('28-06-2024', 'dd-mm-yyyy'), 'VC-015', 22, 10454);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (66133, to_date('22-07-2023', 'dd-mm-yyyy'), 'CMA-099', 306, 10627);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (28661, to_date('14-09-2024', 'dd-mm-yyyy'), 'CMA-068', 300, 10230);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (31945, to_date('03-01-2023', 'dd-mm-yyyy'), 'ABB-064', 441, 10374);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (57554, to_date('18-06-2023', 'dd-mm-yyyy'), 'ABB-056', 262, 10342);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (45286, to_date('31-10-2023', 'dd-mm-yyyy'), 'IBB-005', 453, 10359);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (50211, to_date('25-04-2023', 'dd-mm-yyyy'), 'SW-002', 200, 10308);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (73754, to_date('26-01-2023', 'dd-mm-yyyy'), 'MB-004', 345, 10635);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (42806, to_date('29-03-2023', 'dd-mm-yyyy'), 'CMI-107', 26, 10580);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (16814, to_date('26-08-2024', 'dd-mm-yyyy'), 'UP-001', 461, 10095);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (89856, to_date('27-07-2023', 'dd-mm-yyyy'), 'MB-043', 454, 10286);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (52003, to_date('08-03-2023', 'dd-mm-yyyy'), 'MB-012', 259, 10000);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (62993, to_date('17-06-2023', 'dd-mm-yyyy'), 'MB-058', 264, 10419);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (68166, to_date('04-07-2024', 'dd-mm-yyyy'), 'CMI-114', 109, 10558);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (11768, to_date('15-02-2023', 'dd-mm-yyyy'), 'CMA-063', 111, 10224);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (29986, to_date('13-08-2024', 'dd-mm-yyyy'), 'MB-035', 276, 10188);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (11309, to_date('20-01-2023', 'dd-mm-yyyy'), 'CMI-105', 114, 10088);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (89424, to_date('12-02-2024', 'dd-mm-yyyy'), 'HD-022', 184, 10683);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (84618, to_date('20-04-2023', 'dd-mm-yyyy'), 'YS-028', 139, 10043);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (97522, to_date('12-06-2024', 'dd-mm-yyyy'), 'NC-027', 396, 10185);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (13990, to_date('01-01-2024', 'dd-mm-yyyy'), 'ME-017', 296, 10175);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (22564, to_date('01-01-2024', 'dd-mm-yyyy'), 'YS-023', 242, 10184);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (16934, to_date('24-03-2023', 'dd-mm-yyyy'), 'Ml-009', 335, 10193);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (50716, to_date('01-11-2024', 'dd-mm-yyyy'), 'CS-042', 47, 10372);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (62854, to_date('01-11-2024', 'dd-mm-yyyy'), 'MB-012', 449, 10220);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (51378, to_date('21-06-2023', 'dd-mm-yyyy'), 'ABB-080', 163, 10032);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (68201, to_date('16-09-2024', 'dd-mm-yyyy'), 'UP-004', 236, 10684);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (94519, to_date('23-12-2023', 'dd-mm-yyyy'), 'CMA-146', 299, 10112);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (35351, to_date('11-04-2023', 'dd-mm-yyyy'), 'CS-024', 107, 10128);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (89419, to_date('05-08-2023', 'dd-mm-yyyy'), 'MT-016', 195, 10217);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (54868, to_date('21-02-2023', 'dd-mm-yyyy'), 'CP-033', 58, 10458);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (46640, to_date('06-07-2024', 'dd-mm-yyyy'), 'ML-017', 46, 10170);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (27612, to_date('07-08-2023', 'dd-mm-yyyy'), 'IBB-012', 476, 10510);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (15800, to_date('13-04-2023', 'dd-mm-yyyy'), 'ABB-069', 376, 10649);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (13024, to_date('09-07-2024', 'dd-mm-yyyy'), 'ME-026', 221, 10611);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (33950, to_date('18-10-2023', 'dd-mm-yyyy'), 'CMI-111', 423, 10492);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (48416, to_date('31-12-2024', 'dd-mm-yyyy'), 'CMI-013', 486, 10321);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (61216, to_date('16-01-2024', 'dd-mm-yyyy'), 'ABB-081', 272, 10019);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (91931, to_date('27-12-2024', 'dd-mm-yyyy'), 'VC-023', 187, 10493);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (24940, to_date('17-10-2024', 'dd-mm-yyyy'), 'CMI-088', 130, 10172);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (34593, to_date('10-09-2023', 'dd-mm-yyyy'), 'SK-014', 6, 10127);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (48991, to_date('16-07-2023', 'dd-mm-yyyy'), 'VC-037', 33, 10229);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (65144, to_date('20-11-2023', 'dd-mm-yyyy'), 'HD-017', 229, 10355);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (64340, to_date('22-01-2023', 'dd-mm-yyyy'), 'ME-009', 167, 10283);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (90810, to_date('02-12-2023', 'dd-mm-yyyy'), 'CS-068', 345, 10646);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (88538, to_date('04-07-2024', 'dd-mm-yyyy'), 'NC-020', 177, 10361);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (38454, to_date('15-10-2023', 'dd-mm-yyyy'), 'IBB-026', 341, 10606);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (38487, to_date('07-07-2023', 'dd-mm-yyyy'), 'HD-036', 361, 10636);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (69197, to_date('17-08-2023', 'dd-mm-yyyy'), 'CS-014', 453, 10324);
commit;
prompt 300 records committed...
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (31040, to_date('29-02-2024', 'dd-mm-yyyy'), 'ML-038', 209, 10040);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (86336, to_date('26-06-2023', 'dd-mm-yyyy'), 'ABB-116', 84, 10519);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (72547, to_date('23-06-2023', 'dd-mm-yyyy'), 'CMI-104', 140, 10626);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (56814, to_date('28-12-2024', 'dd-mm-yyyy'), 'CMA-160', 369, 10158);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (59727, to_date('24-08-2023', 'dd-mm-yyyy'), 'CP-019', 214, 10019);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (81152, to_date('21-05-2024', 'dd-mm-yyyy'), 'CS-072', 177, 10080);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (73163, to_date('12-09-2024', 'dd-mm-yyyy'), 'HD-035', 255, 10450);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (31397, to_date('21-07-2024', 'dd-mm-yyyy'), 'IBB-022', 274, 10271);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (39556, to_date('26-08-2023', 'dd-mm-yyyy'), 'CMI-119', 383, 10581);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (11815, to_date('16-04-2023', 'dd-mm-yyyy'), 'CS-014', 181, 10474);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (12649, to_date('04-11-2023', 'dd-mm-yyyy'), 'RD-037', 123, 10603);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (28363, to_date('23-02-2024', 'dd-mm-yyyy'), 'CS-019', 412, 10286);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (43681, to_date('16-10-2024', 'dd-mm-yyyy'), 'CMA-135', 299, 10643);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (31139, to_date('11-01-2023', 'dd-mm-yyyy'), 'CS-024', 83, 10264);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (53308, to_date('24-02-2023', 'dd-mm-yyyy'), 'CMI-116', 28, 10524);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (24554, to_date('06-05-2024', 'dd-mm-yyyy'), 'UP-001', 484, 10288);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (86518, to_date('29-10-2023', 'dd-mm-yyyy'), 'CS-059', 187, 10607);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (33577, to_date('04-12-2024', 'dd-mm-yyyy'), 'CMA-127', 350, 10590);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (82959, to_date('21-09-2023', 'dd-mm-yyyy'), 'CMA-141', 477, 10204);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (26665, to_date('07-09-2024', 'dd-mm-yyyy'), 'MB-052', 7, 10032);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (85771, to_date('20-04-2023', 'dd-mm-yyyy'), 'CS-099', 228, 10289);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (27591, to_date('15-07-2023', 'dd-mm-yyyy'), 'RD-007', 359, 10005);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (55297, to_date('13-03-2024', 'dd-mm-yyyy'), 'CP-013', 477, 10401);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (64847, to_date('22-04-2023', 'dd-mm-yyyy'), 'MB-062', 426, 10567);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (18259, to_date('27-09-2024', 'dd-mm-yyyy'), 'ABB-095', 409, 10222);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (69357, to_date('01-09-2024', 'dd-mm-yyyy'), 'MB-043', 65, 10320);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (31150, to_date('25-03-2024', 'dd-mm-yyyy'), 'RD-026', 90, 10026);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (84445, to_date('27-04-2023', 'dd-mm-yyyy'), 'CS-042', 7, 10668);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (76883, to_date('23-12-2023', 'dd-mm-yyyy'), 'KB-009', 228, 10121);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (77017, to_date('11-02-2024', 'dd-mm-yyyy'), 'VC-031', 309, 10225);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (99240, to_date('16-07-2024', 'dd-mm-yyyy'), 'HD-023', 285, 10681);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (21329, to_date('12-07-2023', 'dd-mm-yyyy'), 'IBB-034', 107, 10294);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (28574, to_date('02-09-2023', 'dd-mm-yyyy'), 'MS-004', 391, 10342);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (47223, to_date('27-01-2023', 'dd-mm-yyyy'), 'IBB-108', 30, 10517);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (17535, to_date('16-12-2023', 'dd-mm-yyyy'), 'CP-020', 339, 10479);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (98818, to_date('26-10-2023', 'dd-mm-yyyy'), 'CMA-099', 455, 10330);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (55587, to_date('31-08-2024', 'dd-mm-yyyy'), 'ABB-011', 306, 10487);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (48160, to_date('10-10-2024', 'dd-mm-yyyy'), 'CP-020', 129, 10137);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (58803, to_date('25-03-2024', 'dd-mm-yyyy'), 'CMA-111', 393, 10065);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (56617, to_date('03-11-2023', 'dd-mm-yyyy'), 'IBB-026', 221, 10659);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (74947, to_date('04-04-2024', 'dd-mm-yyyy'), 'KB-008', 58, 10628);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (15792, to_date('16-03-2023', 'dd-mm-yyyy'), 'ML-102', 297, 10205);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (66436, to_date('04-01-2024', 'dd-mm-yyyy'), 'CS-008', 189, 10521);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (94789, to_date('13-04-2024', 'dd-mm-yyyy'), 'CP-024', 54, 10195);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (43430, to_date('12-12-2023', 'dd-mm-yyyy'), 'ME-019', 370, 10357);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (32532, to_date('06-06-2023', 'dd-mm-yyyy'), 'ABB-062', 305, 10512);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (49160, to_date('13-10-2023', 'dd-mm-yyyy'), 'RD-023', 453, 10324);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (38191, to_date('26-05-2024', 'dd-mm-yyyy'), 'CMI-094', 369, 10557);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (87903, to_date('15-10-2023', 'dd-mm-yyyy'), 'CMA-134', 324, 10084);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (80069, to_date('11-07-2023', 'dd-mm-yyyy'), 'CS-012', 153, 10390);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (85708, to_date('04-03-2024', 'dd-mm-yyyy'), 'IBB-038', 146, 10100);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (89366, to_date('19-01-2024', 'dd-mm-yyyy'), 'ABB-056', 271, 10565);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (43354, to_date('14-12-2024', 'dd-mm-yyyy'), 'CS-072', 139, 10133);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (80558, to_date('11-07-2024', 'dd-mm-yyyy'), 'CP-030', 399, 10686);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (33065, to_date('23-05-2024', 'dd-mm-yyyy'), 'VC-045', 212, 10276);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (80339, to_date('04-12-2024', 'dd-mm-yyyy'), 'IBB-035', 399, 10397);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (73496, to_date('20-07-2024', 'dd-mm-yyyy'), 'CP-019', 309, 10326);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (72907, to_date('20-05-2023', 'dd-mm-yyyy'), 'MB-014', 471, 10209);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (94369, to_date('19-03-2024', 'dd-mm-yyyy'), 'CP-026', 392, 10029);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (96314, to_date('25-03-2024', 'dd-mm-yyyy'), 'SK-010', 195, 10136);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (21237, to_date('01-05-2023', 'dd-mm-yyyy'), 'YS-017', 270, 10129);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (33359, to_date('25-05-2024', 'dd-mm-yyyy'), 'ABB-063', 226, 10510);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (85055, to_date('24-04-2023', 'dd-mm-yyyy'), 'ABB-057', 20, 10494);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (56707, to_date('05-07-2024', 'dd-mm-yyyy'), 'VC-012', 375, 10687);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (18910, to_date('15-05-2023', 'dd-mm-yyyy'), 'ML-040', 224, 10324);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (42107, to_date('15-02-2023', 'dd-mm-yyyy'), 'SK-012', 21, 10133);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (28363, to_date('18-04-2024', 'dd-mm-yyyy'), 'CS-014', 409, 10666);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (91521, to_date('02-11-2023', 'dd-mm-yyyy'), 'ML-010', 430, 10559);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (50564, to_date('20-04-2023', 'dd-mm-yyyy'), 'ABB-010', 400, 10316);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (80152, to_date('04-03-2023', 'dd-mm-yyyy'), 'CMA-155', 390, 10243);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (53768, to_date('23-04-2024', 'dd-mm-yyyy'), 'UP-017', 321, 10520);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (63487, to_date('06-02-2023', 'dd-mm-yyyy'), 'IBB-019', 256, 10325);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (51192, to_date('24-03-2023', 'dd-mm-yyyy'), 'ABB-089', 120, 10101);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (23122, to_date('13-11-2024', 'dd-mm-yyyy'), 'VC-012', 65, 10306);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (24451, to_date('06-07-2024', 'dd-mm-yyyy'), 'CMA-150', 96, 10122);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (28994, to_date('03-08-2023', 'dd-mm-yyyy'), 'RD-028', 264, 10208);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (80219, to_date('13-11-2023', 'dd-mm-yyyy'), 'ML-031', 365, 10638);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (61276, to_date('04-05-2023', 'dd-mm-yyyy'), 'MB-033', 354, 10494);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (62399, to_date('17-04-2023', 'dd-mm-yyyy'), 'VC-045', 215, 10512);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (33223, to_date('05-08-2024', 'dd-mm-yyyy'), 'CS-068', 188, 10177);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (39104, to_date('16-01-2023', 'dd-mm-yyyy'), 'CMI-117', 409, 10114);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (87405, to_date('03-11-2023', 'dd-mm-yyyy'), 'ABB-096', 457, 10332);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (12217, to_date('28-07-2023', 'dd-mm-yyyy'), 'NC-011', 405, 10385);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (87488, to_date('17-04-2023', 'dd-mm-yyyy'), 'Ml-009', 350, 10221);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (45400, to_date('19-02-2023', 'dd-mm-yyyy'), 'ML-013', 194, 10497);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (36849, to_date('07-12-2024', 'dd-mm-yyyy'), 'NC-003', 280, 10103);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (47268, to_date('08-01-2023', 'dd-mm-yyyy'), 'MB-062', 457, 10294);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (29246, to_date('16-07-2023', 'dd-mm-yyyy'), 'SC-003', 494, 10054);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (78106, to_date('18-07-2023', 'dd-mm-yyyy'), 'KB-008', 177, 10497);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (36366, to_date('23-05-2024', 'dd-mm-yyyy'), 'CMA-157', 144, 10500);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (54207, to_date('26-07-2024', 'dd-mm-yyyy'), 'CS-004', 172, 10358);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (67739, to_date('19-11-2024', 'dd-mm-yyyy'), 'CMI-121', 226, 10457);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (51668, to_date('10-10-2024', 'dd-mm-yyyy'), 'UP-019', 430, 10208);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (51040, to_date('06-05-2023', 'dd-mm-yyyy'), 'CS-008', 337, 10365);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (44525, to_date('23-12-2024', 'dd-mm-yyyy'), 'CP-042', 125, 10038);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (50733, to_date('23-06-2023', 'dd-mm-yyyy'), 'MS-009', 310, 10279);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (58461, to_date('13-04-2023', 'dd-mm-yyyy'), 'CMA-107', 182, 10173);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (90973, to_date('14-08-2024', 'dd-mm-yyyy'), 'CS-051', 482, 10264);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (84191, to_date('05-12-2023', 'dd-mm-yyyy'), 'CS-020', 196, 10326);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (10344, to_date('27-01-2023', 'dd-mm-yyyy'), 'SW-002', 305, 10029);
commit;
prompt 400 records committed...
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (92109, to_date('28-07-2024', 'dd-mm-yyyy'), 'CMI-097', 274, 10217);
insert into ORDERS (order_id, order_date, tracking_number, product_id, buyer_id)
values (547775847, to_date('04-08-2024 14:32:59', 'dd-mm-yyyy hh24:mi:ss'), '666-666', 1, 9999);
commit;
prompt 402 records loaded
prompt Loading INCLUDE_PRODUCTS...
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (10117, 484, 18);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (10344, 305, 16);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (10687, 415, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (10729, 106, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (11309, 114, 12);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (11768, 111, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (11815, 181, 20);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (12217, 405, 15);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (12313, 292, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (12509, 23, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (12649, 123, 11);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (13024, 221, 15);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (13886, 66, 11);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (13990, 296, 14);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (14278, 152, 20);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (14333, 383, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (14508, 236, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (14514, 154, 12);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (14527, 99, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (14619, 434, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (15160, 249, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (15792, 297, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (15800, 376, 11);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (16037, 110, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (16706, 99, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (16785, 262, 16);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (16814, 461, 16);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (16847, 383, 20);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (16934, 335, 14);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (16970, 307, 13);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (16989, 145, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (17121, 368, 11);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (17265, 212, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (17304, 214, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (17362, 239, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (17484, 134, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (17535, 339, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (18018, 431, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (18259, 409, 18);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (18464, 254, 19);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (18910, 224, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (18911, 13, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (19197, 86, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (19298, 397, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (20880, 185, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (21237, 270, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (21304, 184, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (21329, 107, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (21751, 307, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (22551, 101, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (22564, 242, 11);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (23122, 65, 11);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (24451, 96, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (24554, 484, 16);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (24755, 18, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (24886, 409, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (24940, 130, 12);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (25178, 340, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (25284, 394, 16);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (25532, 143, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (25854, 168, 16);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (26247, 355, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (26371, 334, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (26608, 69, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (26665, 7, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (26933, 251, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (26991, 160, 12);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (27241, 95, 14);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (27386, 267, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (27399, 479, 18);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (27591, 359, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (27612, 476, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (28052, 302, 12);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (28363, 409, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (28363, 412, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (28460, 461, 13);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (28574, 391, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (28661, 300, 13);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (28704, 162, 16);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (28902, 7, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (28994, 264, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (29081, 76, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (29246, 494, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (29492, 402, 15);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (29804, 111, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (29986, 276, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (30207, 58, 16);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (30290, 201, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (30479, 104, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (30610, 337, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (31040, 209, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (31139, 83, 20);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (31150, 90, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (31397, 274, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (31682, 479, 16);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (31772, 87, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (31803, 122, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (31945, 441, 16);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (31951, 170, 18);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (31999, 303, 8);
commit;
prompt 100 records committed...
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (32421, 491, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (32532, 305, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (33065, 212, 15);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (33223, 188, 14);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (33352, 427, 13);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (33359, 226, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (33410, 331, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (33577, 350, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (33876, 55, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (33950, 423, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (34049, 280, 15);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (34101, 349, 15);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (34196, 392, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (34366, 200, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (34578, 399, 20);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (34593, 6, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (34594, 493, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (34614, 408, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (34920, 454, 18);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (35244, 14, 16);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (35260, 312, 20);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (35351, 107, 14);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (35742, 294, 14);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (35798, 187, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (35893, 68, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (36152, 91, 20);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (36366, 144, 16);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (36478, 477, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (36735, 278, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (36835, 207, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (36849, 280, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (37128, 369, 11);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (37172, 111, 20);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (38191, 369, 11);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (38329, 469, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (38434, 384, 16);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (38454, 341, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (38487, 361, 13);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (39070, 22, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (39104, 409, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (39265, 275, 20);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (39327, 218, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (39556, 383, 15);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (39681, 202, 18);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (41626, 450, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (41772, 23, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (42017, 278, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (42107, 21, 15);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (42230, 296, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (42738, 421, 13);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (42806, 26, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (43028, 289, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (43151, 63, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (43354, 139, 12);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (43430, 370, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (43454, 171, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (43681, 299, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (44118, 313, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (44314, 257, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (44430, 452, 15);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (44525, 125, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (45286, 453, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (45400, 194, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (46640, 46, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (46956, 146, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (47177, 41, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (47223, 30, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (47268, 457, 13);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (47418, 271, 19);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (47518, 450, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (48160, 129, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (48407, 221, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (48416, 486, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (48598, 67, 13);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (48980, 197, 14);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (48991, 33, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (49160, 453, 15);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (49376, 355, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (49446, 366, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (50211, 200, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (50219, 91, 12);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (50490, 184, 20);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (50564, 400, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (50716, 47, 11);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (50733, 310, 16);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (50771, 300, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (50874, 80, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (51040, 337, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (51192, 120, 20);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (51378, 163, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (51668, 430, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (51727, 17, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (52003, 259, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (52010, 221, 18);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (52112, 159, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (52547, 202, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (53192, 441, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (53308, 28, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (53488, 128, 11);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (53489, 421, 7);
commit;
prompt 200 records committed...
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (53732, 1, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (53768, 321, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (53995, 96, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (54064, 218, 14);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (54121, 369, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (54152, 60, 18);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (54207, 172, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (54210, 350, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (54496, 400, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (54868, 58, 20);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (55177, 367, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (55276, 14, 19);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (55297, 477, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (55587, 306, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (56163, 436, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (56617, 221, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (56707, 375, 20);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (56814, 369, 13);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (57554, 262, 16);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (57676, 161, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (57814, 55, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (58461, 182, 19);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (58716, 421, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (58803, 393, 16);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (58965, 408, 20);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (59350, 84, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (59354, 84, 12);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (59727, 214, 16);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (59836, 341, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (59862, 192, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (60066, 282, 14);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (60109, 365, 18);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (60423, 365, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (60866, 439, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (61123, 246, 18);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (61216, 272, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (61276, 354, 18);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (61636, 441, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (62338, 448, 13);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (62399, 215, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (62854, 449, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (62930, 222, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (62993, 264, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (63487, 256, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (63546, 312, 11);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (64104, 402, 15);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (64340, 167, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (64821, 345, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (64847, 426, 11);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (64854, 108, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (65077, 493, 12);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (65144, 229, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (65177, 91, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (65974, 215, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (66133, 306, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (66436, 189, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (66442, 289, 12);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (67069, 116, 12);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (67137, 129, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (67321, 310, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (67545, 121, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (67739, 226, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (67848, 430, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (68129, 228, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (68166, 109, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (68201, 236, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (68571, 69, 15);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (68614, 343, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (69040, 341, 14);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (69145, 172, 18);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (69197, 453, 20);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (69357, 65, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (70359, 276, 18);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (70921, 437, 20);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (71306, 276, 16);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (71434, 188, 12);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (72050, 17, 14);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (72547, 140, 18);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (72661, 270, 12);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (72907, 471, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (72989, 461, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (73163, 255, 4);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (73166, 450, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (73234, 386, 20);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (73310, 161, 12);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (73496, 309, 16);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (73754, 345, 20);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (74071, 331, 13);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (74737, 362, 16);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (74834, 230, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (74947, 58, 18);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (75409, 55, 19);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (76113, 243, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (76488, 83, 14);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (76627, 376, 14);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (76698, 222, 20);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (76883, 228, 12);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (77017, 309, 20);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (78106, 177, 16);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (78131, 449, 5);
commit;
prompt 300 records committed...
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (78169, 285, 12);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (78231, 375, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (78300, 421, 13);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (78429, 36, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (79085, 62, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (79243, 251, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (79762, 159, 19);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (80069, 153, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (80152, 390, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (80219, 365, 14);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (80240, 45, 12);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (80253, 492, 19);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (80339, 399, 16);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (80558, 399, 13);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (80820, 259, 20);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (80892, 259, 13);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (81152, 177, 12);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (81515, 362, 20);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (81995, 53, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (82959, 477, 20);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (83099, 216, 13);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (83240, 362, 12);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (84191, 196, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (84445, 7, 19);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (84546, 483, 12);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (84618, 139, 13);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (84942, 448, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (84999, 271, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (85055, 20, 20);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (85708, 146, 12);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (85771, 228, 16);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (86196, 388, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (86336, 84, 18);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (86468, 262, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (86472, 245, 19);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (86518, 187, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (86571, 164, 11);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (86598, 161, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (86622, 144, 16);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (86736, 167, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (86898, 370, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (87405, 457, 11);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (87488, 350, 12);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (87903, 324, 11);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (88538, 177, 19);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (88572, 371, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (88802, 472, 12);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (88851, 405, 16);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (89133, 489, 13);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (89366, 271, 16);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (89411, 54, 19);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (89419, 195, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (89424, 184, 12);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (89461, 100, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (89856, 454, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (90712, 387, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (90810, 345, 14);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (90870, 292, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (90973, 482, 18);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (91392, 184, 20);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (91521, 430, 19);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (91931, 187, 15);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (92051, 330, 2);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (92109, 274, 3);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (92240, 264, 18);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (92398, 95, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (92941, 343, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (93304, 216, 7);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (93733, 397, 14);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (93890, 87, 16);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (94028, 162, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (94369, 392, 20);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (94519, 299, 11);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (94755, 172, 15);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (94784, 143, 10);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (94789, 54, 12);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (95139, 375, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (95320, 238, 18);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (95873, 34, 15);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (96159, 220, 5);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (96314, 195, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (96364, 121, 15);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (96586, 488, 14);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (97040, 22, 11);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (97053, 385, 13);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (97225, 203, 19);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (97429, 370, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (97458, 46, 11);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (97522, 396, 13);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (97577, 303, 16);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (97881, 137, 8);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (97921, 266, 9);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (98220, 412, 16);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (98633, 275, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (98636, 426, 19);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (98687, 196, 6);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (98803, 204, 1);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (98818, 455, 19);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (99240, 285, 17);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (99337, 60, 12);
commit;
prompt 400 records committed...
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (99585, 399, 12);
insert into INCLUDE_PRODUCTS (order_id, product_id, quantity)
values (547775847, 1, 4);
commit;
prompt 402 records loaded
prompt Loading PRODUCTS...
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (1, ' Laptop', ' New', 1039.49, 1, 24, to_date('24-10-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (2, ' Desktop Computer', ' Refurbished', 808.49, 1, 14, to_date('16-12-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (3, ' Monitor', ' New', 230.99, 1, 24, to_date('15-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (4, ' Keyboard', ' New', 57.74, 1, 15, to_date('13-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (5, ' Mouse', ' New', 23.09, 1, 2, to_date('09-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (6, ' External Hard Drive', ' Refurbished', 79.99, 11, 12, to_date('27-04-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (7, ' USB Flash Drive', ' New', 14.99, 11, 9, to_date('12-03-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (8, ' Printer', ' New', 149.99, 2, 29, to_date('26-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (9, ' Wireless Keyboard', ' Refurbished', 34.64, 1, 29, to_date('11-09-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (10, ' Bluetooth Speaker', ' New', 79.99, 2, 5, to_date('08-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (11, ' Gaming Mouse', ' New', 49.99, 5, 22, to_date('08-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (12, ' Mechanical Keyboard', ' Refurbished', 89.99, 5, 2, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (13, ' Wireless Headphones', ' New', 129.99, 6, 4, to_date('08-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (14, ' Earbuds', ' Refurbished', 39.99, 6, 22, to_date('21-08-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (15, ' Smartwatch', ' New', 199.99, 8, 28, to_date('28-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (16, ' Fitness Tracker', ' New', 69.99, 12, 8, to_date('28-04-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (17, ' Digital Camera', ' Refurbished', 149.99, 9, 23, to_date('09-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (18, ' DSLR Camera', ' New', 699.99, 9, 9, to_date('30-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (19, ' LED Desk Lamp', ' New', 34.99, 10, 26, to_date('29-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (20, ' Smart Bulbs', ' Refurbished', 19.99, 10, 16, to_date('23-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (21, ' WiFi Router', ' New', 79.99, 4, 18, to_date('12-03-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (22, ' Network Switch', ' New', 49.99, 4, 15, to_date('05-03-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (23, ' Gaming Console', ' New', 399.99, 5, 22, to_date('09-06-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (24, ' VR Headset', ' Refurbished', 299.99, 28, 18, to_date('16-05-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (25, ' Action Camera', ' New', 199.99, 28, 19, to_date('23-04-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (26, ' 3D Printer', ' New', 399.99, 29, 21, to_date('17-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (27, ' Filament Refill', ' New', 29.99, 29, 27, to_date('15-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (28, ' Blood Pressure Monitor', ' New', 59.99, 17, 6, to_date('19-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (29, ' Electric Shaver', ' New', 79.99, 12, 9, to_date('19-11-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (31, ' Dumbbell Set', ' Refurbished', 49.99, 18, 21, to_date('29-12-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (32, ' Resistance Bands', ' New', 19.99, 18, 9, to_date('17-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (33, ' Treadmill', ' New', 599.99, 18, 13, to_date('12-07-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (35, ' Elliptical Machine', ' Refurbished', 449.99, 18, 24, to_date('22-03-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (36, ' Home Gym Set', ' New', 899.99, 18, 8, to_date('11-08-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (37, ' Jump Rope', ' New', 9.99, 18, 1, to_date('04-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (39, ' Smart TV', ' New', 499.99, 19, 20, to_date('21-12-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (40, ' Streaming Device', ' New', 79.99, 19, 23, to_date('28-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (41, ' Sound Bar', ' Refurbished', 149.99, 19, 21, to_date('11-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (42, ' Projector', ' New', 299.99, 19, 5, to_date('09-08-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (44, ' Wireless Router', ' New', 79.99, 19, 8, to_date('29-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (45, ' Smart Light Bulbs', ' Refurbished', 29.99, 19, 22, to_date('29-09-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (46, ' Smart Thermostat', ' New', 129.99, 19, 7, to_date('10-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (47, ' Security Camera', ' New', 79.99, 19, 28, to_date('28-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (49, ' Baby Monitor', ' New', 69.99, 19, 20, to_date('12-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (50, ' Smart Plug', ' New', 19.99, 19, 8, to_date('19-07-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (51, ' Smart Lock', ' Refurbished', 149.99, 19, 28, to_date('07-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (52, ' Indoor Plant', ' New', 39.99, 19, 16, to_date('18-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (54, ' Outdoor Grill', ' New', 299.99, 19, 4, to_date('26-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (55, ' Patio Furniture', ' Refurbished', 399.99, 19, 21, to_date('12-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (56, ' Hammock', ' New', 39.99, 19, 18, to_date('15-02-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (57, ' Fire Pit', ' New', 199.99, 19, 5, to_date('01-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (58, ' Lawn Mower', ' New', 249.99, 19, 22, to_date('27-04-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (60, ' Pressure Washer', ' New', 149.99, 19, 11, to_date('27-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (61, ' Tool Kit', ' New', 29.99, 19, 27, to_date('08-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (62, ' Cordless Drill', ' Refurbished', 79.99, 19, 29, to_date('10-03-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (63, ' Saw', ' New', 49.99, 19, 8, to_date('10-06-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (65, ' Safety Goggles', ' Refurbished', 9.99, 19, 18, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (66, ' Work Gloves', ' New', 14.99, 19, 17, to_date('28-05-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (67, ' Paint Sprayer', ' New', 69.99, 19, 9, to_date('16-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (69, ' Wrench Set', ' Refurbished', 19.99, 19, 4, to_date('07-12-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (70, ' Screwdriver Set', ' New', 14.99, 19, 19, to_date('18-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (71, ' Socket Set', ' New', 39.99, 19, 2, to_date('24-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (72, ' Measuring Tape', ' Refurbished', 9.99, 19, 15, to_date('17-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (74, ' Car Charger', ' Refurbished', 19.99, 19, 5, to_date('08-09-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (75, ' GPS Navigator', ' New', 99.99, 19, 24, to_date('20-03-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (76, ' Dash Cam', ' New', 59.99, 19, 11, to_date('10-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (78, ' Steering Wheel Cover', ' Refurbished', 14.99, 19, 21, to_date('05-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (79, ' Car Air Purifier', ' New', 39.99, 19, 3, to_date('28-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (80, ' Tire Pressure Gauge', ' Refurbished', 9.99, 19, 10, to_date('02-12-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (82, ' Toolbox', ' New', 49.99, 19, 25, to_date('21-10-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (83, ' Sunglasses', ' Refurbished', 19.99, 19, 22, to_date('07-03-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (84, ' Wristwatch', ' New', 39.99, 19, 24, to_date('24-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (85, ' Wallet', ' New', 29.99, 19, 19, to_date('06-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (87, ' Handbag', ' New', 24.99, 19, 26, to_date('30-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (88, ' Suitcase', ' New', 79.99, 19, 18, to_date('09-09-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (89, ' Travel Pillow', ' Refurbished', 14.99, 19, 6, to_date('05-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (91, ' Tripod', ' New', 49.99, 19, 18, to_date('07-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (92, ' Photo Printer', ' Refurbished', 149.99, 19, 27, to_date('10-12-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (93, ' Memory Card', ' New', 9.99, 19, 11, to_date('26-06-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (95, ' VR Headset', ' Refurbished', 299.99, 19, 6, to_date('18-12-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (96, ' Drone', ' New', 249.99, 19, 10, to_date('22-09-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (97, ' Action Camera', ' New', 199.99, 19, 22, to_date('04-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (98, ' 3D Printer', ' New', 399.99, 19, 16, to_date('25-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (100, ' Wireless Mouse', ' New', 29.99, 20, 26, to_date('04-09-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (101, ' Bluetooth Speaker', ' Refurbished', 99.99, 20, 25, to_date('27-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (102, ' Laptop Stand', ' New', 29.99, 20, 29, to_date('21-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (103, ' USB-C Hub', ' New', 39.99, 20, 29, to_date('29-10-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (104, ' Gaming Keyboard', ' Refurbished', 79.99, 20, 5, to_date('16-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (106, ' Portable Charger', ' New', 24.99, 20, 22, to_date('24-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (107, ' Smart Watch', ' New', 199.99, 20, 27, to_date('27-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (108, ' Digital Camera', ' Refurbished', 149.99, 20, 7, to_date('17-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (109, ' LED Desk Lamp', ' New', 34.99, 20, 24, to_date('28-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (110, ' External Hard Drive', ' New', 89.99, 20, 24, to_date('10-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (112, ' Fitness Tracker', ' New', 69.99, 20, 5, to_date('30-11-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (113, ' Wireless Earbuds', ' Refurbished', 59.99, 20, 17, to_date('16-02-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (114, ' Graphic Tablet', ' New', 129.99, 20, 13, to_date('06-03-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (115, ' Electric Kettle', ' New', 39.99, 20, 5, to_date('19-08-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (116, ' Coffee Maker', ' Refurbished', 49.99, 20, 16, to_date('12-04-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (118, ' Air Fryer', ' New', 99.99, 20, 5, to_date('09-07-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (119, ' Pressure Cooker', ' Refurbished', 89.99, 20, 1, to_date('30-11-2023', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (120, ' Robot Vacuum', ' New', 199.99, 20, 24, to_date('16-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (122, ' Hair Dryer', ' New', 29.99, 20, 26, to_date('22-05-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (123, ' Beard Trimmer', ' Refurbished', 34.99, 20, 2, to_date('21-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (124, ' Water Flosser', ' New', 39.99, 20, 15, to_date('02-06-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (125, ' Infrared Thermometer', ' Refurbished', 24.99, 20, 17, to_date('14-08-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (126, ' Blood Pressure Monitor', ' New', 59.99, 20, 7, to_date('11-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (128, ' Electric Shaver', ' Refurbished', 79.99, 20, 6, to_date('09-02-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (129, ' Massage Gun', ' New', 149.99, 20, 20, to_date('03-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (130, ' Yoga Mat', ' New', 24.99, 20, 7, to_date('26-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (131, ' Dumbbell Set', ' New', 69.99, 20, 8, to_date('14-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (133, ' Treadmill', ' New', 599.99, 20, 20, to_date('24-06-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (134, ' Exercise Bike', ' Refurbished', 249.99, 20, 3, to_date('27-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (135, ' Elliptical Machine', ' New', 499.99, 20, 15, to_date('18-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (136, ' Home Gym Set', ' New', 999.99, 20, 12, to_date('26-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (138, ' Foam Roller', ' New', 14.99, 20, 19, to_date('03-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (139, ' Smart TV', ' Refurbished', 399.99, 21, 1, to_date('10-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (140, ' Streaming Device', ' New', 49.99, 21, 14, to_date('02-04-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (141, ' Sound Bar', ' New', 199.99, 21, 6, to_date('19-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (143, ' Gaming Console', ' New', 399.99, 21, 22, to_date('09-08-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (144, ' Wireless Router', ' New', 79.99, 21, 23, to_date('19-08-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (145, ' Smart Light Bulbs', ' New', 29.99, 21, 27, to_date('26-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (146, ' Smart Thermostat', ' Refurbished', 129.99, 21, 22, to_date('23-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (148, ' Video Doorbell', ' New', 199.99, 21, 22, to_date('13-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (149, ' Baby Monitor', ' New', 69.99, 21, 3, to_date('07-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (150, ' Smart Plug', ' Refurbished', 19.99, 21, 6, to_date('17-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (151, ' Smart Lock', ' New', 149.99, 21, 4, to_date('07-10-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (153, ' Garden Tools Set', ' Refurbished', 49.99, 21, 12, to_date('13-11-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (154, ' Outdoor Grill', ' New', 299.99, 21, 14, to_date('28-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (155, ' Patio Furniture', ' New', 399.99, 21, 12, to_date('05-02-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (157, ' Fire Pit', ' New', 199.99, 21, 7, to_date('31-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (158, ' Lawn Mower', ' New', 249.99, 21, 24, to_date('04-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (159, ' Leaf Blower', ' Refurbished', 99.99, 21, 11, to_date('25-10-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (160, ' Pressure Washer', ' New', 149.99, 21, 3, to_date('26-05-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (162, ' Cordless Drill', ' Refurbished', 79.99, 21, 5, to_date('09-09-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (163, ' Saw', ' New', 49.99, 21, 24, to_date('25-09-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (164, ' Workbench', ' New', 99.99, 21, 15, to_date('21-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (166, ' Work Gloves', ' New', 14.99, 21, 12, to_date('02-09-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (167, ' Paint Sprayer', ' New', 69.99, 21, 16, to_date('25-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (168, ' Air Compressor', ' Refurbished', 149.99, 21, 6, to_date('29-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (169, ' Wrench Set', ' New', 19.99, 21, 2, to_date('06-06-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (171, ' Socket Set', ' Refurbished', 39.99, 21, 1, to_date('14-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (172, ' Measuring Tape', ' New', 9.99, 21, 16, to_date('05-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (173, ' Car Vacuum', ' New', 29.99, 21, 28, to_date('23-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (174, ' Car Charger', ' Refurbished', 19.99, 21, 22, to_date('09-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (176, ' Dash Cam', ' New', 59.99, 21, 29, to_date('08-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (177, ' Car Seat Cover', ' Refurbished', 49.99, 21, 19, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (178, ' Steering Wheel Cover', ' New', 14.99, 21, 15, to_date('11-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (180, ' Tire Pressure Gauge', ' Refurbished', 9.99, 21, 20, to_date('20-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (181, ' Jump Starter', ' New', 69.99, 21, 13, to_date('27-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (182, ' Toolbox', ' New', 49.99, 21, 28, to_date('12-12-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (183, ' Sunglasses', ' Refurbished', 19.99, 21, 29, to_date('28-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (185, ' Wallet', ' New', 29.99, 21, 21, to_date('22-11-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (186, ' Backpack', ' Refurbished', 49.99, 21, 19, to_date('17-09-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (187, ' Handbag', ' New', 24.99, 21, 1, to_date('17-07-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (189, ' Travel Pillow', ' Refurbished', 14.99, 21, 27, to_date('30-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (190, ' Camera Bag', ' New', 34.99, 21, 25, to_date('12-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (191, ' Tripod', ' New', 49.99, 21, 14, to_date('21-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (193, ' Memory Card', ' New', 9.99, 21, 24, to_date('10-12-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (194, ' Smartphone Gimbal', ' New', 79.99, 21, 25, to_date('05-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (195, ' VR Headset', ' Refurbished', 299.99, 21, 29, to_date('21-09-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (196, ' Drone', ' New', 249.99, 21, 3, to_date('20-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (197, ' Action Camera', ' New', 199.99, 21, 7, to_date('18-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (198, ' 3D Printer', ' Refurbished', 399.99, 21, 9, to_date('04-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (199, ' Electric Scooter', ' New', 299.99, 21, 28, to_date('16-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (200, ' Laptop Cooling Pad', ' Refurbished', 28.86, 1, 29, to_date('29-10-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (201, ' External SSD', ' New', 119.99, 11, 27, to_date('21-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (202, ' Inkjet Printer', ' Refurbished', 99.99, 2, 14, to_date('02-10-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (203, ' Ergonomic Mouse', ' New', 34.64, 1, 8, to_date('18-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (204, ' Mechanical Gaming Keyboard', ' New', 99.99, 5, 2, to_date('29-07-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (205, ' Gaming Chair', ' Refurbished', 199.99, 5, 28, to_date('24-05-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (206, ' Gaming Headset', ' New', 79.99, 6, 22, to_date('09-06-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (207, ' Wireless Earphones', ' Refurbished', 49.99, 6, 23, to_date('27-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (208, ' Smart Fitness Band', ' New', 49.99, 12, 2, to_date('27-05-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (209, ' Mirrorless Camera', ' New', 999.99, 9, 29, to_date('05-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (210, ' Desk Lamp', ' Refurbished', 14.99, 10, 18, to_date('19-03-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (211, ' Smart Light Strip', ' New', 24.99, 10, 3, to_date('28-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (212, ' Mesh WiFi System', ' New', 199.99, 4, 19, to_date('26-12-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (213, ' Ethernet Cable', ' Refurbished', 9.99, 4, 22, to_date('16-12-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (214, ' Gaming PC', ' New', 1499.99, 5, 11, to_date('22-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (215, ' AR Headset', ' New', 799.99, 28, 5, to_date('08-06-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (216, ' 3D Scanner', ' Refurbished', 499.99, 29, 20, to_date('10-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (217, ' Blood Glucose Monitor', ' New', 39.99, 17, 24, to_date('27-05-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (218, ' Beard Trimmer', ' New', 49.99, 12, 25, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (219, ' Pilates Mat', ' New', 19.99, 18, 12, to_date('12-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (220, ' Adjustable Dumbbells', ' Refurbished', 199.99, 18, 24, to_date('01-12-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (221, ' Rowing Machine', ' New', 799.99, 18, 8, to_date('12-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (222, ' Spin Bike', ' Refurbished', 399.99, 18, 29, to_date('14-04-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (223, ' Full Body Workout Machine', ' New', 1499.99, 18, 22, to_date('29-12-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (224, ' Jump Rope', ' New', 9.99, 18, 26, to_date('16-05-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (225, ' Massage Roller', ' Refurbished', 9.99, 18, 1, to_date('31-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (226, ' OLED Smart TV', ' New', 1299.99, 19, 29, to_date('04-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (227, ' 4K Streaming Device', ' Refurbished', 69.99, 19, 18, to_date('25-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (228, ' Dolby Atmos Sound Bar', ' New', 299.99, 19, 6, to_date('09-06-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (229, ' HD Projector', ' New', 499.99, 19, 2, to_date('09-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (230, ' Gaming PC', ' Refurbished', 999.99, 19, 17, to_date('19-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (231, ' Dual Band WiFi Router', ' New', 59.99, 19, 29, to_date('06-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (232, ' Smart LED Bulbs', ' Refurbished', 19.99, 19, 16, to_date('04-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (234, ' Indoor Security Camera', ' Refurbished', 59.99, 19, 15, to_date('31-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (235, ' Video Doorbell Pro', ' New', 299.99, 19, 21, to_date('15-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (236, ' Baby Monitor with Camera', ' New', 149.99, 19, 11, to_date('20-04-2023', 'dd-mm-yyyy'));
commit;
prompt 200 records committed...
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (237, ' Smart Plug Pack', ' Refurbished', 29.99, 19, 20, to_date('21-05-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (239, ' Indoor Plant Collection', ' New', 99.99, 19, 4, to_date('09-06-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (240, ' Gardening Tool Set', ' Refurbished', 29.99, 19, 20, to_date('27-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (241, ' Gas Grill', ' New', 399.99, 19, 8, to_date('05-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (242, ' Outdoor Dining Set', ' New', 699.99, 19, 4, to_date('11-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (243, ' Hammock Chair', ' Refurbished', 29.99, 19, 17, to_date('20-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (245, ' Robotic Lawn Mower', ' New', 999.99, 19, 6, to_date('31-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (246, ' Cordless Leaf Blower', ' Refurbished', 49.99, 19, 18, to_date('26-10-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (247, ' Electric Pressure Washer', ' New', 199.99, 19, 7, to_date('09-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (249, ' Power Drill Kit', ' Refurbished', 59.99, 19, 20, to_date('12-11-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (250, ' Circular Saw', ' New', 79.99, 19, 11, to_date('03-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (251, ' Garage Workbench', ' New', 149.99, 19, 26, to_date('20-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (252, ' Safety Glasses', ' Refurbished', 9.99, 19, 14, to_date('29-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (254, ' Airless Paint Sprayer', ' New', 199.99, 19, 21, to_date('14-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (255, ' Portable Air Compressor', ' Refurbished', 49.99, 19, 26, to_date('14-03-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (256, ' Ratchet Wrench Set', ' New', 29.99, 19, 27, to_date('20-09-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (257, ' Precision Screwdriver Set', ' New', 9.99, 19, 13, to_date('04-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (259, ' Laser Distance Measurer', ' New', 49.99, 19, 7, to_date('05-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (260, ' Car Vacuum Cleaner', ' New', 29.99, 19, 29, to_date('02-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (261, ' USB Car Charger', ' Refurbished', 9.99, 19, 9, to_date('26-09-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (262, ' GPS Navigation System', ' New', 149.99, 19, 22, to_date('02-07-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (263, ' Dual Dash Cam', ' New', 99.99, 19, 18, to_date('28-07-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (265, ' Steering Wheel Cover', ' Refurbished', 14.99, 19, 4, to_date('17-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (266, ' Car Air Purifier', ' New', 39.99, 19, 24, to_date('12-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (267, ' Digital Tire Pressure Gauge', ' Refurbished', 9.99, 19, 1, to_date('15-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (268, ' Portable Jump Starter', ' New', 69.99, 19, 13, to_date('05-05-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (270, ' Sunglasses', ' New', 19.99, 19, 9, to_date('15-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (271, ' Sports Watch', ' Refurbished', 29.99, 19, 10, to_date('05-12-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (272, ' Leather Wallet', ' New', 39.99, 19, 2, to_date('30-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (273, ' Travel Backpack', ' New', 49.99, 19, 28, to_date('20-04-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (275, ' Lightweight Suitcase', ' New', 79.99, 19, 14, to_date('13-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (276, ' Travel Pillow', ' New', 14.99, 19, 13, to_date('11-02-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (277, ' Camera Backpack', ' Refurbished', 34.99, 19, 18, to_date('08-02-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (278, ' Lightweight Tripod', ' New', 49.99, 19, 29, to_date('06-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (279, ' Portable Photo Printer', ' New', 149.99, 19, 16, to_date('19-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (281, ' Smartphone Stabilizer', ' New', 79.99, 19, 11, to_date('04-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (282, ' Virtual Reality Headset', ' New', 299.99, 19, 15, to_date('16-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (283, ' Camera Drone', ' Refurbished', 249.99, 19, 19, to_date('07-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (284, ' Action Camera', ' New', 199.99, 19, 10, to_date('24-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (285, ' 3D Printer Kit', ' Refurbished', 399.99, 19, 8, to_date('30-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (286, ' Electric Scooter', ' New', 299.99, 19, 25, to_date('17-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (288, ' Portable SSD', ' Refurbished', 99.99, 11, 12, to_date('14-12-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (289, ' Laser Printer', ' New', 149.99, 2, 12, to_date('11-09-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (290, ' Ergonomic Mouse', ' New', 34.64, 1, 28, to_date('19-02-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (291, ' Mechanical Gaming Keyboard', ' Refurbished', 89.99, 5, 11, to_date('19-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (293, ' Gaming Headset', ' New', 79.99, 6, 16, to_date('23-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (294, ' Wireless Earphones', ' New', 59.99, 6, 21, to_date('05-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (295, ' Smart Fitness Band', ' Refurbished', 29.99, 12, 18, to_date('10-11-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (296, ' Mirrorless Camera', ' New', 999.99, 9, 11, to_date('21-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (298, ' Smart Light Strip', ' Refurbished', 9.99, 10, 17, to_date('01-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (299, ' Mesh WiFi System', ' New', 149.99, 4, 3, to_date('16-11-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (300, ' Ethernet Cable', ' New', 9.99, 4, 9, to_date('12-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (302, ' AR Headset', ' Refurbished', 499.99, 28, 17, to_date('14-12-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (303, ' 3D Scanner', ' New', 299.99, 29, 20, to_date('01-09-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (304, ' Blood Glucose Monitor', ' New', 29.99, 17, 19, to_date('02-03-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (306, ' Pilates Mat', ' New', 14.99, 18, 10, to_date('02-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (307, ' Adjustable Dumbbells', ' New', 249.99, 18, 26, to_date('09-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (308, ' Rowing Machine', ' Refurbished', 699.99, 18, 26, to_date('22-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (309, ' Spin Bike', ' New', 349.99, 18, 20, to_date('19-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (311, ' Jump Rope', ' Refurbished', 9.99, 18, 18, to_date('01-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (312, ' Massage Roller', ' New', 9.99, 18, 23, to_date('07-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (313, ' OLED Smart TV', ' Refurbished', 999.99, 19, 12, to_date('26-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (314, ' 4K Streaming Device', ' New', 89.99, 19, 25, to_date('10-05-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (315, ' Dolby Atmos Sound Bar', ' New', 399.99, 19, 9, to_date('24-03-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (317, ' Gaming PC', ' New', 1999.99, 19, 18, to_date('19-07-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (318, ' Dual Band WiFi Router', ' Refurbished', 29.99, 19, 3, to_date('19-06-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (319, ' Smart LED Bulbs', ' New', 14.99, 19, 11, to_date('28-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (320, ' Nest Thermostat', ' Refurbished', 99.99, 19, 15, to_date('28-09-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (322, ' Video Doorbell Pro', ' New', 399.99, 19, 12, to_date('02-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (323, ' Baby Monitor with Camera', ' Refurbished', 149.99, 19, 12, to_date('20-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (324, ' Smart Plug Pack', ' New', 19.99, 19, 19, to_date('03-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (325, ' Fingerprint Smart Lock', ' New', 149.99, 19, 1, to_date('18-11-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (327, ' Gardening Tool Set', ' New', 19.99, 19, 12, to_date('18-04-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (328, ' Gas Grill', ' Refurbished', 199.99, 19, 26, to_date('10-12-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (329, ' Outdoor Dining Set', ' Refurbished', 399.99, 19, 16, to_date('31-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (330, ' Hammock Chair', ' New', 19.99, 19, 17, to_date('28-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (331, ' Fire Table', ' Refurbished', 299.99, 19, 22, to_date('22-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (333, ' Cordless Leaf Blower', ' New', 69.99, 19, 16, to_date('20-12-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (334, ' Electric Pressure Washer', ' New', 299.99, 19, 6, to_date('20-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (335, ' Basic Tool Set', ' New', 9.99, 19, 9, to_date('12-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (336, ' Power Drill Kit', ' New', 39.99, 19, 20, to_date('05-05-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (337, ' Circular Saw', ' New', 59.99, 19, 24, to_date('15-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (339, ' Safety Glasses', ' New', 4.99, 19, 7, to_date('13-09-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (340, ' Mechanic Gloves', ' New', 9.99, 19, 27, to_date('18-07-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (341, ' Airless Paint Sprayer', ' Refurbished', 149.99, 19, 8, to_date('16-12-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (342, ' Portable Air Compressor', ' New', 39.99, 19, 3, to_date('23-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (343, ' Ratchet Wrench Set', ' New', 19.99, 19, 6, to_date('20-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (345, ' Socket and Wrench Set', ' New', 29.99, 19, 24, to_date('29-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (346, ' Laser Distance Measurer', ' Refurbished', 39.99, 19, 20, to_date('11-12-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (347, ' Car Vacuum Cleaner', ' Refurbished', 19.99, 19, 14, to_date('10-10-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (348, ' USB Car Charger', ' New', 9.99, 19, 4, to_date('10-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (349, ' GPS Navigation System', ' New', 79.99, 19, 23, to_date('23-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (350, ' Dual Dash Cam', ' New', 49.99, 19, 28, to_date('07-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (352, ' Steering Wheel Cover', ' New', 9.99, 19, 20, to_date('20-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (353, ' Car Air Purifier', ' New', 29.99, 19, 29, to_date('01-11-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (354, ' Digital Tire Pressure Gauge', ' New', 9.99, 19, 14, to_date('05-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (355, ' Portable Jump Starter', ' Refurbished', 49.99, 19, 28, to_date('14-10-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (356, ' Tool Chest', ' New', 99.99, 19, 27, to_date('29-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (358, ' Sports Watch', ' New', 19.99, 19, 3, to_date('19-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (359, ' Leather Wallet', ' Refurbished', 19.99, 19, 16, to_date('10-02-2024', 'dd-mm-yyyy'));
commit;
prompt 300 records committed...
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (360, ' Travel Backpack', ' New', 19.99, 19, 25, to_date('29-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (361, ' Business Handbag', ' New', 9.99, 19, 26, to_date('28-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (363, ' Travel Pillow', ' New', 4.99, 19, 12, to_date('08-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (364, ' Camera Backpack', ' New', 19.99, 19, 6, to_date('08-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (365, ' Lightweight Tripod', ' New', 29.99, 19, 18, to_date('19-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (366, ' Portable Photo Printer', ' New', 99.99, 19, 27, to_date('13-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (367, ' High-Speed Memory Card', ' New', 4.99, 19, 14, to_date('11-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (368, ' Smartphone Stabilizer', ' Refurbished', 59.99, 19, 6, to_date('09-10-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (369, ' Virtual Reality Headset', ' New', 199.99, 19, 12, to_date('22-09-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (370, ' Camera Drone', ' New', 199.99, 19, 15, to_date('06-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (371, ' Action Camera', ' Refurbished', 149.99, 19, 14, to_date('13-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (372, ' 3D Printer Kit', ' New', 299.99, 19, 25, to_date('03-07-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (373, ' Electric Scooter', ' Refurbished', 199.99, 19, 5, to_date('08-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (374, ' Laptop Cooling Pad', ' New', 23.09, 1, 16, to_date('16-11-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (375, ' Portable SSD', ' Refurbished', 79.99, 11, 8, to_date('04-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (376, ' Laser Printer', ' New', 199.99, 2, 16, to_date('27-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (377, ' Ergonomic Mouse', ' Refurbished', 17.31, 1, 2, to_date('12-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (378, ' Mechanical Gaming Keyboard', ' New', 129.99, 5, 25, to_date('29-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (379, ' Gaming Chair', ' New', 249.99, 5, 23, to_date('11-04-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (380, ' Gaming Headset', ' Refurbished', 39.99, 6, 24, to_date('10-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (381, ' Wireless Earphones', ' New', 69.99, 6, 26, to_date('21-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (382, ' Smart Fitness Band', ' New', 79.99, 12, 7, to_date('03-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (383, ' Mirrorless Camera', ' Refurbished', 699.99, 9, 17, to_date('29-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (384, ' Desk Lamp', ' New', 29.99, 10, 16, to_date('31-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (385, ' Smart Light Strip', ' New', 19.99, 10, 2, to_date('31-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (386, ' Mesh WiFi System', ' Refurbished', 99.99, 4, 20, to_date('04-11-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (387, ' Ethernet Cable', ' New', 14.99, 4, 12, to_date('14-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (388, ' Gaming PC', ' New', 1799.99, 5, 1, to_date('15-09-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (389, ' AR Headset', ' New', 999.99, 28, 9, to_date('07-05-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (390, ' 3D Scanner', ' New', 399.99, 29, 25, to_date('23-03-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (391, ' Blood Glucose Monitor', ' Refurbished', 19.99, 17, 16, to_date('31-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (392, ' Beard Trimmer', ' New', 29.99, 12, 21, to_date('11-07-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (393, ' Pilates Mat', ' New', 24.99, 18, 5, to_date('14-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (394, ' Adjustable Dumbbells', ' New', 299.99, 18, 18, to_date('22-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (395, ' Rowing Machine', ' New', 899.99, 18, 4, to_date('23-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (396, ' Spin Bike', ' New', 499.99, 18, 25, to_date('03-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (397, ' Full Body Workout Machine', ' Refurbished', 999.99, 18, 29, to_date('04-05-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (398, ' Jump Rope', ' New', 14.99, 18, 20, to_date('29-04-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (399, ' Massage Roller', ' Refurbished', 14.99, 18, 29, to_date('15-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (400, ' OLED Smart TV', ' New', 1499.99, 19, 6, to_date('20-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (401, ' 4K Streaming Device', ' Refurbished', 79.99, 19, 6, to_date('16-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (402, ' Dolby Atmos Sound Bar', ' New', 499.99, 19, 28, to_date('20-12-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (403, ' HD Projector', ' Refurbished', 399.99, 19, 29, to_date('11-12-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (404, ' Gaming PC', ' New', 2499.99, 19, 28, to_date('01-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (405, ' Dual Band WiFi Router', ' New', 39.99, 19, 15, to_date('22-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (406, ' Smart LED Bulbs', ' New', 9.99, 19, 4, to_date('19-03-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (407, ' Nest Thermostat', ' New', 149.99, 19, 7, to_date('14-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (408, ' Indoor Security Camera', ' New', 39.99, 19, 2, to_date('13-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (409, ' Video Doorbell Pro', ' Refurbished', 199.99, 19, 10, to_date('01-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (410, ' Baby Monitor with Camera', ' New', 99.99, 19, 21, to_date('23-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (411, ' Smart Plug Pack', ' New', 9.99, 19, 21, to_date('05-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (412, ' Fingerprint Smart Lock', ' New', 99.99, 19, 12, to_date('16-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (413, ' Indoor Plant Collection', ' Refurbished', 49.99, 19, 10, to_date('22-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (414, ' Gardening Tool Set', ' New', 9.99, 19, 3, to_date('07-06-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (415, ' Gas Grill', ' New', 499.99, 19, 11, to_date('28-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (416, ' Outdoor Dining Set', ' New', 899.99, 19, 28, to_date('27-06-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (417, ' Hammock Chair', ' New', 39.99, 19, 10, to_date('04-12-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (418, ' Fire Table', ' New', 599.99, 19, 24, to_date('19-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (419, ' Robotic Lawn Mower', ' New', 1299.99, 19, 7, to_date('23-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (420, ' Cordless Leaf Blower', ' New', 99.99, 19, 26, to_date('23-08-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (421, ' Electric Pressure Washer', ' Refurbished', 149.99, 19, 22, to_date('02-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (422, ' Basic Tool Set', ' Refurbished', 14.99, 19, 29, to_date('11-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (423, ' Power Drill Kit', ' New', 49.99, 19, 27, to_date('19-04-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (424, ' Circular Saw', ' Refurbished', 39.99, 19, 16, to_date('05-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (425, ' Garage Workbench', ' New', 199.99, 19, 4, to_date('25-04-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (426, ' Safety Glasses', ' New', 9.99, 19, 17, to_date('05-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (427, ' Mechanic Gloves', ' Refurbished', 4.99, 19, 21, to_date('04-10-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (428, ' Airless Paint Sprayer', ' New', 249.99, 19, 5, to_date('12-05-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (429, ' Portable Air Compressor', ' New', 59.99, 19, 7, to_date('14-03-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (430, ' Ratchet Wrench Set', ' Refurbished', 9.99, 19, 7, to_date('15-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (431, ' Precision Screwdriver Set', ' New', 14.99, 19, 22, to_date('13-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (432, ' Socket and Wrench Set', ' New', 19.99, 19, 7, to_date('27-10-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (433, ' Laser Distance Measurer', ' New', 69.99, 19, 24, to_date('17-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (434, ' Car Vacuum Cleaner', ' New', 39.99, 19, 23, to_date('22-03-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (435, ' USB Car Charger', ' New', 4.99, 19, 22, to_date('07-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (436, ' GPS Navigation System', ' Refurbished', 49.99, 19, 12, to_date('10-03-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (437, ' Dual Dash Cam', ' Refurbished', 29.99, 19, 10, to_date('22-03-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (438, ' Car Seat Cover Set', ' New', 39.99, 19, 24, to_date('10-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (439, ' Steering Wheel Cover', ' New', 4.99, 19, 17, to_date('11-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (440, ' Car Air Purifier', ' Refurbished', 19.99, 19, 11, to_date('31-03-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (441, ' Digital Tire Pressure Gauge', ' New', 4.99, 19, 12, to_date('27-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (442, ' Portable Jump Starter', ' New', 39.99, 19, 3, to_date('17-04-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (443, ' Tool Chest', ' New', 129.99, 19, 13, to_date('30-12-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (444, ' Sunglasses', ' Refurbished', 9.99, 19, 18, to_date('27-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (445, ' Sports Watch', ' New', 9.99, 19, 27, to_date('28-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (446, ' Leather Wallet', ' New', 14.99, 19, 27, to_date('28-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (447, ' Travel Backpack', ' Refurbished', 9.99, 19, 19, to_date('06-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (448, ' Business Handbag', ' New', 19.99, 19, 14, to_date('17-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (449, ' Lightweight Suitcase', ' New', 59.99, 19, 12, to_date('08-06-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (450, ' Travel Pillow', ' Refurbished', 9.99, 19, 11, to_date('15-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (451, ' Camera Backpack', ' New', 9.99, 19, 22, to_date('24-11-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (452, ' Lightweight Tripod', ' Refurbished', 19.99, 19, 22, to_date('06-05-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (453, ' Portable Photo Printer', ' New', 79.99, 19, 19, to_date('08-10-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (454, ' High-Speed Memory Card', ' New', 9.99, 19, 27, to_date('31-10-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (455, ' Smartphone Stabilizer', ' New', 49.99, 19, 22, to_date('23-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (456, ' Virtual Reality Headset', ' Refurbished', 149.99, 19, 9, to_date('11-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (457, ' Camera Drone', ' New', 249.99, 19, 15, to_date('23-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (458, ' Action Camera', ' New', 99.99, 19, 21, to_date('14-09-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (459, ' 3D Printer Kit', ' New', 399.99, 19, 3, to_date('09-11-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (460, ' Electric Scooter', ' New', 199.99, 19, 21, to_date('03-11-2024', 'dd-mm-yyyy'));
commit;
prompt 400 records committed...
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (461, ' Laptop Cooling Pad', ' Refurbished', 16.49, 1, 11, to_date('03-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (462, ' Portable SSD', ' New', 129.99, 11, 29, to_date('25-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (463, ' Laser Printer', ' Refurbished', 79.99, 2, 8, to_date('08-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (464, ' Ergonomic Mouse', ' Refurbished', 11.54, 1, 4, to_date('16-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (465, ' Mechanical Gaming Keyboard', ' New', 79.99, 5, 15, to_date('14-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (466, ' Gaming Chair', ' New', 149.99, 5, 13, to_date('11-10-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (467, ' Gaming Headset', ' New', 49.99, 6, 24, to_date('24-06-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (468, ' Wireless Earphones', ' New', 39.99, 6, 20, to_date('12-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (469, ' Smart Fitness Band', ' New', 69.99, 12, 27, to_date('17-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (470, ' Mirrorless Camera', ' Refurbished', 599.99, 9, 28, to_date('06-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (471, ' Desk Lamp', ' New', 9.99, 10, 9, to_date('25-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (472, ' Smart Light Strip', ' New', 14.99, 10, 21, to_date('30-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (473, ' Mesh WiFi System', ' New', 99.99, 4, 27, to_date('06-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (474, ' Ethernet Cable', ' New', 9.99, 4, 19, to_date('21-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (476, ' AR Headset', ' New', 699.99, 28, 20, to_date('30-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (477, ' 3D Scanner', ' New', 399.99, 29, 26, to_date('08-07-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (478, ' Blood Glucose Monitor', ' New', 29.99, 17, 17, to_date('24-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (480, ' Pilates Mat', ' New', 14.99, 18, 16, to_date('02-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (481, ' Adjustable Dumbbells', ' New', 199.99, 18, 28, to_date('17-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (482, ' Rowing Machine', ' New', 599.99, 18, 14, to_date('28-08-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (483, ' Spin Bike', ' Refurbished', 299.99, 18, 26, to_date('16-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (484, ' Full Body Workout Machine', ' New', 999.99, 18, 25, to_date('21-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (486, ' Massage Roller', ' Refurbished', 14.99, 18, 14, to_date('03-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (487, ' OLED Smart TV', ' Refurbished', 999.99, 19, 16, to_date('05-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (488, ' 4K Streaming Device', ' New', 89.99, 19, 10, to_date('08-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (490, ' HD Projector', ' New', 699.99, 19, 25, to_date('16-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (491, ' Gaming PC', ' Refurbished', 1999.99, 19, 4, to_date('11-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (492, ' Dual Band WiFi Router', ' Refurbished', 29.99, 19, 21, to_date('22-06-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (493, ' Smart LED Bulbs', ' New', 14.99, 19, 24, to_date('03-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (30, ' Yoga Mat', ' New', 24.99, 18, 15, to_date('12-09-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (34, ' Exercise Bike', ' New', 299.99, 18, 14, to_date('09-03-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (38, ' Foam Roller', ' Refurbished', 14.99, 18, 12, to_date('19-04-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (43, ' Gaming Console', ' New', 399.99, 19, 8, to_date('10-08-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (48, ' Video Doorbell', ' Refurbished', 199.99, 19, 15, to_date('14-05-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (53, ' Garden Tools Set', ' Refurbished', 49.99, 19, 15, to_date('05-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (59, ' Leaf Blower', ' Refurbished', 99.99, 19, 20, to_date('30-12-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (64, ' Workbench', ' New', 99.99, 19, 13, to_date('22-03-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (68, ' Air Compressor', ' New', 149.99, 19, 5, to_date('11-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (73, ' Car Vacuum', ' New', 29.99, 19, 14, to_date('05-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (77, ' Car Seat Cover', ' New', 49.99, 19, 22, to_date('14-04-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (81, ' Jump Starter', ' New', 69.99, 19, 29, to_date('02-10-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (86, ' Backpack', ' Refurbished', 49.99, 19, 12, to_date('10-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (90, ' Camera Bag', ' New', 34.99, 19, 15, to_date('21-03-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (94, ' Smartphone Gimbal', ' New', 79.99, 19, 28, to_date('30-05-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (99, ' Electric Scooter', ' Refurbished', 299.99, 19, 13, to_date('08-11-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (105, ' Noise Cancelling Headphones', ' New', 129.99, 20, 12, to_date('26-03-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (111, ' Smartphone Case', ' Refurbished', 14.99, 20, 27, to_date('17-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (117, ' Blender', ' New', 59.99, 20, 11, to_date('20-03-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (121, ' Electric Toothbrush', ' Refurbished', 39.99, 20, 2, to_date('16-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (127, ' Pulse Oximeter', ' New', 49.99, 20, 24, to_date('08-03-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (132, ' Resistance Bands', ' New', 19.99, 20, 18, to_date('09-08-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (137, ' Jump Rope', ' Refurbished', 9.99, 20, 18, to_date('13-11-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (142, ' Projector', ' Refurbished', 299.99, 21, 24, to_date('15-02-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (147, ' Security Camera', ' New', 79.99, 21, 14, to_date('22-03-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (152, ' Indoor Plant', ' New', 39.99, 21, 23, to_date('19-08-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (156, ' Hammock', ' Refurbished', 39.99, 21, 13, to_date('09-12-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (161, ' Tool Kit', ' New', 29.99, 21, 29, to_date('19-02-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (165, ' Safety Goggles', ' Refurbished', 9.99, 21, 26, to_date('04-05-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (170, ' Screwdriver Set', ' New', 14.99, 21, 5, to_date('29-06-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (175, ' GPS Navigator', ' New', 99.99, 21, 18, to_date('03-09-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (179, ' Car Air Purifier', ' New', 39.99, 21, 7, to_date('13-02-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (184, ' Wristwatch', ' New', 39.99, 21, 3, to_date('13-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (188, ' Suitcase', ' New', 79.99, 21, 27, to_date('25-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (192, ' Photo Printer', ' Refurbished', 149.99, 21, 17, to_date('01-01-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (233, ' Nest Thermostat', ' New', 179.99, 19, 29, to_date('11-12-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (238, ' Fingerprint Smart Lock', ' New', 199.99, 19, 23, to_date('23-05-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (244, ' Fire Table', ' New', 499.99, 19, 20, to_date('14-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (248, ' Basic Tool Set', ' New', 19.99, 19, 19, to_date('05-05-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (253, ' Mechanic Gloves', ' New', 14.99, 19, 9, to_date('15-10-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (258, ' Socket and Wrench Set', ' Refurbished', 39.99, 19, 26, to_date('12-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (264, ' Car Seat Cover Set', ' New', 59.99, 19, 28, to_date('16-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (269, ' Tool Chest', ' Refurbished', 149.99, 19, 4, to_date('12-12-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (274, ' Business Handbag', ' Refurbished', 24.99, 19, 28, to_date('31-07-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (280, ' High-Speed Memory Card', ' Refurbished', 9.99, 19, 20, to_date('13-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (287, ' Laptop Cooling Pad', ' New', 28.86, 1, 14, to_date('22-11-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (292, ' Gaming Chair', ' New', 199.99, 5, 28, to_date('15-02-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (297, ' Desk Lamp', ' New', 19.99, 10, 28, to_date('22-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (301, ' Gaming PC', ' New', 1299.99, 5, 26, to_date('10-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (305, ' Beard Trimmer', ' Refurbished', 39.99, 12, 10, to_date('02-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (310, ' Full Body Workout Machine', ' New', 1299.99, 18, 12, to_date('30-11-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (316, ' HD Projector', ' New', 699.99, 19, 16, to_date('26-08-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (321, ' Indoor Security Camera', ' New', 49.99, 19, 22, to_date('29-09-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (326, ' Indoor Plant Collection', ' New', 59.99, 19, 28, to_date('14-10-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (332, ' Robotic Lawn Mower', ' Refurbished', 499.99, 19, 15, to_date('17-10-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (338, ' Garage Workbench', ' Refurbished', 99.99, 19, 16, to_date('15-05-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (344, ' Precision Screwdriver Set', ' Refurbished', 4.99, 19, 23, to_date('06-10-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (351, ' Car Seat Cover Set', ' Refurbished', 29.99, 19, 25, to_date('17-09-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (357, ' Sunglasses', ' New', 9.99, 19, 15, to_date('27-09-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (362, ' Lightweight Suitcase', ' Refurbished', 49.99, 19, 19, to_date('30-01-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (475, ' Gaming PC', ' New', 1599.99, 5, 15, to_date('18-12-2024', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (479, ' Beard Trimmer', ' Refurbished', 29.99, 12, 1, to_date('20-07-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (485, ' Jump Rope', ' New', 9.99, 18, 5, to_date('14-11-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (489, ' Dolby Atmos Sound Bar', ' New', 399.99, 19, 14, to_date('04-12-2023', 'dd-mm-yyyy'));
insert into PRODUCTS (product_id, product_name, information, price, category_id, stock, available_date)
values (494, ' Nest Thermostat', ' Refurbished', 99.99, 19, 25, to_date('18-08-2024', 'dd-mm-yyyy'));
commit;
prompt 494 records loaded
prompt Loading REVIEWS...
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (1, 7.3, 'Fast shipping', to_date('15-06-2023', 'dd-mm-yyyy'), 462, 10105);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (2, 5.5, 'Excellent quality', to_date('29-12-2024', 'dd-mm-yyyy'), 233, 10644);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (3, 4.8, 'Top-notch item', to_date('21-05-2023', 'dd-mm-yyyy'), 170, 10394);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (4, 4.1, 'Top-notch item', to_date('06-11-2023', 'dd-mm-yyyy'), 264, 10507);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (5, 6, 'Great features', to_date('25-07-2023', 'dd-mm-yyyy'), 217, 10397);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (6, 9, 'Five stars', to_date('14-12-2023', 'dd-mm-yyyy'), 404, 10017);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (7, 8.9, 'Great design', to_date('02-08-2023', 'dd-mm-yyyy'), 169, 10346);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (8, 9.9, 'Not as expected', to_date('06-07-2023', 'dd-mm-yyyy'), 264, 10605);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (9, 8, 'Top-notch item', to_date('29-06-2024', 'dd-mm-yyyy'), 492, 10406);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (10, 6.1, 'High quality', to_date('06-04-2024', 'dd-mm-yyyy'), 448, 10366);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (11, 2.2, 'Value for money', to_date('13-02-2024', 'dd-mm-yyyy'), 227, 10469);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (12, 6.2, 'Excellent service', to_date('23-01-2023', 'dd-mm-yyyy'), 149, 10597);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (13, 5.3, 'Too expensive', to_date('12-09-2023', 'dd-mm-yyyy'), 285, 10244);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (14, 1.9, 'Highly recommend', to_date('05-11-2023', 'dd-mm-yyyy'), 175, 10135);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (15, 2, 'Well made', to_date('14-12-2023', 'dd-mm-yyyy'), 282, 10262);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (16, 4.2, 'Happy customer', to_date('28-01-2024', 'dd-mm-yyyy'), 368, 10428);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (17, 8.5, 'Will buy again', to_date('12-02-2023', 'dd-mm-yyyy'), 87, 10047);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (18, 8.5, 'Great design', to_date('22-07-2024', 'dd-mm-yyyy'), 52, 10182);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (19, 3.4, 'Impressed', to_date('25-01-2023', 'dd-mm-yyyy'), 255, 10428);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (20, 9.3, 'Impressed', to_date('29-09-2023', 'dd-mm-yyyy'), 109, 10429);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (21, 5.8, 'Great design', to_date('13-07-2023', 'dd-mm-yyyy'), 129, 10499);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (22, 9.3, 'Would recommend', to_date('06-08-2023', 'dd-mm-yyyy'), 475, 10216);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (23, 6.8, 'Value for money', to_date('02-05-2023', 'dd-mm-yyyy'), 445, 10500);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (24, 3.4, 'Great design', to_date('08-04-2024', 'dd-mm-yyyy'), 370, 10227);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (25, 5.2, 'Subpar quality', to_date('26-06-2023', 'dd-mm-yyyy'), 438, 10484);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (26, 8.5, 'Good value', to_date('09-09-2024', 'dd-mm-yyyy'), 77, 10539);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (27, 6.2, 'Will buy again', to_date('31-07-2023', 'dd-mm-yyyy'), 429, 10352);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (28, 7.6, 'Five stars', to_date('04-10-2024', 'dd-mm-yyyy'), 401, 10336);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (29, 7.1, 'Does the job', to_date('11-05-2024', 'dd-mm-yyyy'), 160, 10153);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (30, 7.5, 'Very useful', to_date('15-12-2023', 'dd-mm-yyyy'), 261, 10316);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (31, 8.2, 'Great design', to_date('23-01-2024', 'dd-mm-yyyy'), 62, 10373);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (32, 1.6, 'Excellent service', to_date('18-12-2024', 'dd-mm-yyyy'), 437, 10468);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (33, 9, 'Good value', to_date('31-05-2023', 'dd-mm-yyyy'), 302, 10530);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (34, 9.7, 'Just okay', to_date('02-04-2024', 'dd-mm-yyyy'), 81, 10065);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (35, 4.2, 'Exceeded expectations', to_date('23-04-2023', 'dd-mm-yyyy'), 236, 10007);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (36, 9.2, 'Fast delivery', to_date('12-12-2024', 'dd-mm-yyyy'), 383, 10672);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (37, 4.9, 'Subpar quality', to_date('10-10-2024', 'dd-mm-yyyy'), 6, 10687);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (38, 5.9, 'High quality', to_date('14-08-2023', 'dd-mm-yyyy'), 45, 10232);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (39, 7.3, 'Does the job', to_date('22-09-2024', 'dd-mm-yyyy'), 384, 10483);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (40, 2.8, 'Would recommend', to_date('31-12-2023', 'dd-mm-yyyy'), 61, 10269);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (41, 3.5, 'Not worth it', to_date('28-08-2023', 'dd-mm-yyyy'), 207, 10368);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (42, 2.3, 'Value for money', to_date('12-04-2024', 'dd-mm-yyyy'), 275, 10359);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (43, 8.7, 'Exceeded expectations', to_date('02-06-2024', 'dd-mm-yyyy'), 464, 10099);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (44, 5.7, 'Returned it', to_date('05-09-2024', 'dd-mm-yyyy'), 345, 10209);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (45, 6.3, 'Very satisfied', to_date('02-06-2023', 'dd-mm-yyyy'), 13, 10685);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (46, 6.2, 'Decent purchase', to_date('02-06-2023', 'dd-mm-yyyy'), 296, 10003);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (47, 3.3, 'Not as expected', to_date('24-03-2024', 'dd-mm-yyyy'), 471, 10683);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (48, 1.5, 'Not impressed', to_date('30-04-2024', 'dd-mm-yyyy'), 155, 10662);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (49, 2.1, 'Just okay', to_date('20-10-2023', 'dd-mm-yyyy'), 386, 10606);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (50, 2.5, 'Great product!', to_date('30-03-2023', 'dd-mm-yyyy'), 453, 10661);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (51, 6.2, 'Good value', to_date('01-06-2024', 'dd-mm-yyyy'), 22, 10628);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (52, 9.1, 'Happy customer', to_date('02-11-2024', 'dd-mm-yyyy'), 250, 10519);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (53, 5.3, 'Love this item', to_date('16-12-2024', 'dd-mm-yyyy'), 220, 10429);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (54, 9.6, 'Top-notch item', to_date('17-06-2024', 'dd-mm-yyyy'), 121, 10410);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (55, 7.6, 'Too expensive', to_date('04-01-2023', 'dd-mm-yyyy'), 219, 10482);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (56, 8.7, 'Does the job', to_date('05-02-2024', 'dd-mm-yyyy'), 150, 10072);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (57, 8.4, 'Low quality', to_date('24-07-2024', 'dd-mm-yyyy'), 138, 10501);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (58, 1.1, 'Excellent quality', to_date('06-10-2023', 'dd-mm-yyyy'), 367, 10473);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (59, 9.2, 'Low quality', to_date('21-03-2023', 'dd-mm-yyyy'), 201, 10347);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (60, 8.4, 'Will return', to_date('30-11-2024', 'dd-mm-yyyy'), 358, 10595);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (61, 6.5, 'Not worth it', to_date('06-09-2023', 'dd-mm-yyyy'), 342, 10412);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (62, 2, 'Fast delivery', to_date('22-05-2024', 'dd-mm-yyyy'), 63, 10362);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (63, 1.9, 'Too expensive', to_date('11-12-2024', 'dd-mm-yyyy'), 200, 10010);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (64, 6.5, 'Happy customer', to_date('10-10-2023', 'dd-mm-yyyy'), 418, 10338);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (65, 7.3, 'Superb performance', to_date('28-08-2023', 'dd-mm-yyyy'), 172, 10607);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (66, 7.2, 'Cheap but good', to_date('01-06-2023', 'dd-mm-yyyy'), 251, 10466);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (67, 7.4, 'Not worth it', to_date('31-10-2024', 'dd-mm-yyyy'), 340, 10301);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (68, 7.1, 'Five stars', to_date('02-04-2024', 'dd-mm-yyyy'), 274, 10621);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (69, 5.6, 'Great features', to_date('10-09-2024', 'dd-mm-yyyy'), 284, 10065);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (70, 7.3, 'Excellent quality', to_date('10-10-2023', 'dd-mm-yyyy'), 106, 10281);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (71, 2.7, 'Too expensive', to_date('27-10-2023', 'dd-mm-yyyy'), 296, 10169);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (72, 2, 'Value for money', to_date('21-06-2024', 'dd-mm-yyyy'), 170, 10174);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (73, 4.1, 'Happy customer', to_date('12-05-2023', 'dd-mm-yyyy'), 48, 10042);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (74, 8.1, 'Good value', to_date('12-09-2023', 'dd-mm-yyyy'), 14, 10293);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (75, 6.4, 'Great design', to_date('02-09-2023', 'dd-mm-yyyy'), 177, 10218);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (76, 8.5, 'Highly recommend', to_date('24-05-2024', 'dd-mm-yyyy'), 378, 10176);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (77, 9.9, 'Very satisfied', to_date('10-10-2024', 'dd-mm-yyyy'), 191, 10205);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (78, 2.1, 'Just okay', to_date('10-08-2024', 'dd-mm-yyyy'), 308, 10282);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (79, 7.3, 'Not worth it', to_date('16-06-2024', 'dd-mm-yyyy'), 97, 10532);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (80, 1.1, 'Not impressed', to_date('07-05-2023', 'dd-mm-yyyy'), 192, 10575);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (81, 2.8, 'Very useful', to_date('21-08-2023', 'dd-mm-yyyy'), 97, 10265);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (82, 5, 'Fast delivery', to_date('31-01-2023', 'dd-mm-yyyy'), 74, 10283);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (83, 1.6, 'Superb performance', to_date('21-06-2023', 'dd-mm-yyyy'), 19, 10386);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (84, 9.4, 'Impressed', to_date('25-07-2024', 'dd-mm-yyyy'), 194, 10695);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (85, 7, 'Low quality', to_date('05-11-2024', 'dd-mm-yyyy'), 31, 10106);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (86, 5.8, 'Will buy again', to_date('20-12-2024', 'dd-mm-yyyy'), 106, 10140);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (87, 9.8, 'Too expensive', to_date('21-06-2024', 'dd-mm-yyyy'), 71, 10630);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (88, 9.6, 'Does the job', to_date('25-02-2024', 'dd-mm-yyyy'), 59, 10472);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (89, 5.8, 'Does the job', to_date('07-12-2024', 'dd-mm-yyyy'), 404, 10680);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (90, 9.2, 'Top-notch item', to_date('01-04-2024', 'dd-mm-yyyy'), 370, 10034);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (91, 5.3, 'Fast shipping', to_date('12-11-2024', 'dd-mm-yyyy'), 191, 10587);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (92, 3.8, 'Love this item', to_date('09-04-2024', 'dd-mm-yyyy'), 123, 10263);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (93, 8, 'Very satisfied', to_date('14-01-2024', 'dd-mm-yyyy'), 205, 10383);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (94, 5.6, 'Highly recommend', to_date('06-10-2023', 'dd-mm-yyyy'), 242, 10360);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (95, 6.7, 'Does the job', to_date('17-08-2024', 'dd-mm-yyyy'), 43, 10394);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (96, 7.9, 'Will buy again', to_date('26-11-2024', 'dd-mm-yyyy'), 194, 10125);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (97, 6.9, 'Excellent service', to_date('28-07-2024', 'dd-mm-yyyy'), 313, 10059);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (98, 7.7, 'Value for money', to_date('14-05-2023', 'dd-mm-yyyy'), 22, 10204);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (99, 8.5, 'Will return', to_date('27-07-2023', 'dd-mm-yyyy'), 281, 10301);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (100, 5.4, 'Superb performance', to_date('17-01-2023', 'dd-mm-yyyy'), 129, 10357);
commit;
prompt 100 records committed...
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (101, 4.3, 'Works perfectly', to_date('04-06-2023', 'dd-mm-yyyy'), 202, 10495);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (102, 2.4, 'Very satisfied', to_date('12-08-2023', 'dd-mm-yyyy'), 402, 10132);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (103, 9.4, 'Impressed', to_date('03-11-2023', 'dd-mm-yyyy'), 429, 10473);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (104, 7.1, 'Not worth it', to_date('02-09-2024', 'dd-mm-yyyy'), 376, 10358);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (105, 5.3, 'Cheap but good', to_date('10-10-2024', 'dd-mm-yyyy'), 443, 10280);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (106, 5.4, 'Five stars', to_date('29-07-2023', 'dd-mm-yyyy'), 105, 10489);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (107, 3.5, 'Love this item', to_date('04-03-2023', 'dd-mm-yyyy'), 133, 10187);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (108, 7.2, 'Fast shipping', to_date('17-04-2023', 'dd-mm-yyyy'), 294, 10031);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (109, 7.6, 'Very useful', to_date('12-05-2023', 'dd-mm-yyyy'), 255, 10673);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (110, 9.4, 'Highly recommend', to_date('15-11-2023', 'dd-mm-yyyy'), 467, 10583);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (111, 1.7, 'Great features', to_date('21-10-2024', 'dd-mm-yyyy'), 283, 10316);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (112, 7.5, 'Returned it', to_date('01-07-2023', 'dd-mm-yyyy'), 136, 10447);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (113, 4.7, 'Excellent quality', to_date('30-04-2024', 'dd-mm-yyyy'), 278, 10482);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (114, 9.6, 'High quality', to_date('17-07-2024', 'dd-mm-yyyy'), 164, 10095);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (115, 6.3, 'Five stars', to_date('03-08-2024', 'dd-mm-yyyy'), 141, 10623);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (116, 5.1, 'Excellent service', to_date('06-04-2024', 'dd-mm-yyyy'), 303, 10647);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (117, 3.1, 'Decent purchase', to_date('11-06-2024', 'dd-mm-yyyy'), 66, 10558);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (118, 8.8, 'Top-notch item', to_date('10-10-2023', 'dd-mm-yyyy'), 433, 10028);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (119, 2.9, 'Would recommend', to_date('24-03-2024', 'dd-mm-yyyy'), 73, 10330);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (120, 1.3, 'Subpar quality', to_date('09-06-2023', 'dd-mm-yyyy'), 43, 10243);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (121, 5.9, 'Not worth it', to_date('07-11-2023', 'dd-mm-yyyy'), 240, 10547);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (122, 1.5, 'Subpar quality', to_date('07-03-2024', 'dd-mm-yyyy'), 308, 10012);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (123, 3.7, 'Excellent quality', to_date('10-02-2024', 'dd-mm-yyyy'), 328, 10120);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (124, 3.8, 'Does the job', to_date('06-03-2023', 'dd-mm-yyyy'), 318, 10147);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (125, 3.8, 'Does the job', to_date('07-02-2024', 'dd-mm-yyyy'), 23, 10166);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (126, 5.6, 'Disappointed', to_date('01-09-2023', 'dd-mm-yyyy'), 485, 10105);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (127, 3.7, 'Exceeded expectations', to_date('18-09-2023', 'dd-mm-yyyy'), 283, 10397);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (128, 4.1, 'Impressed', to_date('26-09-2024', 'dd-mm-yyyy'), 429, 10242);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (129, 2, 'Subpar quality', to_date('10-09-2024', 'dd-mm-yyyy'), 336, 10591);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (130, 2.8, 'Not worth it', to_date('15-06-2024', 'dd-mm-yyyy'), 11, 10070);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (131, 7.5, 'Excellent service', to_date('30-01-2024', 'dd-mm-yyyy'), 205, 10602);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (132, 5.2, 'Very useful', to_date('08-06-2023', 'dd-mm-yyyy'), 270, 10669);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (133, 1.1, 'Good value', to_date('22-10-2024', 'dd-mm-yyyy'), 482, 10364);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (134, 3.5, 'Fast delivery', to_date('04-06-2024', 'dd-mm-yyyy'), 245, 10412);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (135, 8, 'Works perfectly', to_date('01-04-2023', 'dd-mm-yyyy'), 304, 10368);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (136, 5, 'Amazing service', to_date('11-02-2023', 'dd-mm-yyyy'), 24, 10297);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (137, 4.1, 'Low quality', to_date('24-06-2023', 'dd-mm-yyyy'), 309, 10679);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (138, 3.1, 'Terrible purchase', to_date('30-04-2023', 'dd-mm-yyyy'), 17, 10601);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (139, 8.5, 'Works perfectly', to_date('21-03-2024', 'dd-mm-yyyy'), 388, 10658);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (140, 6.5, 'Five stars', to_date('28-12-2023', 'dd-mm-yyyy'), 53, 10106);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (141, 6.1, 'Does the job', to_date('04-12-2023', 'dd-mm-yyyy'), 83, 10073);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (142, 5.5, 'Will buy again', to_date('13-12-2024', 'dd-mm-yyyy'), 139, 10532);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (143, 1.6, 'Not as expected', to_date('30-04-2023', 'dd-mm-yyyy'), 58, 10422);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (144, 8.4, 'Five stars', to_date('07-03-2024', 'dd-mm-yyyy'), 422, 10479);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (145, 6.3, 'High quality', to_date('28-03-2024', 'dd-mm-yyyy'), 326, 10061);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (146, 1.2, 'Great features', to_date('09-11-2024', 'dd-mm-yyyy'), 463, 10281);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (147, 8.6, 'Value for money', to_date('20-07-2023', 'dd-mm-yyyy'), 44, 10561);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (148, 8.2, 'Decent purchase', to_date('25-10-2023', 'dd-mm-yyyy'), 117, 10513);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (149, 5.8, 'Not as expected', to_date('04-03-2023', 'dd-mm-yyyy'), 33, 10681);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (150, 9.6, 'Cheap but good', to_date('21-10-2023', 'dd-mm-yyyy'), 462, 10357);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (151, 8.4, 'Just okay', to_date('12-09-2023', 'dd-mm-yyyy'), 429, 10593);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (152, 2.8, 'Decent purchase', to_date('28-12-2024', 'dd-mm-yyyy'), 82, 10574);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (153, 7.3, 'Will buy again', to_date('17-03-2024', 'dd-mm-yyyy'), 207, 10122);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (154, 5, 'High quality', to_date('17-05-2023', 'dd-mm-yyyy'), 133, 10678);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (155, 7.2, 'Highly recommend', to_date('13-12-2024', 'dd-mm-yyyy'), 53, 10153);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (156, 3.7, 'Amazing service', to_date('08-07-2023', 'dd-mm-yyyy'), 490, 10454);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (157, 1.7, 'Low quality', to_date('14-09-2023', 'dd-mm-yyyy'), 16, 10181);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (158, 9.8, 'Excellent quality', to_date('25-12-2024', 'dd-mm-yyyy'), 85, 10102);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (159, 1.8, 'Happy customer', to_date('23-09-2024', 'dd-mm-yyyy'), 17, 10169);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (160, 3.8, 'Great features', to_date('11-09-2024', 'dd-mm-yyyy'), 97, 10329);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (161, 8.7, 'Cheap but good', to_date('18-03-2023', 'dd-mm-yyyy'), 168, 10550);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (162, 2, 'Excellent service', to_date('25-10-2023', 'dd-mm-yyyy'), 318, 10690);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (163, 3.3, 'Not worth it', to_date('06-05-2024', 'dd-mm-yyyy'), 19, 10105);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (164, 6.6, 'Five stars', to_date('23-01-2024', 'dd-mm-yyyy'), 191, 10694);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (165, 6.8, 'Fast shipping', to_date('31-10-2024', 'dd-mm-yyyy'), 64, 10128);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (166, 2.5, 'Just okay', to_date('16-10-2023', 'dd-mm-yyyy'), 279, 10011);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (167, 2.6, 'Great design', to_date('02-06-2023', 'dd-mm-yyyy'), 69, 10457);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (168, 6.4, 'Value for money', to_date('10-05-2024', 'dd-mm-yyyy'), 475, 10444);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (169, 5.8, 'Highly recommend', to_date('11-09-2024', 'dd-mm-yyyy'), 116, 10628);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (170, 5.9, 'Exceeded expectations', to_date('02-03-2024', 'dd-mm-yyyy'), 431, 10471);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (171, 5.5, 'Excellent quality', to_date('07-07-2024', 'dd-mm-yyyy'), 17, 10241);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (172, 5.9, 'Top-notch item', to_date('21-08-2024', 'dd-mm-yyyy'), 24, 10130);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (173, 9.4, 'Well made', to_date('16-05-2024', 'dd-mm-yyyy'), 483, 10209);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (174, 6.1, 'Excellent quality', to_date('09-11-2024', 'dd-mm-yyyy'), 273, 10464);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (175, 5, 'Not impressed', to_date('31-12-2023', 'dd-mm-yyyy'), 312, 10416);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (176, 1.8, 'Excellent service', to_date('03-11-2023', 'dd-mm-yyyy'), 290, 10097);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (177, 9.9, 'Not as expected', to_date('22-05-2024', 'dd-mm-yyyy'), 451, 10045);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (178, 9.6, 'Too expensive', to_date('20-01-2024', 'dd-mm-yyyy'), 196, 10159);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (179, 4.1, 'Fast delivery', to_date('12-07-2023', 'dd-mm-yyyy'), 133, 10528);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (180, 2.5, 'Great features', to_date('16-08-2023', 'dd-mm-yyyy'), 323, 10178);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (181, 2.3, 'Will buy again', to_date('05-08-2024', 'dd-mm-yyyy'), 327, 10037);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (182, 5.8, 'Too expensive', to_date('11-04-2024', 'dd-mm-yyyy'), 395, 10372);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (183, 8.1, 'Fantastic buy', to_date('13-03-2023', 'dd-mm-yyyy'), 489, 10563);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (184, 2.8, 'Fast delivery', to_date('17-11-2023', 'dd-mm-yyyy'), 199, 10126);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (185, 8.5, 'Subpar quality', to_date('27-07-2024', 'dd-mm-yyyy'), 437, 10614);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (186, 6.2, 'Superb performance', to_date('01-06-2023', 'dd-mm-yyyy'), 21, 10394);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (187, 3.7, 'Well made', to_date('15-10-2023', 'dd-mm-yyyy'), 297, 10547);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (188, 2.4, 'Great design', to_date('14-09-2024', 'dd-mm-yyyy'), 100, 10088);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (189, 6.6, 'Would recommend', to_date('28-10-2023', 'dd-mm-yyyy'), 349, 10464);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (190, 1.6, 'Superb performance', to_date('13-11-2023', 'dd-mm-yyyy'), 413, 10165);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (191, 1.4, 'Superb performance', to_date('02-02-2024', 'dd-mm-yyyy'), 198, 10443);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (192, 7.8, 'Excellent quality', to_date('25-03-2023', 'dd-mm-yyyy'), 432, 10649);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (193, 2.1, 'Very satisfied', to_date('22-12-2023', 'dd-mm-yyyy'), 54, 10526);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (194, 6.1, 'Amazing service', to_date('10-05-2023', 'dd-mm-yyyy'), 35, 10426);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (195, 1.7, 'Will buy again', to_date('29-09-2023', 'dd-mm-yyyy'), 378, 10217);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (196, 9, 'Does the job', to_date('06-02-2024', 'dd-mm-yyyy'), 45, 10017);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (197, 7.3, 'Too expensive', to_date('25-08-2023', 'dd-mm-yyyy'), 59, 10207);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (198, 7.5, 'Not worth it', to_date('22-07-2023', 'dd-mm-yyyy'), 16, 10277);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (199, 2.2, 'Works perfectly', to_date('14-08-2024', 'dd-mm-yyyy'), 1, 10172);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (200, 9.6, 'Good value', to_date('22-12-2024', 'dd-mm-yyyy'), 164, 10121);
commit;
prompt 200 records committed...
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (201, 6.3, 'Does the job', to_date('26-04-2023', 'dd-mm-yyyy'), 404, 10010);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (202, 4.9, 'Fast shipping', to_date('26-01-2023', 'dd-mm-yyyy'), 278, 10128);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (203, 8.7, 'Love this item', to_date('01-03-2024', 'dd-mm-yyyy'), 77, 10397);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (204, 8.2, 'Not as expected', to_date('30-11-2024', 'dd-mm-yyyy'), 492, 10634);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (205, 9.9, 'Returned it', to_date('07-10-2023', 'dd-mm-yyyy'), 237, 10399);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (206, 2.5, 'Decent purchase', to_date('22-11-2023', 'dd-mm-yyyy'), 436, 10025);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (207, 1.5, 'Not worth it', to_date('11-09-2024', 'dd-mm-yyyy'), 337, 10444);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (208, 4.9, 'Impressed', to_date('07-12-2023', 'dd-mm-yyyy'), 253, 10048);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (209, 4.1, 'Not worth it', to_date('14-06-2024', 'dd-mm-yyyy'), 191, 10219);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (210, 2.1, 'Very useful', to_date('05-12-2024', 'dd-mm-yyyy'), 48, 10287);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (211, 4.8, 'Amazing service', to_date('07-02-2023', 'dd-mm-yyyy'), 79, 10558);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (212, 7.2, 'Fast delivery', to_date('17-08-2024', 'dd-mm-yyyy'), 289, 10677);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (213, 8.4, 'Fast shipping', to_date('10-06-2024', 'dd-mm-yyyy'), 54, 10258);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (214, 2.3, 'Low quality', to_date('07-09-2024', 'dd-mm-yyyy'), 287, 10377);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (215, 7, 'Not as expected', to_date('16-12-2023', 'dd-mm-yyyy'), 225, 10311);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (216, 4.9, 'Will buy again', to_date('13-03-2023', 'dd-mm-yyyy'), 452, 10637);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (217, 7.5, 'Very useful', to_date('23-02-2023', 'dd-mm-yyyy'), 147, 10226);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (218, 5.7, 'Too expensive', to_date('07-09-2023', 'dd-mm-yyyy'), 371, 10504);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (219, 2.3, 'Low quality', to_date('09-06-2023', 'dd-mm-yyyy'), 23, 10517);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (220, 2.4, 'Excellent service', to_date('08-09-2023', 'dd-mm-yyyy'), 10, 10152);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (221, 2.6, 'Highly recommend', to_date('09-08-2024', 'dd-mm-yyyy'), 146, 10668);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (222, 2.4, 'Cheap but good', to_date('05-10-2023', 'dd-mm-yyyy'), 466, 10121);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (223, 3.8, 'Fast delivery', to_date('17-02-2024', 'dd-mm-yyyy'), 185, 10429);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (224, 9.4, 'Happy customer', to_date('27-10-2023', 'dd-mm-yyyy'), 485, 10685);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (225, 6.7, 'Will buy again', to_date('26-06-2023', 'dd-mm-yyyy'), 60, 10551);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (226, 7.1, 'Happy customer', to_date('11-10-2023', 'dd-mm-yyyy'), 202, 10277);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (227, 7.5, 'Good value', to_date('22-01-2023', 'dd-mm-yyyy'), 215, 10645);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (228, 1.6, 'Impressed', to_date('02-04-2023', 'dd-mm-yyyy'), 144, 10072);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (229, 8, 'Just okay', to_date('24-07-2023', 'dd-mm-yyyy'), 285, 10290);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (230, 6.5, 'Exceeded expectations', to_date('11-11-2023', 'dd-mm-yyyy'), 304, 10122);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (231, 3.2, 'Love this item', to_date('13-01-2024', 'dd-mm-yyyy'), 15, 10576);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (232, 9.8, 'Just okay', to_date('04-08-2023', 'dd-mm-yyyy'), 35, 10326);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (233, 1.2, 'Very useful', to_date('19-11-2023', 'dd-mm-yyyy'), 298, 10598);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (234, 5.2, 'Does the job', to_date('20-10-2024', 'dd-mm-yyyy'), 192, 10484);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (235, 8.1, 'Disappointed', to_date('06-09-2023', 'dd-mm-yyyy'), 154, 10544);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (236, 1.9, 'Love this item', to_date('13-01-2024', 'dd-mm-yyyy'), 175, 10143);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (237, 6.2, 'Great design', to_date('28-04-2024', 'dd-mm-yyyy'), 45, 10282);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (238, 6.1, 'Well made', to_date('21-08-2023', 'dd-mm-yyyy'), 295, 10271);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (239, 8.4, 'Fantastic buy', to_date('14-03-2023', 'dd-mm-yyyy'), 298, 10533);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (240, 9.4, 'Cheap but good', to_date('16-12-2024', 'dd-mm-yyyy'), 122, 10307);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (241, 8.4, 'Fantastic buy', to_date('05-10-2024', 'dd-mm-yyyy'), 388, 10511);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (242, 8.8, 'Highly recommend', to_date('27-01-2023', 'dd-mm-yyyy'), 184, 10354);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (243, 3.2, 'Excellent quality', to_date('09-04-2024', 'dd-mm-yyyy'), 301, 10386);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (244, 4.1, 'Five stars', to_date('18-04-2024', 'dd-mm-yyyy'), 38, 10693);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (245, 5.8, 'Returned it', to_date('05-08-2024', 'dd-mm-yyyy'), 490, 10140);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (246, 1.5, 'Disappointed', to_date('20-10-2024', 'dd-mm-yyyy'), 48, 10339);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (247, 6.2, 'Impressed', to_date('11-02-2024', 'dd-mm-yyyy'), 236, 10140);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (248, 9.3, 'Would recommend', to_date('29-01-2024', 'dd-mm-yyyy'), 447, 10615);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (249, 1.8, 'Five stars', to_date('25-10-2023', 'dd-mm-yyyy'), 102, 10453);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (250, 8.3, 'Excellent quality', to_date('30-04-2023', 'dd-mm-yyyy'), 326, 10440);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (251, 5.6, 'Returned it', to_date('11-02-2023', 'dd-mm-yyyy'), 179, 10032);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (252, 9.5, 'Not as expected', to_date('10-12-2024', 'dd-mm-yyyy'), 4, 10447);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (253, 7.5, 'Love this item', to_date('07-05-2023', 'dd-mm-yyyy'), 453, 10064);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (254, 9.2, 'Will return', to_date('21-05-2023', 'dd-mm-yyyy'), 335, 10509);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (255, 2, 'Great features', to_date('31-01-2023', 'dd-mm-yyyy'), 207, 10619);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (256, 2.9, 'Well made', to_date('23-12-2024', 'dd-mm-yyyy'), 87, 10549);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (257, 5.7, 'Too expensive', to_date('25-11-2024', 'dd-mm-yyyy'), 73, 10100);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (258, 6.1, 'Great design', to_date('19-07-2024', 'dd-mm-yyyy'), 358, 10377);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (259, 5.6, 'Fantastic buy', to_date('28-06-2024', 'dd-mm-yyyy'), 203, 10107);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (260, 8.6, 'Top-notch item', to_date('01-10-2023', 'dd-mm-yyyy'), 470, 10641);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (261, 7.3, 'Good value', to_date('10-01-2023', 'dd-mm-yyyy'), 263, 10035);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (262, 3, 'Low quality', to_date('13-02-2023', 'dd-mm-yyyy'), 359, 10217);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (263, 7.1, 'Fast delivery', to_date('02-10-2023', 'dd-mm-yyyy'), 158, 10160);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (264, 7.9, 'Not worth it', to_date('03-11-2024', 'dd-mm-yyyy'), 80, 10231);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (265, 3.4, 'Will return', to_date('04-08-2024', 'dd-mm-yyyy'), 476, 10458);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (266, 7.3, 'Amazing service', to_date('28-11-2023', 'dd-mm-yyyy'), 44, 10539);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (267, 5.8, 'Works perfectly', to_date('26-12-2023', 'dd-mm-yyyy'), 333, 10155);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (268, 6, 'Good value', to_date('26-09-2024', 'dd-mm-yyyy'), 175, 10083);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (269, 3.4, 'Returned it', to_date('03-06-2023', 'dd-mm-yyyy'), 63, 10510);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (270, 3.9, 'Exceeded expectations', to_date('15-12-2024', 'dd-mm-yyyy'), 113, 10172);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (271, 7.7, 'Highly recommend', to_date('15-03-2023', 'dd-mm-yyyy'), 241, 10588);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (272, 8, 'Not impressed', to_date('11-06-2024', 'dd-mm-yyyy'), 488, 10067);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (273, 1.5, 'Would recommend', to_date('21-04-2024', 'dd-mm-yyyy'), 224, 10293);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (274, 6.3, 'Fantastic buy', to_date('07-11-2024', 'dd-mm-yyyy'), 253, 10588);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (275, 8.4, 'Fast shipping', to_date('05-06-2024', 'dd-mm-yyyy'), 486, 10157);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (276, 1.4, 'Great features', to_date('18-08-2024', 'dd-mm-yyyy'), 252, 10058);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (277, 5.1, 'Top-notch item', to_date('04-02-2023', 'dd-mm-yyyy'), 139, 10549);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (278, 3.9, 'Just okay', to_date('09-09-2024', 'dd-mm-yyyy'), 428, 10584);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (279, 3.3, 'Superb performance', to_date('14-09-2024', 'dd-mm-yyyy'), 262, 10582);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (280, 4.1, 'Works perfectly', to_date('07-09-2023', 'dd-mm-yyyy'), 321, 10243);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (281, 6.5, 'Top-notch item', to_date('04-02-2024', 'dd-mm-yyyy'), 151, 10482);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (282, 5.7, 'Great product!', to_date('16-04-2023', 'dd-mm-yyyy'), 238, 10520);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (283, 1.5, 'Superb performance', to_date('10-06-2024', 'dd-mm-yyyy'), 235, 10517);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (284, 6.3, 'Highly recommend', to_date('23-06-2024', 'dd-mm-yyyy'), 280, 10174);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (285, 9.1, 'Fast shipping', to_date('30-06-2024', 'dd-mm-yyyy'), 285, 10340);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (286, 3.4, 'Will buy again', to_date('29-09-2024', 'dd-mm-yyyy'), 208, 10477);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (287, 7.5, 'Will buy again', to_date('04-02-2023', 'dd-mm-yyyy'), 379, 10682);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (288, 2, 'Exceeded expectations', to_date('30-03-2024', 'dd-mm-yyyy'), 340, 10271);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (289, 4.6, 'Terrible purchase', to_date('17-01-2024', 'dd-mm-yyyy'), 301, 10189);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (290, 4.3, 'Happy customer', to_date('06-12-2023', 'dd-mm-yyyy'), 16, 10696);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (291, 6.5, 'Amazing service', to_date('20-08-2023', 'dd-mm-yyyy'), 277, 10520);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (292, 8.2, 'Fantastic buy', to_date('14-05-2024', 'dd-mm-yyyy'), 179, 10556);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (293, 5.4, 'Value for money', to_date('01-09-2024', 'dd-mm-yyyy'), 199, 10463);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (294, 7.8, 'Value for money', to_date('13-01-2024', 'dd-mm-yyyy'), 241, 10194);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (295, 2.7, 'Does the job', to_date('07-10-2024', 'dd-mm-yyyy'), 113, 10447);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (296, 1.6, 'Low quality', to_date('30-05-2023', 'dd-mm-yyyy'), 335, 10681);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (297, 7.8, 'Too expensive', to_date('20-04-2023', 'dd-mm-yyyy'), 205, 10249);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (298, 7.3, 'Disappointed', to_date('19-09-2024', 'dd-mm-yyyy'), 424, 10178);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (299, 6.8, 'Great features', to_date('27-05-2024', 'dd-mm-yyyy'), 215, 10156);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (300, 6.9, 'Amazing service', to_date('20-04-2023', 'dd-mm-yyyy'), 29, 10579);
commit;
prompt 300 records committed...
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (301, 3.8, 'Love this item', to_date('03-08-2023', 'dd-mm-yyyy'), 391, 10656);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (302, 3.1, 'Just okay', to_date('27-12-2023', 'dd-mm-yyyy'), 251, 10105);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (303, 9.3, 'Low quality', to_date('18-04-2024', 'dd-mm-yyyy'), 101, 10394);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (304, 3.8, 'Not worth it', to_date('14-12-2024', 'dd-mm-yyyy'), 251, 10549);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (305, 2.2, 'Five stars', to_date('22-09-2024', 'dd-mm-yyyy'), 186, 10476);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (306, 6.9, 'Amazing service', to_date('30-05-2023', 'dd-mm-yyyy'), 376, 10352);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (307, 9.7, 'Exceeded expectations', to_date('16-05-2024', 'dd-mm-yyyy'), 81, 10416);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (308, 5.9, 'Love this item', to_date('01-03-2024', 'dd-mm-yyyy'), 289, 10451);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (309, 9.6, 'Top-notch item', to_date('18-02-2024', 'dd-mm-yyyy'), 167, 10216);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (310, 7.9, 'Works perfectly', to_date('08-09-2024', 'dd-mm-yyyy'), 53, 10401);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (311, 9.7, 'Great features', to_date('05-09-2023', 'dd-mm-yyyy'), 178, 10298);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (312, 1.2, 'Would recommend', to_date('15-03-2023', 'dd-mm-yyyy'), 248, 10677);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (313, 9.3, 'Too expensive', to_date('04-03-2023', 'dd-mm-yyyy'), 211, 10693);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (314, 3.2, 'Would recommend', to_date('14-04-2024', 'dd-mm-yyyy'), 193, 10546);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (315, 7.6, 'Fast shipping', to_date('12-06-2023', 'dd-mm-yyyy'), 168, 10651);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (316, 5.6, 'High quality', to_date('31-10-2023', 'dd-mm-yyyy'), 454, 10029);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (317, 1.8, 'Very useful', to_date('01-09-2023', 'dd-mm-yyyy'), 85, 10000);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (318, 4.8, 'Cheap but good', to_date('14-02-2023', 'dd-mm-yyyy'), 372, 10583);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (319, 5.8, 'Would recommend', to_date('18-03-2024', 'dd-mm-yyyy'), 205, 10169);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (320, 3.8, 'Terrible purchase', to_date('14-03-2024', 'dd-mm-yyyy'), 165, 10507);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (321, 4.1, 'Does the job', to_date('20-05-2023', 'dd-mm-yyyy'), 275, 10577);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (322, 3, 'Subpar quality', to_date('16-12-2024', 'dd-mm-yyyy'), 149, 10339);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (323, 1, 'Disappointed', to_date('30-06-2023', 'dd-mm-yyyy'), 137, 10009);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (324, 4.9, 'Disappointed', to_date('24-05-2024', 'dd-mm-yyyy'), 71, 10493);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (325, 4.4, 'Will buy again', to_date('04-04-2023', 'dd-mm-yyyy'), 490, 10465);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (326, 2.5, 'Cheap but good', to_date('31-07-2023', 'dd-mm-yyyy'), 357, 10047);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (327, 2, 'Fast delivery', to_date('23-12-2024', 'dd-mm-yyyy'), 190, 10387);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (328, 3.3, 'Returned it', to_date('31-12-2023', 'dd-mm-yyyy'), 375, 10692);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (329, 8.4, 'Cheap but good', to_date('10-07-2023', 'dd-mm-yyyy'), 301, 10420);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (330, 6.1, 'Superb performance', to_date('02-05-2023', 'dd-mm-yyyy'), 168, 10173);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (331, 1.1, 'Not as expected', to_date('31-08-2024', 'dd-mm-yyyy'), 394, 10129);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (332, 3.5, 'Fast shipping', to_date('12-07-2023', 'dd-mm-yyyy'), 175, 10453);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (333, 7.1, 'Superb performance', to_date('07-07-2024', 'dd-mm-yyyy'), 86, 10608);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (334, 4.6, 'Great product!', to_date('29-02-2024', 'dd-mm-yyyy'), 184, 10462);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (335, 5.5, 'Impressed', to_date('26-12-2023', 'dd-mm-yyyy'), 188, 10316);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (336, 1.2, 'Good value', to_date('26-01-2024', 'dd-mm-yyyy'), 78, 10095);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (337, 6.3, 'Top-notch item', to_date('29-04-2024', 'dd-mm-yyyy'), 89, 10015);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (338, 5.5, 'Great design', to_date('04-09-2024', 'dd-mm-yyyy'), 156, 10246);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (339, 4.1, 'Very satisfied', to_date('25-04-2024', 'dd-mm-yyyy'), 271, 10014);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (340, 5.8, 'Not worth it', to_date('17-12-2023', 'dd-mm-yyyy'), 168, 10500);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (341, 6.5, 'Impressed', to_date('24-01-2024', 'dd-mm-yyyy'), 454, 10640);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (342, 9.8, 'Very useful', to_date('30-05-2023', 'dd-mm-yyyy'), 369, 10139);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (343, 6.3, 'Not worth it', to_date('22-11-2023', 'dd-mm-yyyy'), 480, 10279);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (344, 9.1, 'Love this item', to_date('11-11-2023', 'dd-mm-yyyy'), 443, 10547);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (345, 6.5, 'Not as expected', to_date('21-11-2023', 'dd-mm-yyyy'), 271, 10557);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (346, 1.6, 'Impressed', to_date('23-10-2024', 'dd-mm-yyyy'), 2, 10509);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (347, 8.8, 'Exceeded expectations', to_date('25-07-2024', 'dd-mm-yyyy'), 451, 10569);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (348, 6.1, 'Excellent service', to_date('29-01-2024', 'dd-mm-yyyy'), 58, 10110);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (349, 4.1, 'Cheap but good', to_date('15-08-2023', 'dd-mm-yyyy'), 243, 10667);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (350, 8.5, 'Highly recommend', to_date('30-01-2023', 'dd-mm-yyyy'), 231, 9999);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (351, 9.8, 'Does the job', to_date('21-05-2024', 'dd-mm-yyyy'), 61, 10609);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (352, 6.3, 'Decent purchase', to_date('13-06-2024', 'dd-mm-yyyy'), 248, 10438);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (353, 8.6, 'Exceeded expectations', to_date('18-01-2024', 'dd-mm-yyyy'), 341, 10464);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (354, 3.7, 'Top-notch item', to_date('15-06-2023', 'dd-mm-yyyy'), 226, 10351);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (355, 5.6, 'Love this item', to_date('26-06-2024', 'dd-mm-yyyy'), 230, 10603);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (356, 1.8, 'Does the job', to_date('01-09-2023', 'dd-mm-yyyy'), 120, 10183);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (357, 8, 'Not impressed', to_date('20-09-2023', 'dd-mm-yyyy'), 249, 10299);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (358, 2.4, 'Excellent service', to_date('07-01-2023', 'dd-mm-yyyy'), 472, 10131);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (359, 4, 'Will buy again', to_date('12-03-2023', 'dd-mm-yyyy'), 335, 10561);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (360, 4.4, 'Amazing service', to_date('08-05-2023', 'dd-mm-yyyy'), 310, 10256);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (361, 8.2, 'Works perfectly', to_date('02-06-2024', 'dd-mm-yyyy'), 168, 10514);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (362, 9.1, 'Top-notch item', to_date('27-08-2023', 'dd-mm-yyyy'), 314, 10081);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (363, 8.6, 'Good value', to_date('29-11-2024', 'dd-mm-yyyy'), 486, 10410);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (364, 7.4, 'Not impressed', to_date('03-10-2024', 'dd-mm-yyyy'), 473, 10025);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (365, 1.4, 'Not impressed', to_date('15-01-2023', 'dd-mm-yyyy'), 128, 10572);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (366, 2.3, 'Great features', to_date('07-03-2024', 'dd-mm-yyyy'), 476, 10242);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (367, 7.5, 'Not as expected', to_date('04-09-2023', 'dd-mm-yyyy'), 203, 10598);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (368, 5.7, 'Excellent quality', to_date('03-06-2024', 'dd-mm-yyyy'), 428, 10470);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (369, 4.7, 'Cheap but good', to_date('24-01-2024', 'dd-mm-yyyy'), 65, 10107);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (370, 5.7, 'Would recommend', to_date('13-05-2023', 'dd-mm-yyyy'), 160, 10004);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (371, 4.9, 'Love this item', to_date('14-11-2023', 'dd-mm-yyyy'), 24, 10309);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (372, 6.2, 'Exceeded expectations', to_date('11-08-2023', 'dd-mm-yyyy'), 66, 10683);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (373, 2.8, 'Excellent service', to_date('24-05-2023', 'dd-mm-yyyy'), 81, 10487);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (374, 3.5, 'Will buy again', to_date('06-10-2023', 'dd-mm-yyyy'), 204, 10507);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (375, 6.2, 'Returned it', to_date('05-02-2023', 'dd-mm-yyyy'), 317, 10346);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (376, 6.2, 'Five stars', to_date('29-11-2024', 'dd-mm-yyyy'), 171, 10156);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (377, 3, 'Superb performance', to_date('27-09-2024', 'dd-mm-yyyy'), 386, 10038);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (378, 6.5, 'Works perfectly', to_date('24-02-2023', 'dd-mm-yyyy'), 196, 10583);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (379, 1.6, 'Not as expected', to_date('21-08-2024', 'dd-mm-yyyy'), 88, 10458);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (380, 9.6, 'Just okay', to_date('26-10-2023', 'dd-mm-yyyy'), 21, 10613);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (381, 4.9, 'High quality', to_date('13-04-2024', 'dd-mm-yyyy'), 107, 10080);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (382, 3, 'Would recommend', to_date('20-06-2024', 'dd-mm-yyyy'), 272, 10006);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (383, 6.2, 'Low quality', to_date('26-06-2023', 'dd-mm-yyyy'), 209, 10613);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (384, 9.1, 'Exceeded expectations', to_date('18-08-2023', 'dd-mm-yyyy'), 79, 10565);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (385, 8.9, 'Excellent service', to_date('27-10-2023', 'dd-mm-yyyy'), 170, 10593);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (386, 8.1, 'Very satisfied', to_date('07-01-2024', 'dd-mm-yyyy'), 185, 10207);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (387, 8.1, 'Disappointed', to_date('04-06-2024', 'dd-mm-yyyy'), 268, 10535);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (388, 1.2, 'Does the job', to_date('16-07-2024', 'dd-mm-yyyy'), 461, 10499);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (389, 4.1, 'Fantastic buy', to_date('21-02-2023', 'dd-mm-yyyy'), 260, 10190);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (390, 2.9, 'Good value', to_date('23-11-2023', 'dd-mm-yyyy'), 206, 10460);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (391, 4.2, 'Five stars', to_date('14-02-2023', 'dd-mm-yyyy'), 131, 10380);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (392, 1.7, 'Great features', to_date('27-03-2024', 'dd-mm-yyyy'), 289, 10339);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (393, 9.5, 'Impressed', to_date('27-10-2024', 'dd-mm-yyyy'), 269, 10567);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (394, 8.5, 'Amazing service', to_date('04-05-2023', 'dd-mm-yyyy'), 144, 10346);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (395, 7.2, 'High quality', to_date('09-09-2023', 'dd-mm-yyyy'), 114, 10690);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (396, 6.6, 'Too expensive', to_date('09-11-2023', 'dd-mm-yyyy'), 204, 10415);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (397, 7.8, 'Excellent service', to_date('03-03-2023', 'dd-mm-yyyy'), 455, 10369);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (398, 1.8, 'Very useful', to_date('13-01-2024', 'dd-mm-yyyy'), 307, 10558);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (399, 9.1, 'Decent purchase', to_date('07-09-2024', 'dd-mm-yyyy'), 225, 10667);
insert into REVIEWS (review_id, rating, comment_text, review_date, product_id, buyer_id)
values (400, 6.2, 'Not worth it', to_date('29-08-2023', 'dd-mm-yyyy'), 70, 10565);
commit;
prompt 400 records loaded
prompt Loading SELLERS...
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Sam Evett', 11111, '512345678', '45 Rich Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Natasha Ifans', 11120, '512345693', '519 Billerica Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Eddie Scorsese', 11129, '512345708', '70 Monmouth Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Javon Cale', 11138, '512345723', '51 Darmstadt Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Tzi Whitley', 11147, '512345738', '62 Ball Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Gord Stallone', 11156, '512345753', '89 Meniketti Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rhona Lillard', 11165, '512345768', '12 Ali Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Juliette Unger', 11174, '512345783', '18 Burwood East Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Chuck Newton', 11183, '512345798', '74 Belo Horizonte Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Nelly Garber', 11192, '512345813', '93 Rucker Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Natascha Neil', 11201, '512345828', '616 Hutch Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kirk Alexander', 11210, '512345843', '65 Arturo Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Tori Solido', 11219, '512345858', '43rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Patti Orton', 11228, '512345873', '48 Stuermer Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Vern Flatts', 11237, '512345888', '17 McFadden Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Suzanne Morse', 11246, '512345903', '94 Noseworthy Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Betty Rankin', 11255, '512345918', '27 Boorem Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Gerald Tolkan', 11264, '512345933', '72 Campinas Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Hal Palin', 11273, '512345948', '278 Swank Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Emm Bates', 11282, '512345963', '79 Luedenscheid');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rolando Wopat', 11291, '512345978', '67 Wen Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Vern Ricci', 11300, '512345993', '52nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jack Root', 11309, '512346008', '188 Root Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Dylan Red', 11318, '512346023', '44 Ohita Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('France Farina', 11327, '512346038', '96 Oslo Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Michelle Vicious', 11336, '512346053', '73rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Luke Neuwirth', 11345, '512346068', '41st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ron Moody', 11354, '512346083', '82 Chaykin Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Walter Donelly', 11363, '512346098', '55 Horb Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Terence Cross', 11372, '512346113', '70 Warsaw Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Anna Sample', 11381, '512346128', '411 Luis Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Halle Edmunds', 11390, '512346143', '398 First Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jeremy Ness', 11399, '512346158', '18 Pirmasens');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Phil Marie', 11408, '512346173', '156 Sweet Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Dionne Dorn', 11417, '512346188', '78 Penelope Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Brian Matthau', 11426, '512346203', '63 Fierstein Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Fred Serbedzija', 11435, '512346218', '741 Bright Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Art Carlton', 11444, '512346233', '66 Ilmenau Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Tanya Quaid', 11453, '512346248', '91 Sewell Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Angelina Statham', 11462, '512346263', '85 Busta Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Chubby Wiest', 11471, '512346278', '73 Jeanne Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Diamond Springfield', 11480, '512346293', '1 Hyderabad Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Grant D''Onofrio', 11489, '512346308', '22 Lindsay Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Avenged Donelly', 11498, '512346323', '88 Fort McMurray Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ashley Rickman', 11507, '512346338', '41 Oulu Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Heath Mitra', 11516, '512346353', '16 James Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Nastassja Mazzello', 11525, '512346368', '9 La Plata Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Gino Berkoff', 11534, '512346383', '41 Valentin Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kylie McFadden', 11543, '512346398', '891 Chely Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Nikki Kirshner', 11552, '512346413', '25 El Paso Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Darius Bryson', 11561, '512346428', '42nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Grace Detmer', 11570, '512346443', '41st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Terri Browne', 11579, '512346458', '965 Spine Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Hikaru Hynde', 11588, '512346473', '76 Ratzenberger Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lee Balk', 11597, '512346488', '39 Haverhill Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Faye Anderson', 11606, '512346503', '68 O''Sullivan Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Bradley Shorter', 11615, '512346518', '22nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Delbert Steagall', 11624, '512346533', '54 Williamstown Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Nina Branch', 11633, '512346548', '80 Paal Beringen Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Sam Kershaw', 11642, '512346563', '63rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Billy Davison', 11651, '512346578', '49 Jordan Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ellen Domino', 11660, '512346593', '36 Rtp');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Albert Brooke', 11669, '512346608', '485 Delta Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Cheech Clayton', 11678, '512346623', '25 Roberta Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Annie Leto', 11687, '512346638', '254 Burke Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Joe Soul', 11696, '512346653', '40 Canberra Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Martin Fariq', 11705, '512346668', '16 Russo Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Maura Kotto', 11714, '512346683', '169 Bedfordshire Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rhona Polito', 11723, '512346698', '90 Melba Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Buddy Detmer', 11732, '512346713', '18 Chazz Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Nigel Foster', 11741, '512346728', '14 Squier Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Tobey Morales', 11750, '512346743', '7 Ferrer Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kimberly McPherson', 11759, '512346758', '29 Davies Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Hilton Tippe', 11768, '512346773', '53rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Martha Bates', 11777, '512346788', '289 Joey Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kurt Thewlis', 11786, '512346803', '64 Brendan Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kevn Houston', 11795, '512346818', '82nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Chloe Farina', 11804, '512346833', '11 Flower mound');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Delroy Idle', 11813, '512346848', '33 Ness');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Karen Latifah', 11822, '512346863', '96 Miguel Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Selma Soul', 11831, '512346878', '695 Zürich Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Danny Katt', 11840, '512346893', '49 Piven Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Geoffrey Frakes', 11849, '512346908', '59 Sapulpa Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ceili Kinney', 11858, '512346923', '86 Guamo Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Joey Rollins', 11867, '512346938', '61 Cathy Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Deborah Nicholson', 11876, '512346953', '53 Nynäshamn Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Mandy Paltrow', 11885, '512346968', '35 Keith Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Leo Stigers', 11894, '512346983', '55 Ribisi Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Celia Macht', 11903, '512346998', '49 Millie Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Fisher Forrest', 11912, '512347013', '51 Craig Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Cate Sarandon', 11921, '512347028', '17 Rickie Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Tea Margulies', 11930, '512347043', '31 Karachi Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Andie Ryan', 11939, '512347058', '80 Laurel Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Keith Pollack', 11948, '512347073', '100 Royersford Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Roddy Peniston', 11957, '512347088', '62 Holly Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Angela Turner', 11966, '512347103', '24 Jean-Luc Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Isaiah McAnally', 11975, '512347118', '25 Platt Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Buffy Lynn', 11984, '512347133', '60 Suzanne Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rutger Gough', 11993, '512347148', '71st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Harris Arkenstone', 12002, '512347163', '38 Rush Drive');
commit;
prompt 100 records committed...
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Johnnie Margolyes', 12011, '512347178', '72nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Connie Holm', 12020, '512347193', '51st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Robbie Miller', 12029, '512347208', '58 Grant Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Leon Rockwell', 12038, '512347223', '87 Kenneth Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Steve Vai', 12047, '512347238', '10 Jeremy Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Deborah Bracco', 12056, '512347253', '22nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Angela Astin', 12065, '512347268', '82 Purefoy Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Keith Geldof', 12074, '512347283', '49 Wiest Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Joely Marx', 12083, '512347298', '32nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Temuera Moreno', 12092, '512347313', '21 Scorsese');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Malcolm Gellar', 12101, '512347328', '61 Emerson Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Aaron Pryce', 12110, '512347343', '62nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Wayman Spector', 12119, '512347358', '29 Henstridge Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Denzel Weisz', 12128, '512347373', '67 Bedfordshire Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Yolanda Laurie', 12137, '512347388', '933 Osment Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Stockard Goodman', 12146, '512347403', '21 Angie Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Tcheky Osbourne', 12155, '512347418', '94 Osbourne Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Dionne Snow', 12164, '512347433', '55 Rosie Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Glen Assante', 12173, '512347448', '43 Gabriel Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Campbell Kleinenberg', 12182, '512347463', '93rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ricky Sayer', 12191, '512347478', '20 Ali Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ahmad Connelly', 12200, '512347493', '340 Cohn Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Katie Cumming', 12209, '512347508', '632 Geena Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ernest Gellar', 12218, '512347523', '38 Chesnutt Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Steve Downie', 12227, '512347538', '55 Archer Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ben Glover', 12236, '512347553', '246 Wayman Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Matt Alda', 12245, '512347568', '776 Lewis Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lorraine Payton', 12254, '512347583', '52 Dutton');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Bob Baranski', 12263, '512347598', '3 Anderson Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Will DeVito', 12272, '512347613', '62 Reid Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Derrick Torino', 12281, '512347628', '8 Reubens Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ice Stiles', 12290, '512347643', '862 Gettysburg');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Johnette Cromwell', 12299, '512347658', '23 Hounslow Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Larnelle Ojeda', 12308, '512347673', '83 Bolton Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Holly Osmond', 12317, '512347688', '67 Bryan Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Paula Lawrence', 12326, '512347703', '708 Warren Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Anne Gano', 12335, '512347718', '7 Weller Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Wang Horizon', 12344, '512347733', '29 Mel Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Hector Raitt', 12353, '512347748', '62 Travolta Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ernie Biehn', 12362, '512347763', '73 Chorzów Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Vickie Barry', 12371, '512347778', '71 Hagerty Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Isabella Stiles', 12380, '512347793', '14 Christian Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Larnelle Gordon', 12389, '512347808', '56 N. ft. Myers Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Pamela Flanery', 12398, '512347823', '62 Cochran Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kasey Hawke', 12407, '512347838', '5 Jesus Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Sona Rio', 12416, '512347853', '55 Holts Summit');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Colin Martin', 12425, '512347868', '967 Garry Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Carla Richards', 12434, '512347883', '64 Dwight Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Meredith Cumming', 12443, '512347898', '82nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Emm Delta', 12452, '512347913', '12nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Chloe Boyle', 12461, '512347928', '15 Joaquin Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Shawn Dukakis', 12470, '512347943', '28 San Dimas Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Penelope Steiger', 12479, '512347958', '59 Patton Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Suzy Harris', 12488, '512347973', '15 Joinville Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Marley Tucker', 12497, '512347988', '11 Mollard Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rutger Sandoval', 12506, '512348003', '19 Berkoff Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Leonardo Renfro', 12515, '512348018', '907 Thorton Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Luis Rourke', 12524, '512348033', '46 Quaid');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Stewart Sawa', 12533, '512348048', '62nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ossie Heron', 12542, '512348063', '99 Aaron Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Veruca Abraham', 12551, '512348078', '69 Hawthorne');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Halle Bassett', 12560, '512348093', '63rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Melanie Withers', 12569, '512348108', '56 Thompson Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lonnie Botti', 12578, '512348123', '35 Macy Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Eliza Curfman', 12587, '512348138', '68 Cantrell Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rebecca Andrews', 12596, '512348153', '83rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Wally Venora', 12605, '512348168', '8 Lavigne');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Annie Mathis', 12614, '512348183', '31 Griffith Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kevn Holden', 12623, '512348198', '26 Nik Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Buffy Lachey', 12632, '512348213', '73 Akins Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lee Alston', 12641, '512348228', '51 Leary Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jodie Michael', 12650, '512348243', '42 Kershaw Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Orlando Weiss', 12659, '512348258', '74 Sarsgaard Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kitty Blair', 12668, '512348273', '24 Braintree');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kris Dysart', 12677, '512348288', '20 Taipei Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Alec Latifah', 12686, '512348303', '915 Mayfield Village Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kelly Mueller-Stahl', 12695, '512348318', '10 Merchant Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Nastassja Schwarzene', 12704, '512348333', '22 Deejay Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Murray Suchet', 12713, '512348348', '31 Sinise');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Geoff Gibson', 12722, '512348363', '42nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Graham Dayne', 12731, '512348378', '438 Ottawa Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Carrie-Anne Nighting', 12740, '512348393', '40 Murphy Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Frances Lewis', 12749, '512348408', '22 Holm Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rik Nivola', 12758, '512348423', '7 Creek Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ossie Hamilton', 12767, '512348438', '2 Webb Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rutger Harrelson', 12776, '512348453', '13 Benet Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Keanu Shannon', 12785, '512348468', '67 Sorvino');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Carla Teng', 12794, '512348483', '6 Ammons Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Wally English', 12803, '512348498', '22 Zellweger Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Richie Farina', 12812, '512348513', '421 Spears');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Meredith MacIsaac', 12821, '512348528', '25 Roberta Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Merrill Azaria', 12830, '512348543', '67 Chilton Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Miranda Dayne', 12839, '512348558', '58 Donald Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Pierce O''Donnell', 12848, '512348573', '13 Nepean Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Naomi Barrymore', 12857, '512348588', '17 Weiland Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Solomon Sossamon', 12866, '512348603', '298 Jarvis Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Raymond Wells', 12875, '512348618', '60 Evans Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jake Rizzo', 12884, '512348633', '56 Percy Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Liev Mandrell', 12893, '512348648', '94 Slmea Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Paula Shannon', 12902, '512348663', '32nd Street');
commit;
prompt 200 records committed...
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Davy Pfeiffer', 12911, '512348678', '88 Tzi Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Andre Gershon', 12920, '512348693', '602 Holden Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Fred Briscoe', 12929, '512348708', '33 Collin Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Gilbert Damon', 12938, '512348723', '24 Lipnicki Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ted McDonald', 12947, '512348738', '11 Anjelica Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Terence Astin', 12956, '512348753', '27 Barry Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Terrence Lowe', 12965, '512348768', '96 Leelee');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Alan Flemyng', 12974, '512348783', '824 Moffat');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Devon Neil', 12983, '512348798', '74 Rhames Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ivan Newton', 12992, '512348813', '51 Mathis Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Clarence Vaughn', 13001, '512348828', '850 Ving Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Vanessa El-Saher', 13010, '512348843', '24 Benson');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Brittany Harrison', 13019, '512348858', '82 Fairview Heights Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Mia Womack', 13028, '512348873', '72 Hutch Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Samuel Atkins', 13037, '512348888', '7 Jimmy Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Adina Michael', 13046, '512348903', '69 Judi Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Neil Fehr', 13055, '512348918', '98 Dourif Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Davy Sartain', 13064, '512348933', '41 Red Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Cheech Cheadle', 13073, '512348948', '552 Marty Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lydia Supernaw', 13082, '512348963', '702 Unger Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Anna Tsettos', 13091, '512348978', '28 Parish Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Adrien Hunter', 13100, '512348993', '85 Vaduz Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Carlene Neeson', 13109, '512349008', '5 Doucette Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Omar Sweeney', 13118, '512349023', '12 Guadalajara Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rebecca Bonneville', 13127, '512349038', '76 Willem Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kay Child', 13136, '512349053', '11st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Curtis Wahlberg', 13145, '512349068', '51 Ty Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Samantha Schwarzeneg', 13154, '512349083', '32nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Armand Nightingale', 13163, '512349098', '93 Frank Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Carrie-Anne Paul', 13172, '512349113', '85 Maserada sul Piave Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lena Cohn', 13181, '512349128', '44 Gibson Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Dick Conley', 13190, '512349143', '30 Parsons Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Bradley Dern', 13199, '512349158', '2 Monroe Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Marty Firth', 13208, '512349173', '48 Delroy Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kurtwood Winwood', 13217, '512349188', '83 Sainte-foy Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jeffery Conners', 13226, '512349203', '49 Mary Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Busta Shocked', 13235, '512349218', '92nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Brent Albright', 13244, '512349233', '45 Whitman Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Adrien Sanders', 13253, '512349248', '322 Burke Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ryan Paxton', 13262, '512349263', '50 Liv Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Sammy Sanchez', 13271, '512349278', '49 Beck Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kurtwood Root', 13280, '512349293', '47 Treat Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Roscoe Clark', 13289, '512349308', '46 Elizabeth Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Larnelle Kweller', 13298, '512349323', '90 Harris Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Shawn Twilley', 13307, '512349338', '64 Paul Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rachael Byrd', 13316, '512349353', '4 Callow Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jonathan LaMond', 13325, '512349368', '80 Morioka Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Joely McBride', 13334, '512349383', '74 Nikki Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Glenn Ojeda', 13343, '512349398', '74 Kweller Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Nora von Sydow', 13352, '512349413', '73rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lonnie Coolidge', 13361, '512349428', '915 Badalucco Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kathleen Duchovny', 13370, '512349443', '71 DeGraw Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Nick Spiner', 13379, '512349458', '949 Watson Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Yaphet Harary', 13388, '512349473', '96 Debby');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ryan Gatlin', 13397, '512349488', '288 Ittigen Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Joaquin Cash', 13406, '512349503', '42 Iglesias Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Breckin Mould', 13415, '512349518', '288 Burton Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Herbie Stiers', 13424, '512349533', '7 Swayze Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lili Elliott', 13433, '512349548', '42 Fox Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Dave Sedaka', 13442, '512349563', '3 Carlisle Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Stanley Steagall', 13451, '512349578', '62nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Olympia Kidman', 13460, '512349593', '82nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Emmylou Wiedlin', 13469, '512349608', '61 Padova Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Leo Senior', 13478, '512349623', '268 Loretta Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Beth Nivola', 13487, '512349638', '51 Getty Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ronnie Cleese', 13496, '512349653', '82 Forest Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kirsten Sandler', 13505, '512349668', '553 Farrell Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Clive Colman', 13514, '512349683', '48 Roscoe Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Liv Kinnear', 13523, '512349698', '23rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Brooke Deschanel', 13532, '512349713', '235 Matt Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kim Aykroyd', 13541, '512349728', '87 Nynäshamn Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ritchie Huston', 13550, '512349743', '9 Nanaimo Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Alex Duncan', 13559, '512349758', '96 McCabe');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Hazel Borgnine', 13568, '512349773', '38 Changwon-si Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lucy Hatchet', 13577, '512349788', '91st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Gil Holland', 13586, '512349803', '57 Murdock Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Billy Mathis', 13595, '512349818', '47 Shand Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Toshiro Garcia', 13604, '512349833', '75 Dzundza');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('King Foxx', 13613, '512349848', '12 Schaumburg Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Chrissie Rhames', 13622, '512349863', '57 Ingram Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Emily Karyo', 13631, '512349878', '44 Warwick Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Faye Amos', 13640, '512349893', '32nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Gene Keitel', 13649, '512349908', '27 Addy Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Cloris Farina', 13658, '512349923', '60 Cherry Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Denny Van Damme', 13667, '512349938', '96 Close Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jeroen Bradford', 13676, '512349953', '84 Brown Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Chanté Buscemi', 13685, '512349968', '40 Penelope Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rachael Hatchet', 13694, '512349983', '62 LaBelle Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ethan Dourif', 13703, '512349998', '55 Hobson Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Renee Pollack', 13712, '512350013', '100 Murray Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Winona Nash', 13721, '512350028', '72 McIntyre Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Don Hewitt', 13730, '512350043', '84 Nagano Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Nile Patillo', 13739, '512350058', '2 Leary Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jennifer Aykroyd', 13748, '512350073', '39 Woking Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kevn Berkley', 13757, '512350088', '56 Eindhoven Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Brooke Matthau', 13766, '512350103', '89 Rossellini Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Juan Sayer', 13775, '512350118', '7 Kristofferson');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jessica Fiorentino', 13784, '512350133', '37 Horton Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Davy Unger', 13793, '512350148', '40 McCracken Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ian Saucedo', 13802, '512350163', '99 Lefkosa Ave');
commit;
prompt 300 records committed...
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rita Schwarzenegger', 13811, '512350178', '63 Shue Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Judy Walsh', 13820, '512350193', '52nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Petula Wopat', 13829, '512350208', '3 Winwood Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Susan Moraz', 13838, '512350223', '20 Maguire Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Tamala Bosco', 13847, '512350238', '11 Duvall Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Phoebe Leigh', 13856, '512350253', '6 Baez Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Aidan Weiland', 13865, '512350268', '9 Conshohocken Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ahmad Phillippe', 13874, '512350283', '26 Olin Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jeffrey Wilson', 13883, '512350298', '7 Dean Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rutger Sevigny', 13892, '512350313', '53 Kozani Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Arnold Paul', 13901, '512350328', '98 Street Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Latin Nivola', 13910, '512350343', '34 Isaak Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Aimee Chapman', 13919, '512350358', '31 Dourif Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lois Spacek', 13928, '512350373', '40 Coe Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rob Blaine', 13937, '512350388', '14 Whoopi Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Morris Briscoe', 13946, '512350403', '5 Ball Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Liquid Frampton', 13955, '512350418', '566 Almond Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Denny Robbins', 13964, '512350433', '29 Carrington Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lesley Zappacosta', 13973, '512350448', '59 Scottsdale Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Brad Kenoly', 13982, '512350463', '58 Davidtz Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jeremy Arkenstone', 13991, '512350478', '14 Palo Alto Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kasey Donovan', 14000, '512350493', '8 Cassidy Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Danni Wong', 14009, '512350508', '25 Junior Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Claire Thewlis', 14018, '512350523', '16 Okayama Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Mira Caan', 14027, '512350538', '38 Orlando Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Shannon Amos', 14036, '512350553', '26 Hanley Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Gena Thurman', 14045, '512350568', '22nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Mekhi Gambon', 14054, '512350583', '880 Chambery Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Charlie Lennox', 14063, '512350598', '95 Tcheky Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Sonny Parker', 14072, '512350613', '31st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Fairuza Stuart', 14081, '512350628', '16 Matarazzo');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Petula Klein', 14090, '512350643', '86 Mekhi Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Collin Gano', 14099, '512350658', '10 Beals Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Anna Davidson', 14108, '512350673', '35 Leelee Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Maria Keener', 14117, '512350688', '1 Chilton Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jaime Carlton', 14126, '512350703', '55 Fukui Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Timothy Belles', 14135, '512350718', '39 Cozier Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('James Condition', 14144, '512350733', '38 Claude Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Michael Stiers', 14153, '512350748', '63rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Taryn Stampley', 14162, '512350763', '42nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rachael Tah', 14171, '512350778', '83 Denny');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Bernie Cherry', 14180, '512350793', '41 Ruiz Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Viggo Horton', 14189, '512350808', '51st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Danni Finn', 14198, '512350823', '63 Boyle Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Dan Flack', 14207, '512350838', '72nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Charles Weber', 14216, '512350853', '28 Moss');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Charlton Rea', 14225, '512350868', '21 Malcolm');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Sandra Bugnon', 14234, '512350883', '61 Ali Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Trace Jessee', 14243, '512350898', '87 Delroy Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Dustin Collins', 14252, '512350913', '32nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lindsay Heche', 14261, '512350928', '839 Shannon Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Oliver Wariner', 14270, '512350943', '1 William');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lucy Garber', 14279, '512350958', '32 Galecki Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Andrae Hobson', 14288, '512350973', '83rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ronny Santa Rosa', 14297, '512350988', '278 Brooke Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lila Tisdale', 14306, '512351003', '61st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Judy Rizzo', 14315, '512351018', '899 San Jose Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Talvin Idol', 14324, '512351033', '38 Marin Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rita Spears', 14333, '512351048', '33rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Sinead Soda', 14342, '512351063', '38 Tamala Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Elvis Favreau', 14351, '512351078', '72 Irving');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Arnold Mifune', 14360, '512351093', '32nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Patty Shaw', 14369, '512351108', '81 Roy Parnell');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Edie Tankard', 14378, '512351123', '641 Bell');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Carole Aglukark', 14387, '512351138', '32 Gene Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Corey Curtis-Hall', 14396, '512351153', '45 LaPaglia Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Alfie Goodman', 14405, '512351168', '19 Queen Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Anita Sewell', 14414, '512351183', '43 Treviso Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Maura Aglukark', 14423, '512351198', '90 Wilkinson Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Miriam Joli', 14432, '512351213', '161 Manchester Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Judi Conway', 14441, '512351228', '98 Harrelson Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Geoffrey Posener', 14450, '512351243', '15 MacDonald Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Todd Lynne', 14459, '512351258', '21 Hugh Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Terence Head', 14468, '512351273', '73 Barrymore Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Cameron Crouch', 14477, '512351288', '69 Ludbreg Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Tom Aiken', 14486, '512351303', '9 Gilliam Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Chi Wolf', 14495, '512351318', '43rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Sammy Camp', 14504, '512351333', '33 Sepulveda Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Emily Paige', 14513, '512351348', '18 Brothers Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Pam Nicholson', 14522, '512351363', '40 Gagnon Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Danny Tripplehorn', 14531, '512351378', '14 Lecanto Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lauren Silverman', 14540, '512351393', '678 Laurie Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Minnie Sampson', 14549, '512351408', '40 Anita Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rhett Cruz', 14558, '512351423', '79 Demi Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Holland Whitwam', 14567, '512351438', '3 Taylor Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Frank Rubinek', 14576, '512351453', '34 Raybon Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Tia Eder', 14585, '512351468', '69 Springfield Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ali Trevino', 14594, '512351483', '795 Rochester Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Peabo Coleman', 14603, '512351498', '923 Gliwice Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rhett Kline', 14612, '512351513', '62nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lari Olin', 14621, '512351528', '32nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rosanna Berkley', 14630, '512351543', '593 Thornton Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Gary Mortensen', 14639, '512351558', '340 Shearer Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('France Prinze', 14648, '512351573', '61 Chalee Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Howard Rucker', 14657, '512351588', '55 Tilburg Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ernie Chinlund', 14666, '512351603', '46 Lovitz Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Chalee Leguizamo', 14675, '512351618', '90 Spector Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Regina Gaynor', 14684, '512351633', '401 Nivola Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jessica Lloyd', 14693, '512351648', '30 Stavanger Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Elizabeth Adler', 14702, '512351663', '48 Chilton Drive');
commit;
prompt 400 records committed...
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Mos Hynde', 14711, '512351678', '62 Neneh Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kitty Weir', 14720, '512351693', '32 Conners Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Swoosie Gunton', 14729, '512351708', '5 Jill Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Joanna Henstridge', 14738, '512351723', '26 Coltrane Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Steven McKean', 14747, '512351738', '7 Gershon Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Toni Alda', 14756, '512351753', '842 Yaphet Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Anita Goldwyn', 14765, '512351768', '42 De Almeida Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ashton Russo', 14774, '512351783', '1 Tobey Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jane Playboys', 14783, '512351798', '29 Dourif Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Johnette Union', 14792, '512351813', '65 Cruise Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Cheryl Devine', 14801, '512351828', '421 Pam Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Joaquim Waite', 14810, '512351843', '11 Waltham Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rufus Sandler', 14819, '512351858', '3 Robbie Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kevn McIntyre', 14828, '512351873', '59 Hayes Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Gladys Carlyle', 14837, '512351888', '54 Roberts Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Elle Detmer', 14846, '512351903', '41 Paymer Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Domingo Palmer', 14855, '512351918', '91 Vivica Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Dave Santana', 14864, '512351933', '76 Hoskins Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rick Lane', 14873, '512351948', '918 Kerava Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Gabriel Robinson', 14882, '512351963', '40 Haysbert Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Allan Fender', 14891, '512351978', '50 Cate Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Pam Ticotin', 14900, '512351993', '53 Wehrheim Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Keanu Butler', 14909, '512352008', '41 Burrows Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Holly Swank', 14918, '512352023', '99 Van Der Beek Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Cate Aaron', 14927, '512352038', '175 Ohita Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jeffery Coe', 14936, '512352053', '39 Meredith Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Sigourney Clark', 14945, '512352068', '686 Dillon Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jimmie Bacharach', 14954, '512352083', '7 Rudd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rebecca DiCaprio', 14963, '512352098', '76 Luis Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Mili Paltrow', 14972, '512352113', '74 Oakland Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rupert Prinze', 14981, '512352128', '934 McGoohan Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Mili Suchet', 14990, '512352143', '89 Flower mound Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Gene Dawson', 14999, '512352158', '22nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Emerson Mandrell', 15008, '512352173', '12nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Stevie Smurfit', 15017, '512352188', '41st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Cornell Paquin', 15026, '512352203', '83 Claude');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Mena Stormare', 15035, '512352218', '60 Spall Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Alessandro Nicks', 15044, '512352233', '21 Arquette Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Mike Hewitt', 15053, '512352248', '87 Meg Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Allan Imperioli', 15062, '512352263', '49 Thelma Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lin Grier', 15071, '512352278', '37 Horace Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Famke Faithfull', 15080, '512352293', '285 Gary');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Shelby Loggia', 15089, '512352308', '752 Mickey Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rose Seagal', 15098, '512352323', '5 Ithaca Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Omar Winwood', 15107, '512352338', '46 Isaiah Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Aidan Flanery', 15116, '512352353', '61st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Wendy Richter', 15125, '512352368', '397 Berlin Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Sinead Leigh', 15134, '512352383', '267 Annandale Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Robert Waits', 15143, '512352398', '92 Erpe-Mere Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lydia Woodward', 15152, '512352413', '640 Temuera Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Mika Macy', 15161, '512352428', '16 Springville Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kyra Leto', 15170, '512352443', '834 Al Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Andrea Koyana', 15179, '512352458', '43rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Carla Jane', 15188, '512352473', '22 Stanford Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Cliff Marsden', 15197, '512352488', '950 Padova Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Bobby Guinness', 15206, '512352503', '14 Dom Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Roscoe Frakes', 15215, '512352518', '30 Ball Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ivan McNarland', 15224, '512352533', '39 Morales Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Emma Watson', 15233, '512352548', '5 Cle Elum Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Davis Vicious', 15242, '512352563', '81 Minnie Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Carole Pryce', 15251, '512352578', '98 Horb Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jamie Davies', 15260, '512352593', '21 Kinney Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Vonda Imbruglia', 15269, '512352608', '96 Petach-Tikva Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Vincent Gaynor', 15278, '512352623', '18 Jimmie');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Shelby Blaine', 15287, '512352638', '586 Staten Island Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Leonardo McClinton', 15296, '512352653', '3 Gryner Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Meryl Niven', 15305, '512352668', '60 Douala Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Hal Viterelli', 15314, '512352683', '318 Harper');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Hector Place', 15323, '512352698', '82 Dubai Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lindsey Hartnett', 15332, '512352713', '94 Shawnee Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Cevin Burstyn', 15341, '512352728', '26 Swank Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Giancarlo Paltrow', 15350, '512352743', '550 Emm Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Matt Witherspoon', 15359, '512352758', '76 Osment');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Josh Redford', 15368, '512352773', '73rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Forest Forrest', 15377, '512352788', '96 Harold Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jackson Hong', 15386, '512352803', '74 Lattimore Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Guy Paymer', 15395, '512352818', '76 Lublin Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Brenda Hurley', 15404, '512352833', '89 Salma Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Remy Sarandon', 15413, '512352848', '79 Glover Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rick Pfeiffer', 15422, '512352863', '38 Hawkins Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Blair Brolin', 15431, '512352878', '569 Flanagan Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Catherine Campbell', 15440, '512352893', '79 Kweller Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Donald Reid', 15449, '512352908', '62 Wiest Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Pelvic Carrack', 15458, '512352923', '21 Rodriguez');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Cameron Lange', 15467, '512352938', '37 McGregor Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jimmie Polito', 15476, '512352953', '27 O''fallon Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Dianne Lerner', 15485, '512352968', '180 Charles Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Denzel Finn', 15494, '512352983', '18 Cartlidge Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Hugo Cherry', 15503, '512352998', '99 Marley Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kirsten Neuwirth', 15512, '512353013', '16 Rucker Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Mark Pollak', 15521, '512353028', '10 Cross Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Trey Numan', 15530, '512353043', '54 Lena Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jackson Negbaur', 15539, '512353058', '41st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Nikka Caan', 15548, '512353073', '43rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Debra Tobolowsky', 15557, '512353088', '22nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Charles Emmerich', 15566, '512353103', '64 Koteas Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Clint Tanon', 15575, '512353118', '25 Stevie');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Billy Karyo', 15584, '512353133', '95 Campbell');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Loreena Frakes', 15593, '512353148', '932 Mt. Laurel Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Raul Hawn', 15602, '512353163', '58 Atkins Street');
commit;
prompt 500 records committed...
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Geena Roundtree', 15611, '512353178', '528 Bologna Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Crystal Rydell', 15620, '512353193', '23 Sossamon Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Praga Cruz', 15629, '512353208', '86 Laurie Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Elijah Byrd', 15638, '512353223', '73rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Wang O''Hara', 15647, '512353238', '98 Miranda');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rachael Weisz', 15656, '512353253', '31st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Matt Tankard', 15665, '512353268', '82nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Luke Steiger', 15674, '512353283', '35 Crystal Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Beverley Dalton', 15683, '512353298', '63 Gryner Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Giancarlo White', 15692, '512353313', '454 Cameron Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rhett MacDonald', 15701, '512353328', '721 Londrina Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Maceo urban', 15710, '512353343', '153 Ammons');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rhona Moore', 15719, '512353358', '728 Navarro');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Nile Stewart', 15728, '512353373', '33 Rodriguez Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Miles Gallant', 15737, '512353388', '38 Geggy Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Meredith Rickman', 15746, '512353403', '94 Shizuoka Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Nickel Nivola', 15755, '512353418', '34 Gallagher Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Juice Thewlis', 15764, '512353433', '91 Reeves Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Herbie Kleinenberg', 15773, '512353448', '263 Snow Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jesse Playboys', 15782, '512353463', '220 Oldwick Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Juliana Wilder', 15791, '512353478', '52 Webster Groves Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Chi Macht', 15800, '512353493', '65 Davidson Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rascal Keener', 15809, '512353508', '60 Cobham Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lisa Winger', 15818, '512353523', '82 Burlington Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Geraldine Kershaw', 15827, '512353538', '62nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Woody Bonneville', 15836, '512353553', '555 Larry');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Vivica Squier', 15845, '512353568', '976 Roundtree Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Danni Burstyn', 15854, '512353583', '23 Andrea Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Debbie Howard', 15863, '512353598', '43rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Morris Del Toro', 15872, '512353613', '45 Münster Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Nile Belles', 15881, '512353628', '88 Amherst Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Gene Dzundza', 15890, '512353643', '79 Osbourne Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Zooey Connery', 15899, '512353658', '13 Alda Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Larry Tucci', 15908, '512353673', '57 Cohn Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ryan Sepulveda', 15917, '512353688', '126 Askew Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Sigourney Winger', 15926, '512353703', '20 Kershaw Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ricky Green', 15935, '512353718', '48 Kirkwood Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jonny Lee Macht', 15944, '512353733', '91 Milford Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ashley Chan', 15953, '512353748', '13rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rosario Mazzello', 15962, '512353763', '5 Angie Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Gary McClinton', 15971, '512353778', '34 Busey Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Shawn Coltrane', 15980, '512353793', '87 Kirshner Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Marc Taylor', 15989, '512353808', '575 Bean Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jason McGovern', 15998, '512353823', '49 Elisabeth Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lynette Chilton', 16007, '512353838', '917 Ulm Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rascal Ledger', 16016, '512353853', '48 Frost Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Laura Eldard', 16025, '512353868', '18 Lea Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ritchie Davison', 16034, '512353883', '97 Mira Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Peabo Colon', 16043, '512353898', '32 McClinton Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Suzi Channing', 16052, '512353913', '26 Steve Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Shirley Schneider', 16061, '512353928', '17 Adkins Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Owen Belle', 16070, '512353943', '96 Torres Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Marty Wills', 16079, '512353958', '55 Vaduz Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Sam McCain', 16088, '512353973', '77 Grant Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rory Galecki', 16097, '512353988', '28 Blanchett Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Kate Williams', 16106, '512354003', '32 Farrell Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Chet McFerrin', 16115, '512354018', '68 Brothers Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Spencer Laurie', 16124, '512354033', '17 Bratt Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Gaby Jonze', 16133, '512354048', '98 Christina Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Graham Northam', 16142, '512354063', '478 Denzel Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Terence Khan', 16151, '512354078', '236 Perez Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Bridget Murdock', 16160, '512354093', '93 Richards Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jane Hynde', 16169, '512354108', '699 Danny Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Timothy Johansen', 16178, '512354123', '52 Cesar Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Chloe Clooney', 16187, '512354138', '53rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Tara Domino', 16196, '512354153', '431 Hall Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Gilbert Perry', 16205, '512354168', '81 Gallagher Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Grant Detmer', 16214, '512354183', '96 Shalhoub Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rob Danes', 16223, '512354198', '31 Forest Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Aida Salt', 16232, '512354213', '49 Wichita Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ron Armstrong', 16241, '512354228', '12 Keen Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Tramaine Kennedy', 16250, '512354243', '38 Gates Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Mili Beckinsale', 16259, '512354258', '84 Shepherd Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Chet Connery', 16268, '512354273', '99 Eastwood Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Joanna Assante', 16277, '512354288', '49 Bern Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jack Landau', 16286, '512354303', '62 Mary Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Hugo Whitford', 16295, '512354318', '433 Neil Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Terry Lauper', 16304, '512354333', '65 Gallant Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jonny Lee Hunt', 16313, '512354348', '24 Prinze Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Al Pigott-Smith', 16322, '512354363', '74 Kris Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Pierce Glover', 16331, '512354378', '57 Caine Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ralph McCracken', 16340, '512354393', '100 Farina Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jonny Rossellini', 16349, '512354408', '73rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Russell Reubens', 16358, '512354423', '69 Houston Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Emmylou Favreau', 16367, '512354438', '61 McLean Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Freddy Crudup', 16376, '512354453', '35 Caguas Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Mili Duchovny', 16385, '512354468', '505 Sorvino Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Buffy De Niro', 16394, '512354483', '47 Tokyo Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lari Jenkins', 16403, '512354498', '805 Stanley Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rick Costello', 16412, '512354513', '87 Sander Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Adam Dalton', 16421, '512354528', '64 Krabbe');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Julia Cherry', 16430, '512354543', '87 Zooey Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Harvey Satriani', 16439, '512354558', '51st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jackson Sawa', 16448, '512354573', '919 Janssen');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Shirley Masur', 16457, '512354588', '29 Hercules Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Geraldine Rourke', 16466, '512354603', '82nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Quentin Scorsese', 16475, '512354618', '37 Morse Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Gwyneth Hershey', 16484, '512354633', '38 Pacific Grove Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Gordon Morrison', 16493, '512354648', '87 Stuermer Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Cheryl Kirshner', 16502, '512354663', '93rd Street');
commit;
prompt 600 records committed...
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Embeth Knight', 16511, '512354678', '89 Paymer Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Nikka Fogerty', 16520, '512354693', '1 New Haven Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Michael Freeman', 16529, '512354708', '69 Rebecca Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Buffy Price', 16538, '512354723', '23 King Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Emma Diddley', 16547, '512354738', '50 Dench Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Bill Vincent', 16556, '512354753', '31 Velizy Villacoublay Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ming-Na Bonham', 16565, '512354768', '53rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Delroy Wright', 16574, '512354783', '814 Chapman Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Lin Heche', 16583, '512354798', '56 Postlethwaite Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Stephanie Unger', 16592, '512354813', '49 Cromwell Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Shannon Conners', 16601, '512354828', '24 Marley Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Nik Field', 16610, '512354843', '60 Hayes Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Alessandro Affleck', 16619, '512354858', '16 Eliza Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Azucar Domino', 16628, '512354873', '71 Hauser Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Graham Berenger', 16637, '512354888', '93 Salisbury Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jean-Claude Lemmon', 16646, '512354903', '50 Sawa Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Holly Marsden', 16655, '512354918', '61 Yogyakarta Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('LeVar Hughes', 16664, '512354933', '71st Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Geoff Costello', 16673, '512354948', '993 Norm');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Charlie Redford', 16682, '512354963', '21 Coleman Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Christian Pastore', 16691, '512354978', '82nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Philip Dreyfuss', 16700, '512354993', '93rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Davis Conners', 16709, '512355008', '4 Plummer Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Freddie Morrison', 16718, '512355023', '84 Paula Ave');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Alice Purefoy', 16727, '512355038', '212 Shelton Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Miriam Duvall', 16736, '512355053', '974 Manaus Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Wally Heron', 16745, '512355068', '87 Fiorentino Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Jeroen Hingle', 16754, '512355083', '40 Frampton Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Vin Chambers', 16763, '512355098', '22 Arturo');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Beth Cattrall', 16772, '512355113', '72 Vaughn');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Xander Sheen', 16781, '512355128', '30 Hines Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Johnnie Kelly', 16790, '512355143', '100 Stiller Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Keith Lauper', 16799, '512355158', '32nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ronnie Crewson', 16808, '512355173', '867 Mariano Comense Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Clint Wilkinson', 16817, '512355188', '9 Norderstedt Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Giovanni Rockwell', 16826, '512355203', '93rd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Ossie Price', 16835, '512355218', '32nd Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Radney Kahn', 16844, '512355233', '374 Pacino Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Elijah Dean', 16853, '512355248', '73 Clayton');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Cary Kidman', 16862, '512355263', '93 Sapulpa Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Barbara Wolf', 16871, '512355278', '21 Stiers Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Mindy Ticotin', 16880, '512355293', '71 Soul Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Peter Cetera', 16889, '512355308', '67 Spader Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Cevin Gallagher', 16898, '512355323', '100 Moscow Road');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Suzi Puckett', 16907, '512355338', '70 Harriet Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Delroy Johansson', 16916, '512355353', '51 Kattan Street');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Arnold Bragg', 16925, '512355368', '39 Dench Drive');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Geggy Winslet', 16934, '512355383', '124 Haslam');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Chi Willis', 16943, '512355398', '599 Essex Blvd');
insert into SELLERS (seller_name, seller_id, phone, address)
values ('Rhett Pepper', 16952, '512355413', '42 Santa Cruz Drive');
commit;
prompt 650 records loaded
prompt Loading SELL...
insert into SELL (seller_id, product_id)
values (11111, 152);
insert into SELL (seller_id, product_id)
values (11111, 337);
insert into SELL (seller_id, product_id)
values (11111, 477);
insert into SELL (seller_id, product_id)
values (11120, 244);
insert into SELL (seller_id, product_id)
values (11138, 37);
insert into SELL (seller_id, product_id)
values (11138, 205);
insert into SELL (seller_id, product_id)
values (11138, 266);
insert into SELL (seller_id, product_id)
values (11138, 359);
insert into SELL (seller_id, product_id)
values (11147, 176);
insert into SELL (seller_id, product_id)
values (11156, 132);
insert into SELL (seller_id, product_id)
values (11156, 282);
insert into SELL (seller_id, product_id)
values (11165, 8);
insert into SELL (seller_id, product_id)
values (11165, 158);
insert into SELL (seller_id, product_id)
values (11174, 373);
insert into SELL (seller_id, product_id)
values (11183, 200);
insert into SELL (seller_id, product_id)
values (11183, 369);
insert into SELL (seller_id, product_id)
values (11183, 437);
insert into SELL (seller_id, product_id)
values (11192, 32);
insert into SELL (seller_id, product_id)
values (11192, 406);
insert into SELL (seller_id, product_id)
values (11228, 195);
insert into SELL (seller_id, product_id)
values (11228, 371);
insert into SELL (seller_id, product_id)
values (11237, 193);
insert into SELL (seller_id, product_id)
values (11237, 206);
insert into SELL (seller_id, product_id)
values (11237, 420);
insert into SELL (seller_id, product_id)
values (11291, 401);
insert into SELL (seller_id, product_id)
values (11291, 494);
insert into SELL (seller_id, product_id)
values (11318, 44);
insert into SELL (seller_id, product_id)
values (11318, 132);
insert into SELL (seller_id, product_id)
values (11318, 448);
insert into SELL (seller_id, product_id)
values (11327, 231);
insert into SELL (seller_id, product_id)
values (11336, 210);
insert into SELL (seller_id, product_id)
values (11345, 408);
insert into SELL (seller_id, product_id)
values (11363, 33);
insert into SELL (seller_id, product_id)
values (11363, 316);
insert into SELL (seller_id, product_id)
values (11372, 57);
insert into SELL (seller_id, product_id)
values (11372, 468);
insert into SELL (seller_id, product_id)
values (11381, 134);
insert into SELL (seller_id, product_id)
values (11381, 296);
insert into SELL (seller_id, product_id)
values (11390, 153);
insert into SELL (seller_id, product_id)
values (11390, 266);
insert into SELL (seller_id, product_id)
values (11390, 381);
insert into SELL (seller_id, product_id)
values (11399, 125);
insert into SELL (seller_id, product_id)
values (11399, 197);
insert into SELL (seller_id, product_id)
values (11408, 186);
insert into SELL (seller_id, product_id)
values (11426, 133);
insert into SELL (seller_id, product_id)
values (11444, 293);
insert into SELL (seller_id, product_id)
values (11444, 311);
insert into SELL (seller_id, product_id)
values (11444, 487);
insert into SELL (seller_id, product_id)
values (11453, 457);
insert into SELL (seller_id, product_id)
values (11471, 489);
insert into SELL (seller_id, product_id)
values (11480, 168);
insert into SELL (seller_id, product_id)
values (11480, 401);
insert into SELL (seller_id, product_id)
values (11498, 64);
insert into SELL (seller_id, product_id)
values (11498, 83);
insert into SELL (seller_id, product_id)
values (11525, 293);
insert into SELL (seller_id, product_id)
values (11534, 129);
insert into SELL (seller_id, product_id)
values (11534, 136);
insert into SELL (seller_id, product_id)
values (11552, 198);
insert into SELL (seller_id, product_id)
values (11561, 60);
insert into SELL (seller_id, product_id)
values (11579, 332);
insert into SELL (seller_id, product_id)
values (11579, 370);
insert into SELL (seller_id, product_id)
values (11588, 16);
insert into SELL (seller_id, product_id)
values (11588, 316);
insert into SELL (seller_id, product_id)
values (11588, 438);
insert into SELL (seller_id, product_id)
values (11597, 63);
insert into SELL (seller_id, product_id)
values (11597, 150);
insert into SELL (seller_id, product_id)
values (11615, 265);
insert into SELL (seller_id, product_id)
values (11615, 271);
insert into SELL (seller_id, product_id)
values (11615, 355);
insert into SELL (seller_id, product_id)
values (11615, 397);
insert into SELL (seller_id, product_id)
values (11624, 274);
insert into SELL (seller_id, product_id)
values (11642, 43);
insert into SELL (seller_id, product_id)
values (11642, 374);
insert into SELL (seller_id, product_id)
values (11651, 140);
insert into SELL (seller_id, product_id)
values (11678, 445);
insert into SELL (seller_id, product_id)
values (11687, 158);
insert into SELL (seller_id, product_id)
values (11696, 96);
insert into SELL (seller_id, product_id)
values (11696, 147);
insert into SELL (seller_id, product_id)
values (11696, 391);
insert into SELL (seller_id, product_id)
values (11705, 414);
insert into SELL (seller_id, product_id)
values (11705, 482);
insert into SELL (seller_id, product_id)
values (11705, 484);
insert into SELL (seller_id, product_id)
values (11714, 248);
insert into SELL (seller_id, product_id)
values (11714, 261);
insert into SELL (seller_id, product_id)
values (11732, 62);
insert into SELL (seller_id, product_id)
values (11732, 210);
insert into SELL (seller_id, product_id)
values (11741, 45);
insert into SELL (seller_id, product_id)
values (11750, 69);
insert into SELL (seller_id, product_id)
values (11750, 119);
insert into SELL (seller_id, product_id)
values (11750, 393);
insert into SELL (seller_id, product_id)
values (11777, 10);
insert into SELL (seller_id, product_id)
values (11786, 10);
insert into SELL (seller_id, product_id)
values (11786, 296);
insert into SELL (seller_id, product_id)
values (11786, 389);
insert into SELL (seller_id, product_id)
values (11786, 405);
insert into SELL (seller_id, product_id)
values (11786, 458);
insert into SELL (seller_id, product_id)
values (11795, 29);
insert into SELL (seller_id, product_id)
values (11804, 17);
insert into SELL (seller_id, product_id)
values (11804, 31);
insert into SELL (seller_id, product_id)
values (11804, 50);
commit;
prompt 100 records committed...
insert into SELL (seller_id, product_id)
values (11804, 257);
insert into SELL (seller_id, product_id)
values (11813, 152);
insert into SELL (seller_id, product_id)
values (11822, 94);
insert into SELL (seller_id, product_id)
values (11822, 298);
insert into SELL (seller_id, product_id)
values (11822, 349);
insert into SELL (seller_id, product_id)
values (11831, 27);
insert into SELL (seller_id, product_id)
values (11831, 180);
insert into SELL (seller_id, product_id)
values (11831, 404);
insert into SELL (seller_id, product_id)
values (11849, 42);
insert into SELL (seller_id, product_id)
values (11858, 217);
insert into SELL (seller_id, product_id)
values (11858, 388);
insert into SELL (seller_id, product_id)
values (11867, 145);
insert into SELL (seller_id, product_id)
values (11876, 386);
insert into SELL (seller_id, product_id)
values (11885, 14);
insert into SELL (seller_id, product_id)
values (11885, 66);
insert into SELL (seller_id, product_id)
values (11885, 176);
insert into SELL (seller_id, product_id)
values (11885, 383);
insert into SELL (seller_id, product_id)
values (11930, 212);
insert into SELL (seller_id, product_id)
values (11930, 288);
insert into SELL (seller_id, product_id)
values (11939, 194);
insert into SELL (seller_id, product_id)
values (11948, 98);
insert into SELL (seller_id, product_id)
values (11975, 101);
insert into SELL (seller_id, product_id)
values (11975, 240);
insert into SELL (seller_id, product_id)
values (11993, 370);
insert into SELL (seller_id, product_id)
values (12002, 456);
insert into SELL (seller_id, product_id)
values (12011, 392);
insert into SELL (seller_id, product_id)
values (12020, 170);
insert into SELL (seller_id, product_id)
values (12029, 328);
insert into SELL (seller_id, product_id)
values (12038, 286);
insert into SELL (seller_id, product_id)
values (12038, 343);
insert into SELL (seller_id, product_id)
values (12038, 344);
insert into SELL (seller_id, product_id)
values (12047, 18);
insert into SELL (seller_id, product_id)
values (12047, 179);
insert into SELL (seller_id, product_id)
values (12047, 181);
insert into SELL (seller_id, product_id)
values (12056, 159);
insert into SELL (seller_id, product_id)
values (12056, 224);
insert into SELL (seller_id, product_id)
values (12056, 412);
insert into SELL (seller_id, product_id)
values (12065, 192);
insert into SELL (seller_id, product_id)
values (12065, 356);
insert into SELL (seller_id, product_id)
values (12074, 191);
insert into SELL (seller_id, product_id)
values (12083, 40);
insert into SELL (seller_id, product_id)
values (12092, 13);
insert into SELL (seller_id, product_id)
values (12092, 247);
insert into SELL (seller_id, product_id)
values (12110, 181);
insert into SELL (seller_id, product_id)
values (12119, 316);
insert into SELL (seller_id, product_id)
values (12137, 163);
insert into SELL (seller_id, product_id)
values (12137, 311);
insert into SELL (seller_id, product_id)
values (12146, 186);
insert into SELL (seller_id, product_id)
values (12146, 278);
insert into SELL (seller_id, product_id)
values (12155, 80);
insert into SELL (seller_id, product_id)
values (12155, 150);
insert into SELL (seller_id, product_id)
values (12155, 249);
insert into SELL (seller_id, product_id)
values (12164, 87);
insert into SELL (seller_id, product_id)
values (12164, 218);
insert into SELL (seller_id, product_id)
values (12164, 393);
insert into SELL (seller_id, product_id)
values (12191, 227);
insert into SELL (seller_id, product_id)
values (12200, 170);
insert into SELL (seller_id, product_id)
values (12218, 436);
insert into SELL (seller_id, product_id)
values (12236, 353);
insert into SELL (seller_id, product_id)
values (12236, 420);
insert into SELL (seller_id, product_id)
values (12254, 50);
insert into SELL (seller_id, product_id)
values (12254, 363);
insert into SELL (seller_id, product_id)
values (12263, 105);
insert into SELL (seller_id, product_id)
values (12263, 268);
insert into SELL (seller_id, product_id)
values (12272, 34);
insert into SELL (seller_id, product_id)
values (12281, 94);
insert into SELL (seller_id, product_id)
values (12299, 265);
insert into SELL (seller_id, product_id)
values (12308, 130);
insert into SELL (seller_id, product_id)
values (12317, 36);
insert into SELL (seller_id, product_id)
values (12317, 99);
insert into SELL (seller_id, product_id)
values (12317, 344);
insert into SELL (seller_id, product_id)
values (12326, 65);
insert into SELL (seller_id, product_id)
values (12353, 50);
insert into SELL (seller_id, product_id)
values (12362, 80);
insert into SELL (seller_id, product_id)
values (12362, 370);
insert into SELL (seller_id, product_id)
values (12371, 391);
insert into SELL (seller_id, product_id)
values (12380, 476);
insert into SELL (seller_id, product_id)
values (12398, 84);
insert into SELL (seller_id, product_id)
values (12398, 332);
insert into SELL (seller_id, product_id)
values (12398, 412);
insert into SELL (seller_id, product_id)
values (12407, 128);
insert into SELL (seller_id, product_id)
values (12407, 251);
insert into SELL (seller_id, product_id)
values (12407, 423);
insert into SELL (seller_id, product_id)
values (12407, 479);
insert into SELL (seller_id, product_id)
values (12416, 215);
insert into SELL (seller_id, product_id)
values (12425, 146);
insert into SELL (seller_id, product_id)
values (12425, 323);
insert into SELL (seller_id, product_id)
values (12425, 337);
insert into SELL (seller_id, product_id)
values (12425, 387);
insert into SELL (seller_id, product_id)
values (12443, 3);
insert into SELL (seller_id, product_id)
values (12443, 466);
insert into SELL (seller_id, product_id)
values (12452, 137);
insert into SELL (seller_id, product_id)
values (12452, 176);
insert into SELL (seller_id, product_id)
values (12452, 185);
insert into SELL (seller_id, product_id)
values (12452, 203);
insert into SELL (seller_id, product_id)
values (12452, 319);
insert into SELL (seller_id, product_id)
values (12452, 365);
insert into SELL (seller_id, product_id)
values (12461, 360);
insert into SELL (seller_id, product_id)
values (12470, 162);
insert into SELL (seller_id, product_id)
values (12470, 214);
commit;
prompt 200 records committed...
insert into SELL (seller_id, product_id)
values (12479, 388);
insert into SELL (seller_id, product_id)
values (12488, 219);
insert into SELL (seller_id, product_id)
values (12506, 483);
insert into SELL (seller_id, product_id)
values (12515, 7);
insert into SELL (seller_id, product_id)
values (12515, 150);
insert into SELL (seller_id, product_id)
values (12515, 451);
insert into SELL (seller_id, product_id)
values (12542, 34);
insert into SELL (seller_id, product_id)
values (12542, 158);
insert into SELL (seller_id, product_id)
values (12551, 94);
insert into SELL (seller_id, product_id)
values (12551, 252);
insert into SELL (seller_id, product_id)
values (12551, 290);
insert into SELL (seller_id, product_id)
values (12551, 397);
insert into SELL (seller_id, product_id)
values (12569, 233);
insert into SELL (seller_id, product_id)
values (12578, 90);
insert into SELL (seller_id, product_id)
values (12578, 426);
insert into SELL (seller_id, product_id)
values (12605, 62);
insert into SELL (seller_id, product_id)
values (12605, 146);
insert into SELL (seller_id, product_id)
values (12605, 324);
insert into SELL (seller_id, product_id)
values (12623, 360);
insert into SELL (seller_id, product_id)
values (12632, 10);
insert into SELL (seller_id, product_id)
values (12632, 207);
insert into SELL (seller_id, product_id)
values (12632, 482);
insert into SELL (seller_id, product_id)
values (12650, 83);
insert into SELL (seller_id, product_id)
values (12650, 346);
insert into SELL (seller_id, product_id)
values (12650, 481);
insert into SELL (seller_id, product_id)
values (12668, 208);
insert into SELL (seller_id, product_id)
values (12677, 151);
insert into SELL (seller_id, product_id)
values (12677, 284);
insert into SELL (seller_id, product_id)
values (12686, 217);
insert into SELL (seller_id, product_id)
values (12686, 275);
insert into SELL (seller_id, product_id)
values (12695, 127);
insert into SELL (seller_id, product_id)
values (12704, 78);
insert into SELL (seller_id, product_id)
values (12704, 307);
insert into SELL (seller_id, product_id)
values (12713, 4);
insert into SELL (seller_id, product_id)
values (12722, 105);
insert into SELL (seller_id, product_id)
values (12722, 237);
insert into SELL (seller_id, product_id)
values (12722, 345);
insert into SELL (seller_id, product_id)
values (12731, 29);
insert into SELL (seller_id, product_id)
values (12731, 219);
insert into SELL (seller_id, product_id)
values (12740, 222);
insert into SELL (seller_id, product_id)
values (12740, 346);
insert into SELL (seller_id, product_id)
values (12740, 384);
insert into SELL (seller_id, product_id)
values (12758, 115);
insert into SELL (seller_id, product_id)
values (12776, 376);
insert into SELL (seller_id, product_id)
values (12776, 434);
insert into SELL (seller_id, product_id)
values (12785, 149);
insert into SELL (seller_id, product_id)
values (12785, 460);
insert into SELL (seller_id, product_id)
values (12794, 205);
insert into SELL (seller_id, product_id)
values (12794, 283);
insert into SELL (seller_id, product_id)
values (12812, 228);
insert into SELL (seller_id, product_id)
values (12821, 297);
insert into SELL (seller_id, product_id)
values (12848, 434);
insert into SELL (seller_id, product_id)
values (12848, 477);
insert into SELL (seller_id, product_id)
values (12857, 84);
insert into SELL (seller_id, product_id)
values (12857, 106);
insert into SELL (seller_id, product_id)
values (12857, 138);
insert into SELL (seller_id, product_id)
values (12857, 345);
insert into SELL (seller_id, product_id)
values (12875, 463);
insert into SELL (seller_id, product_id)
values (12884, 175);
insert into SELL (seller_id, product_id)
values (12893, 67);
insert into SELL (seller_id, product_id)
values (12911, 362);
insert into SELL (seller_id, product_id)
values (12920, 108);
insert into SELL (seller_id, product_id)
values (12938, 80);
insert into SELL (seller_id, product_id)
values (12938, 428);
insert into SELL (seller_id, product_id)
values (12956, 212);
insert into SELL (seller_id, product_id)
values (12965, 46);
insert into SELL (seller_id, product_id)
values (12965, 250);
insert into SELL (seller_id, product_id)
values (12965, 464);
insert into SELL (seller_id, product_id)
values (12974, 289);
insert into SELL (seller_id, product_id)
values (12974, 329);
insert into SELL (seller_id, product_id)
values (12992, 31);
insert into SELL (seller_id, product_id)
values (12992, 243);
insert into SELL (seller_id, product_id)
values (13010, 21);
insert into SELL (seller_id, product_id)
values (13010, 267);
insert into SELL (seller_id, product_id)
values (13010, 311);
insert into SELL (seller_id, product_id)
values (13019, 415);
insert into SELL (seller_id, product_id)
values (13028, 244);
insert into SELL (seller_id, product_id)
values (13046, 154);
insert into SELL (seller_id, product_id)
values (13046, 184);
insert into SELL (seller_id, product_id)
values (13046, 187);
insert into SELL (seller_id, product_id)
values (13046, 409);
insert into SELL (seller_id, product_id)
values (13046, 427);
insert into SELL (seller_id, product_id)
values (13064, 267);
insert into SELL (seller_id, product_id)
values (13064, 404);
insert into SELL (seller_id, product_id)
values (13073, 300);
insert into SELL (seller_id, product_id)
values (13073, 317);
insert into SELL (seller_id, product_id)
values (13091, 147);
insert into SELL (seller_id, product_id)
values (13109, 257);
insert into SELL (seller_id, product_id)
values (13127, 119);
insert into SELL (seller_id, product_id)
values (13127, 265);
insert into SELL (seller_id, product_id)
values (13127, 403);
insert into SELL (seller_id, product_id)
values (13136, 459);
insert into SELL (seller_id, product_id)
values (13145, 286);
insert into SELL (seller_id, product_id)
values (13154, 251);
insert into SELL (seller_id, product_id)
values (13172, 23);
insert into SELL (seller_id, product_id)
values (13199, 29);
insert into SELL (seller_id, product_id)
values (13199, 285);
insert into SELL (seller_id, product_id)
values (13217, 130);
insert into SELL (seller_id, product_id)
values (13217, 262);
insert into SELL (seller_id, product_id)
values (13226, 419);
commit;
prompt 300 records committed...
insert into SELL (seller_id, product_id)
values (13235, 379);
insert into SELL (seller_id, product_id)
values (13244, 68);
insert into SELL (seller_id, product_id)
values (13244, 230);
insert into SELL (seller_id, product_id)
values (13253, 146);
insert into SELL (seller_id, product_id)
values (13262, 35);
insert into SELL (seller_id, product_id)
values (13262, 212);
insert into SELL (seller_id, product_id)
values (13280, 158);
insert into SELL (seller_id, product_id)
values (13298, 32);
insert into SELL (seller_id, product_id)
values (13298, 381);
insert into SELL (seller_id, product_id)
values (13316, 278);
insert into SELL (seller_id, product_id)
values (13325, 214);
insert into SELL (seller_id, product_id)
values (13325, 411);
insert into SELL (seller_id, product_id)
values (13343, 22);
insert into SELL (seller_id, product_id)
values (13352, 221);
insert into SELL (seller_id, product_id)
values (13361, 149);
insert into SELL (seller_id, product_id)
values (13370, 92);
insert into SELL (seller_id, product_id)
values (13370, 106);
insert into SELL (seller_id, product_id)
values (13379, 46);
insert into SELL (seller_id, product_id)
values (13379, 203);
insert into SELL (seller_id, product_id)
values (13379, 320);
insert into SELL (seller_id, product_id)
values (13397, 37);
insert into SELL (seller_id, product_id)
values (13397, 333);
insert into SELL (seller_id, product_id)
values (13406, 425);
insert into SELL (seller_id, product_id)
values (13415, 25);
insert into SELL (seller_id, product_id)
values (13415, 309);
insert into SELL (seller_id, product_id)
values (13415, 317);
insert into SELL (seller_id, product_id)
values (13433, 61);
insert into SELL (seller_id, product_id)
values (13433, 174);
insert into SELL (seller_id, product_id)
values (13460, 401);
insert into SELL (seller_id, product_id)
values (13469, 116);
insert into SELL (seller_id, product_id)
values (13469, 404);
insert into SELL (seller_id, product_id)
values (13478, 53);
insert into SELL (seller_id, product_id)
values (13478, 193);
insert into SELL (seller_id, product_id)
values (13478, 352);
insert into SELL (seller_id, product_id)
values (13478, 441);
insert into SELL (seller_id, product_id)
values (13487, 258);
insert into SELL (seller_id, product_id)
values (13487, 341);
insert into SELL (seller_id, product_id)
values (13496, 266);
insert into SELL (seller_id, product_id)
values (13505, 98);
insert into SELL (seller_id, product_id)
values (13505, 453);
insert into SELL (seller_id, product_id)
values (13523, 106);
insert into SELL (seller_id, product_id)
values (13532, 28);
insert into SELL (seller_id, product_id)
values (13541, 286);
insert into SELL (seller_id, product_id)
values (13559, 343);
insert into SELL (seller_id, product_id)
values (13568, 174);
insert into SELL (seller_id, product_id)
values (13568, 254);
insert into SELL (seller_id, product_id)
values (13595, 137);
insert into SELL (seller_id, product_id)
values (13595, 183);
insert into SELL (seller_id, product_id)
values (13595, 461);
insert into SELL (seller_id, product_id)
values (13604, 63);
insert into SELL (seller_id, product_id)
values (13604, 283);
insert into SELL (seller_id, product_id)
values (13613, 79);
insert into SELL (seller_id, product_id)
values (13622, 108);
insert into SELL (seller_id, product_id)
values (13622, 385);
insert into SELL (seller_id, product_id)
values (13631, 151);
insert into SELL (seller_id, product_id)
values (13640, 66);
insert into SELL (seller_id, product_id)
values (13640, 152);
insert into SELL (seller_id, product_id)
values (13640, 479);
insert into SELL (seller_id, product_id)
values (13649, 104);
insert into SELL (seller_id, product_id)
values (13649, 147);
insert into SELL (seller_id, product_id)
values (13658, 82);
insert into SELL (seller_id, product_id)
values (13658, 201);
insert into SELL (seller_id, product_id)
values (13667, 200);
insert into SELL (seller_id, product_id)
values (13676, 23);
insert into SELL (seller_id, product_id)
values (13676, 464);
insert into SELL (seller_id, product_id)
values (13712, 93);
insert into SELL (seller_id, product_id)
values (13712, 129);
insert into SELL (seller_id, product_id)
values (13730, 417);
insert into SELL (seller_id, product_id)
values (13739, 267);
insert into SELL (seller_id, product_id)
values (13748, 84);
insert into SELL (seller_id, product_id)
values (13757, 197);
insert into SELL (seller_id, product_id)
values (13766, 292);
insert into SELL (seller_id, product_id)
values (13775, 134);
insert into SELL (seller_id, product_id)
values (13775, 367);
insert into SELL (seller_id, product_id)
values (13784, 52);
insert into SELL (seller_id, product_id)
values (13784, 66);
insert into SELL (seller_id, product_id)
values (13793, 259);
insert into SELL (seller_id, product_id)
values (13802, 301);
insert into SELL (seller_id, product_id)
values (13811, 221);
insert into SELL (seller_id, product_id)
values (13811, 353);
insert into SELL (seller_id, product_id)
values (13820, 85);
insert into SELL (seller_id, product_id)
values (13829, 48);
insert into SELL (seller_id, product_id)
values (13829, 266);
insert into SELL (seller_id, product_id)
values (13838, 124);
insert into SELL (seller_id, product_id)
values (13847, 38);
insert into SELL (seller_id, product_id)
values (13847, 45);
insert into SELL (seller_id, product_id)
values (13847, 246);
insert into SELL (seller_id, product_id)
values (13847, 386);
insert into SELL (seller_id, product_id)
values (13856, 95);
insert into SELL (seller_id, product_id)
values (13856, 448);
insert into SELL (seller_id, product_id)
values (13865, 63);
insert into SELL (seller_id, product_id)
values (13874, 69);
insert into SELL (seller_id, product_id)
values (13874, 253);
insert into SELL (seller_id, product_id)
values (13874, 462);
insert into SELL (seller_id, product_id)
values (13892, 32);
insert into SELL (seller_id, product_id)
values (13901, 46);
insert into SELL (seller_id, product_id)
values (13901, 64);
insert into SELL (seller_id, product_id)
values (13901, 268);
insert into SELL (seller_id, product_id)
values (13910, 149);
insert into SELL (seller_id, product_id)
values (13910, 355);
commit;
prompt 400 records committed...
insert into SELL (seller_id, product_id)
values (13928, 80);
insert into SELL (seller_id, product_id)
values (13928, 169);
insert into SELL (seller_id, product_id)
values (13946, 369);
insert into SELL (seller_id, product_id)
values (13946, 403);
insert into SELL (seller_id, product_id)
values (13973, 307);
insert into SELL (seller_id, product_id)
values (13973, 339);
insert into SELL (seller_id, product_id)
values (13982, 273);
insert into SELL (seller_id, product_id)
values (13991, 84);
insert into SELL (seller_id, product_id)
values (14009, 454);
insert into SELL (seller_id, product_id)
values (14018, 138);
insert into SELL (seller_id, product_id)
values (14018, 452);
insert into SELL (seller_id, product_id)
values (14045, 388);
insert into SELL (seller_id, product_id)
values (14054, 40);
insert into SELL (seller_id, product_id)
values (14054, 101);
insert into SELL (seller_id, product_id)
values (14072, 208);
insert into SELL (seller_id, product_id)
values (14081, 375);
insert into SELL (seller_id, product_id)
values (14099, 60);
insert into SELL (seller_id, product_id)
values (14099, 322);
insert into SELL (seller_id, product_id)
values (14117, 310);
insert into SELL (seller_id, product_id)
values (14126, 385);
insert into SELL (seller_id, product_id)
values (14153, 281);
insert into SELL (seller_id, product_id)
values (14171, 368);
insert into SELL (seller_id, product_id)
values (14171, 374);
insert into SELL (seller_id, product_id)
values (14180, 177);
insert into SELL (seller_id, product_id)
values (14189, 270);
insert into SELL (seller_id, product_id)
values (14198, 184);
insert into SELL (seller_id, product_id)
values (14207, 299);
insert into SELL (seller_id, product_id)
values (14207, 468);
insert into SELL (seller_id, product_id)
values (14216, 16);
insert into SELL (seller_id, product_id)
values (14225, 194);
insert into SELL (seller_id, product_id)
values (14225, 437);
insert into SELL (seller_id, product_id)
values (14234, 71);
insert into SELL (seller_id, product_id)
values (14252, 90);
insert into SELL (seller_id, product_id)
values (14252, 99);
insert into SELL (seller_id, product_id)
values (14261, 279);
insert into SELL (seller_id, product_id)
values (14279, 272);
insert into SELL (seller_id, product_id)
values (14288, 79);
insert into SELL (seller_id, product_id)
values (14288, 181);
insert into SELL (seller_id, product_id)
values (14288, 380);
insert into SELL (seller_id, product_id)
values (14297, 140);
insert into SELL (seller_id, product_id)
values (14297, 328);
insert into SELL (seller_id, product_id)
values (14297, 455);
insert into SELL (seller_id, product_id)
values (14315, 217);
insert into SELL (seller_id, product_id)
values (14351, 14);
insert into SELL (seller_id, product_id)
values (14351, 15);
insert into SELL (seller_id, product_id)
values (14351, 234);
insert into SELL (seller_id, product_id)
values (14360, 231);
insert into SELL (seller_id, product_id)
values (14369, 283);
insert into SELL (seller_id, product_id)
values (14369, 442);
insert into SELL (seller_id, product_id)
values (14387, 416);
insert into SELL (seller_id, product_id)
values (14396, 352);
insert into SELL (seller_id, product_id)
values (14405, 259);
insert into SELL (seller_id, product_id)
values (14414, 181);
insert into SELL (seller_id, product_id)
values (14423, 72);
insert into SELL (seller_id, product_id)
values (14423, 407);
insert into SELL (seller_id, product_id)
values (14432, 69);
insert into SELL (seller_id, product_id)
values (14432, 230);
insert into SELL (seller_id, product_id)
values (14441, 79);
insert into SELL (seller_id, product_id)
values (14441, 388);
insert into SELL (seller_id, product_id)
values (14450, 57);
insert into SELL (seller_id, product_id)
values (14459, 476);
insert into SELL (seller_id, product_id)
values (14477, 301);
insert into SELL (seller_id, product_id)
values (14486, 311);
insert into SELL (seller_id, product_id)
values (14504, 80);
insert into SELL (seller_id, product_id)
values (14504, 104);
insert into SELL (seller_id, product_id)
values (14504, 332);
insert into SELL (seller_id, product_id)
values (14504, 344);
insert into SELL (seller_id, product_id)
values (14513, 168);
insert into SELL (seller_id, product_id)
values (14513, 395);
insert into SELL (seller_id, product_id)
values (14522, 93);
insert into SELL (seller_id, product_id)
values (14531, 30);
insert into SELL (seller_id, product_id)
values (14540, 96);
insert into SELL (seller_id, product_id)
values (14540, 402);
insert into SELL (seller_id, product_id)
values (14549, 93);
insert into SELL (seller_id, product_id)
values (14549, 418);
insert into SELL (seller_id, product_id)
values (14558, 216);
insert into SELL (seller_id, product_id)
values (14558, 452);
insert into SELL (seller_id, product_id)
values (14567, 96);
insert into SELL (seller_id, product_id)
values (14567, 336);
insert into SELL (seller_id, product_id)
values (14567, 402);
insert into SELL (seller_id, product_id)
values (14576, 42);
insert into SELL (seller_id, product_id)
values (14576, 73);
insert into SELL (seller_id, product_id)
values (14594, 313);
insert into SELL (seller_id, product_id)
values (14603, 288);
insert into SELL (seller_id, product_id)
values (14603, 423);
insert into SELL (seller_id, product_id)
values (14612, 108);
insert into SELL (seller_id, product_id)
values (14612, 469);
insert into SELL (seller_id, product_id)
values (14621, 1);
insert into SELL (seller_id, product_id)
values (14621, 108);
insert into SELL (seller_id, product_id)
values (14621, 412);
insert into SELL (seller_id, product_id)
values (14621, 480);
insert into SELL (seller_id, product_id)
values (14630, 134);
insert into SELL (seller_id, product_id)
values (14648, 121);
insert into SELL (seller_id, product_id)
values (14648, 171);
insert into SELL (seller_id, product_id)
values (14648, 441);
insert into SELL (seller_id, product_id)
values (14657, 16);
insert into SELL (seller_id, product_id)
values (14666, 17);
insert into SELL (seller_id, product_id)
values (14666, 346);
insert into SELL (seller_id, product_id)
values (14675, 245);
insert into SELL (seller_id, product_id)
values (14693, 31);
commit;
prompt 500 records committed...
insert into SELL (seller_id, product_id)
values (14693, 208);
insert into SELL (seller_id, product_id)
values (14702, 34);
insert into SELL (seller_id, product_id)
values (14711, 494);
insert into SELL (seller_id, product_id)
values (14720, 455);
insert into SELL (seller_id, product_id)
values (14729, 366);
insert into SELL (seller_id, product_id)
values (14738, 221);
insert into SELL (seller_id, product_id)
values (14738, 436);
insert into SELL (seller_id, product_id)
values (14765, 55);
insert into SELL (seller_id, product_id)
values (14774, 177);
insert into SELL (seller_id, product_id)
values (14774, 216);
insert into SELL (seller_id, product_id)
values (14774, 491);
insert into SELL (seller_id, product_id)
values (14783, 162);
insert into SELL (seller_id, product_id)
values (14783, 205);
insert into SELL (seller_id, product_id)
values (14783, 364);
insert into SELL (seller_id, product_id)
values (14783, 375);
insert into SELL (seller_id, product_id)
values (14801, 157);
insert into SELL (seller_id, product_id)
values (14801, 174);
insert into SELL (seller_id, product_id)
values (14801, 280);
insert into SELL (seller_id, product_id)
values (14828, 359);
insert into SELL (seller_id, product_id)
values (14837, 87);
insert into SELL (seller_id, product_id)
values (14837, 303);
insert into SELL (seller_id, product_id)
values (14846, 296);
insert into SELL (seller_id, product_id)
values (14846, 323);
insert into SELL (seller_id, product_id)
values (14846, 353);
insert into SELL (seller_id, product_id)
values (14855, 114);
insert into SELL (seller_id, product_id)
values (14855, 274);
insert into SELL (seller_id, product_id)
values (14864, 69);
insert into SELL (seller_id, product_id)
values (14864, 95);
insert into SELL (seller_id, product_id)
values (14864, 150);
insert into SELL (seller_id, product_id)
values (14864, 315);
insert into SELL (seller_id, product_id)
values (14882, 312);
insert into SELL (seller_id, product_id)
values (14891, 467);
insert into SELL (seller_id, product_id)
values (14936, 413);
insert into SELL (seller_id, product_id)
values (14945, 280);
insert into SELL (seller_id, product_id)
values (14963, 277);
insert into SELL (seller_id, product_id)
values (14972, 94);
insert into SELL (seller_id, product_id)
values (14972, 295);
insert into SELL (seller_id, product_id)
values (14972, 487);
insert into SELL (seller_id, product_id)
values (14999, 378);
insert into SELL (seller_id, product_id)
values (15008, 431);
insert into SELL (seller_id, product_id)
values (15017, 232);
insert into SELL (seller_id, product_id)
values (15017, 292);
insert into SELL (seller_id, product_id)
values (15026, 178);
insert into SELL (seller_id, product_id)
values (15026, 390);
insert into SELL (seller_id, product_id)
values (15035, 128);
insert into SELL (seller_id, product_id)
values (15044, 4);
insert into SELL (seller_id, product_id)
values (15044, 139);
insert into SELL (seller_id, product_id)
values (15044, 460);
insert into SELL (seller_id, product_id)
values (15053, 13);
insert into SELL (seller_id, product_id)
values (15053, 191);
insert into SELL (seller_id, product_id)
values (15053, 224);
insert into SELL (seller_id, product_id)
values (15053, 425);
insert into SELL (seller_id, product_id)
values (15062, 10);
insert into SELL (seller_id, product_id)
values (15062, 251);
insert into SELL (seller_id, product_id)
values (15071, 13);
insert into SELL (seller_id, product_id)
values (15080, 430);
insert into SELL (seller_id, product_id)
values (15089, 84);
insert into SELL (seller_id, product_id)
values (15089, 418);
insert into SELL (seller_id, product_id)
values (15107, 321);
insert into SELL (seller_id, product_id)
values (15125, 238);
insert into SELL (seller_id, product_id)
values (15125, 346);
insert into SELL (seller_id, product_id)
values (15161, 108);
insert into SELL (seller_id, product_id)
values (15179, 104);
insert into SELL (seller_id, product_id)
values (15179, 316);
insert into SELL (seller_id, product_id)
values (15188, 341);
insert into SELL (seller_id, product_id)
values (15197, 80);
insert into SELL (seller_id, product_id)
values (15215, 209);
insert into SELL (seller_id, product_id)
values (15215, 372);
insert into SELL (seller_id, product_id)
values (15224, 418);
insert into SELL (seller_id, product_id)
values (15233, 325);
insert into SELL (seller_id, product_id)
values (15242, 20);
insert into SELL (seller_id, product_id)
values (15242, 65);
insert into SELL (seller_id, product_id)
values (15242, 224);
insert into SELL (seller_id, product_id)
values (15242, 359);
insert into SELL (seller_id, product_id)
values (15242, 406);
insert into SELL (seller_id, product_id)
values (15242, 448);
insert into SELL (seller_id, product_id)
values (15251, 26);
insert into SELL (seller_id, product_id)
values (15251, 96);
insert into SELL (seller_id, product_id)
values (15260, 18);
insert into SELL (seller_id, product_id)
values (15260, 479);
insert into SELL (seller_id, product_id)
values (15287, 111);
insert into SELL (seller_id, product_id)
values (15296, 17);
insert into SELL (seller_id, product_id)
values (15305, 117);
insert into SELL (seller_id, product_id)
values (15305, 364);
insert into SELL (seller_id, product_id)
values (15314, 81);
insert into SELL (seller_id, product_id)
values (15323, 197);
insert into SELL (seller_id, product_id)
values (15332, 285);
insert into SELL (seller_id, product_id)
values (15341, 85);
insert into SELL (seller_id, product_id)
values (15350, 100);
insert into SELL (seller_id, product_id)
values (15350, 383);
insert into SELL (seller_id, product_id)
values (15359, 55);
insert into SELL (seller_id, product_id)
values (15359, 61);
insert into SELL (seller_id, product_id)
values (15368, 234);
insert into SELL (seller_id, product_id)
values (15377, 152);
insert into SELL (seller_id, product_id)
values (15386, 140);
insert into SELL (seller_id, product_id)
values (15386, 312);
insert into SELL (seller_id, product_id)
values (15404, 113);
insert into SELL (seller_id, product_id)
values (15404, 178);
insert into SELL (seller_id, product_id)
values (15404, 211);
insert into SELL (seller_id, product_id)
values (15404, 281);
commit;
prompt 600 records committed...
insert into SELL (seller_id, product_id)
values (15404, 482);
insert into SELL (seller_id, product_id)
values (15413, 5);
insert into SELL (seller_id, product_id)
values (15413, 263);
insert into SELL (seller_id, product_id)
values (15458, 364);
insert into SELL (seller_id, product_id)
values (15458, 438);
insert into SELL (seller_id, product_id)
values (15485, 150);
insert into SELL (seller_id, product_id)
values (15485, 177);
insert into SELL (seller_id, product_id)
values (15494, 113);
insert into SELL (seller_id, product_id)
values (15512, 226);
insert into SELL (seller_id, product_id)
values (15521, 395);
insert into SELL (seller_id, product_id)
values (15539, 327);
insert into SELL (seller_id, product_id)
values (15557, 266);
insert into SELL (seller_id, product_id)
values (15566, 177);
insert into SELL (seller_id, product_id)
values (15575, 178);
insert into SELL (seller_id, product_id)
values (15584, 81);
insert into SELL (seller_id, product_id)
values (15620, 126);
insert into SELL (seller_id, product_id)
values (15620, 159);
insert into SELL (seller_id, product_id)
values (15620, 224);
insert into SELL (seller_id, product_id)
values (15620, 427);
insert into SELL (seller_id, product_id)
values (15620, 434);
insert into SELL (seller_id, product_id)
values (15629, 2);
insert into SELL (seller_id, product_id)
values (15638, 148);
insert into SELL (seller_id, product_id)
values (15647, 40);
insert into SELL (seller_id, product_id)
values (15656, 217);
insert into SELL (seller_id, product_id)
values (15665, 77);
insert into SELL (seller_id, product_id)
values (15665, 253);
insert into SELL (seller_id, product_id)
values (15665, 477);
insert into SELL (seller_id, product_id)
values (15674, 319);
insert into SELL (seller_id, product_id)
values (15683, 397);
insert into SELL (seller_id, product_id)
values (15683, 439);
insert into SELL (seller_id, product_id)
values (15692, 339);
insert into SELL (seller_id, product_id)
values (15701, 83);
insert into SELL (seller_id, product_id)
values (15710, 331);
insert into SELL (seller_id, product_id)
values (15719, 451);
insert into SELL (seller_id, product_id)
values (15728, 38);
insert into SELL (seller_id, product_id)
values (15737, 94);
insert into SELL (seller_id, product_id)
values (15737, 222);
insert into SELL (seller_id, product_id)
values (15737, 307);
insert into SELL (seller_id, product_id)
values (15737, 328);
insert into SELL (seller_id, product_id)
values (15746, 81);
insert into SELL (seller_id, product_id)
values (15755, 101);
insert into SELL (seller_id, product_id)
values (15782, 101);
insert into SELL (seller_id, product_id)
values (15791, 77);
insert into SELL (seller_id, product_id)
values (15791, 303);
insert into SELL (seller_id, product_id)
values (15800, 5);
insert into SELL (seller_id, product_id)
values (15800, 175);
insert into SELL (seller_id, product_id)
values (15800, 292);
insert into SELL (seller_id, product_id)
values (15800, 404);
insert into SELL (seller_id, product_id)
values (15809, 89);
insert into SELL (seller_id, product_id)
values (15818, 125);
insert into SELL (seller_id, product_id)
values (15836, 485);
insert into SELL (seller_id, product_id)
values (15845, 239);
insert into SELL (seller_id, product_id)
values (15845, 491);
insert into SELL (seller_id, product_id)
values (15854, 116);
insert into SELL (seller_id, product_id)
values (15863, 63);
insert into SELL (seller_id, product_id)
values (15872, 159);
insert into SELL (seller_id, product_id)
values (15872, 191);
insert into SELL (seller_id, product_id)
values (15881, 130);
insert into SELL (seller_id, product_id)
values (15917, 105);
insert into SELL (seller_id, product_id)
values (15935, 281);
insert into SELL (seller_id, product_id)
values (15935, 418);
insert into SELL (seller_id, product_id)
values (15944, 158);
insert into SELL (seller_id, product_id)
values (15962, 300);
insert into SELL (seller_id, product_id)
values (15962, 451);
insert into SELL (seller_id, product_id)
values (15971, 144);
insert into SELL (seller_id, product_id)
values (15980, 246);
insert into SELL (seller_id, product_id)
values (15980, 494);
insert into SELL (seller_id, product_id)
values (15989, 221);
insert into SELL (seller_id, product_id)
values (16025, 242);
insert into SELL (seller_id, product_id)
values (16025, 450);
insert into SELL (seller_id, product_id)
values (16034, 47);
insert into SELL (seller_id, product_id)
values (16034, 50);
insert into SELL (seller_id, product_id)
values (16034, 232);
insert into SELL (seller_id, product_id)
values (16043, 172);
insert into SELL (seller_id, product_id)
values (16043, 471);
insert into SELL (seller_id, product_id)
values (16052, 250);
insert into SELL (seller_id, product_id)
values (16061, 17);
insert into SELL (seller_id, product_id)
values (16070, 1);
insert into SELL (seller_id, product_id)
values (16070, 224);
insert into SELL (seller_id, product_id)
values (16079, 30);
insert into SELL (seller_id, product_id)
values (16079, 239);
insert into SELL (seller_id, product_id)
values (16088, 239);
insert into SELL (seller_id, product_id)
values (16097, 291);
insert into SELL (seller_id, product_id)
values (16097, 421);
insert into SELL (seller_id, product_id)
values (16106, 101);
insert into SELL (seller_id, product_id)
values (16106, 115);
insert into SELL (seller_id, product_id)
values (16106, 134);
insert into SELL (seller_id, product_id)
values (16115, 348);
insert into SELL (seller_id, product_id)
values (16124, 93);
insert into SELL (seller_id, product_id)
values (16124, 202);
insert into SELL (seller_id, product_id)
values (16124, 386);
insert into SELL (seller_id, product_id)
values (16124, 485);
insert into SELL (seller_id, product_id)
values (16133, 179);
insert into SELL (seller_id, product_id)
values (16142, 106);
insert into SELL (seller_id, product_id)
values (16151, 464);
insert into SELL (seller_id, product_id)
values (16160, 91);
insert into SELL (seller_id, product_id)
values (16169, 484);
insert into SELL (seller_id, product_id)
values (16178, 260);
insert into SELL (seller_id, product_id)
values (16196, 266);
insert into SELL (seller_id, product_id)
values (16214, 159);
commit;
prompt 700 records committed...
insert into SELL (seller_id, product_id)
values (16214, 437);
insert into SELL (seller_id, product_id)
values (16214, 466);
insert into SELL (seller_id, product_id)
values (16223, 19);
insert into SELL (seller_id, product_id)
values (16223, 391);
insert into SELL (seller_id, product_id)
values (16232, 58);
insert into SELL (seller_id, product_id)
values (16232, 291);
insert into SELL (seller_id, product_id)
values (16232, 350);
insert into SELL (seller_id, product_id)
values (16232, 481);
insert into SELL (seller_id, product_id)
values (16250, 124);
insert into SELL (seller_id, product_id)
values (16259, 41);
insert into SELL (seller_id, product_id)
values (16268, 43);
insert into SELL (seller_id, product_id)
values (16286, 307);
insert into SELL (seller_id, product_id)
values (16304, 57);
insert into SELL (seller_id, product_id)
values (16304, 97);
insert into SELL (seller_id, product_id)
values (16304, 240);
insert into SELL (seller_id, product_id)
values (16313, 8);
insert into SELL (seller_id, product_id)
values (16322, 384);
insert into SELL (seller_id, product_id)
values (16331, 118);
insert into SELL (seller_id, product_id)
values (16331, 191);
insert into SELL (seller_id, product_id)
values (16340, 355);
insert into SELL (seller_id, product_id)
values (16349, 75);
insert into SELL (seller_id, product_id)
values (16349, 138);
insert into SELL (seller_id, product_id)
values (16367, 304);
insert into SELL (seller_id, product_id)
values (16376, 491);
insert into SELL (seller_id, product_id)
values (16385, 278);
insert into SELL (seller_id, product_id)
values (16394, 141);
insert into SELL (seller_id, product_id)
values (16403, 123);
insert into SELL (seller_id, product_id)
values (16403, 180);
insert into SELL (seller_id, product_id)
values (16403, 274);
insert into SELL (seller_id, product_id)
values (16403, 325);
insert into SELL (seller_id, product_id)
values (16412, 433);
insert into SELL (seller_id, product_id)
values (16457, 190);
insert into SELL (seller_id, product_id)
values (16457, 441);
insert into SELL (seller_id, product_id)
values (16466, 140);
insert into SELL (seller_id, product_id)
values (16475, 72);
insert into SELL (seller_id, product_id)
values (16484, 41);
insert into SELL (seller_id, product_id)
values (16484, 153);
insert into SELL (seller_id, product_id)
values (16484, 332);
insert into SELL (seller_id, product_id)
values (16484, 405);
insert into SELL (seller_id, product_id)
values (16484, 459);
insert into SELL (seller_id, product_id)
values (16493, 317);
insert into SELL (seller_id, product_id)
values (16493, 480);
insert into SELL (seller_id, product_id)
values (16502, 338);
insert into SELL (seller_id, product_id)
values (16529, 79);
insert into SELL (seller_id, product_id)
values (16538, 122);
insert into SELL (seller_id, product_id)
values (16538, 227);
insert into SELL (seller_id, product_id)
values (16547, 118);
insert into SELL (seller_id, product_id)
values (16547, 220);
insert into SELL (seller_id, product_id)
values (16547, 397);
insert into SELL (seller_id, product_id)
values (16556, 108);
insert into SELL (seller_id, product_id)
values (16556, 237);
insert into SELL (seller_id, product_id)
values (16565, 76);
insert into SELL (seller_id, product_id)
values (16565, 445);
insert into SELL (seller_id, product_id)
values (16574, 490);
insert into SELL (seller_id, product_id)
values (16583, 178);
insert into SELL (seller_id, product_id)
values (16583, 207);
insert into SELL (seller_id, product_id)
values (16583, 293);
insert into SELL (seller_id, product_id)
values (16601, 40);
insert into SELL (seller_id, product_id)
values (16601, 84);
insert into SELL (seller_id, product_id)
values (16610, 238);
insert into SELL (seller_id, product_id)
values (16610, 456);
insert into SELL (seller_id, product_id)
values (16628, 132);
insert into SELL (seller_id, product_id)
values (16637, 70);
insert into SELL (seller_id, product_id)
values (16646, 118);
insert into SELL (seller_id, product_id)
values (16646, 383);
insert into SELL (seller_id, product_id)
values (16664, 340);
insert into SELL (seller_id, product_id)
values (16673, 236);
insert into SELL (seller_id, product_id)
values (16673, 254);
insert into SELL (seller_id, product_id)
values (16673, 467);
insert into SELL (seller_id, product_id)
values (16691, 19);
insert into SELL (seller_id, product_id)
values (16691, 69);
insert into SELL (seller_id, product_id)
values (16691, 142);
insert into SELL (seller_id, product_id)
values (16691, 236);
insert into SELL (seller_id, product_id)
values (16700, 364);
insert into SELL (seller_id, product_id)
values (16718, 88);
insert into SELL (seller_id, product_id)
values (16718, 304);
insert into SELL (seller_id, product_id)
values (16718, 435);
insert into SELL (seller_id, product_id)
values (16727, 447);
insert into SELL (seller_id, product_id)
values (16736, 124);
insert into SELL (seller_id, product_id)
values (16736, 167);
insert into SELL (seller_id, product_id)
values (16736, 282);
insert into SELL (seller_id, product_id)
values (16763, 484);
insert into SELL (seller_id, product_id)
values (16772, 196);
insert into SELL (seller_id, product_id)
values (16772, 337);
insert into SELL (seller_id, product_id)
values (16781, 380);
insert into SELL (seller_id, product_id)
values (16781, 388);
insert into SELL (seller_id, product_id)
values (16781, 419);
insert into SELL (seller_id, product_id)
values (16799, 65);
insert into SELL (seller_id, product_id)
values (16799, 199);
insert into SELL (seller_id, product_id)
values (16799, 267);
insert into SELL (seller_id, product_id)
values (16799, 415);
insert into SELL (seller_id, product_id)
values (16808, 476);
insert into SELL (seller_id, product_id)
values (16817, 326);
insert into SELL (seller_id, product_id)
values (16826, 287);
insert into SELL (seller_id, product_id)
values (16835, 387);
insert into SELL (seller_id, product_id)
values (16844, 129);
insert into SELL (seller_id, product_id)
values (16853, 89);
insert into SELL (seller_id, product_id)
values (16853, 94);
insert into SELL (seller_id, product_id)
values (16853, 374);
insert into SELL (seller_id, product_id)
values (16853, 408);
commit;
prompt 800 records committed...
insert into SELL (seller_id, product_id)
values (16862, 94);
insert into SELL (seller_id, product_id)
values (16871, 324);
insert into SELL (seller_id, product_id)
values (16880, 324);
insert into SELL (seller_id, product_id)
values (16898, 344);
insert into SELL (seller_id, product_id)
values (16925, 22);
insert into SELL (seller_id, product_id)
values (16925, 397);
insert into SELL (seller_id, product_id)
values (16925, 491);
insert into SELL (seller_id, product_id)
values (16934, 105);
insert into SELL (seller_id, product_id)
values (16943, 153);
commit;
prompt 809 records loaded
prompt Enabling foreign key constraints for ORDERS...
alter table ORDERS enable constraint SYS_C008592;
alter table ORDERS enable constraint SYS_C008593;
prompt Enabling foreign key constraints for INCLUDE_PRODUCTS...
alter table INCLUDE_PRODUCTS enable constraint SYS_C008609;
prompt Enabling foreign key constraints for REVIEWS...
alter table REVIEWS enable constraint SYS_C008599;
alter table REVIEWS enable constraint SYS_C008600;
prompt Enabling foreign key constraints for SELL...
alter table SELL enable constraint SYS_C008604;
alter table SELL enable constraint SYS_C008605;
prompt Enabling triggers for BUYERS...
alter table BUYERS enable all triggers;
prompt Enabling triggers for CATEGORIES...
alter table CATEGORIES enable all triggers;
prompt Enabling triggers for ORDERDETAILS...
alter table ORDERDETAILS enable all triggers;
prompt Enabling triggers for ORDERS...
alter table ORDERS enable all triggers;
prompt Enabling triggers for INCLUDE_PRODUCTS...
alter table INCLUDE_PRODUCTS enable all triggers;
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
