drop table if exists category;
create table category (
  id integer primary key auto_increment,
  title varchar(100) not null,
  description varchar(100) not null
) engine=innodb;

drop table if exists entry;
create table entry (
  id integer primary key auto_increment,
  title varchar(100) not null,
  body text,
  created_on timestamp,
  category_id integer unsigned not null
) engine=innodb;


drop table if exists comment;
create table comment (
	id integer auto_increment primary key,
	name varchar(100) not null,
	email varchar(100) not null,
	website varchar(100),
	message text,
	created timestamp,
	entry_id integer unsigned not null
) engine=innodb;