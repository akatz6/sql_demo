Create Table If not exists admin (
	admin_id serial PRIMARY KEY,
	admin_name VARCHAR(50) NOT NULL Unique,
	admin_password VARCHAR(50) NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
    timestamp timestamp default current_timestamp
);

--drop table admin;

insert into admin(admin_name, admin_password, first_name, last_name) values ('aaron@katz.com', 'bad_password', 'Aaron', 'Katz');
insert into admin(admin_name, admin_password, first_name, last_name) values ('katz@aaron.com', 'bad_password', 'Katz', 'Aaron');

select admin_name, CONCAT(first_name, ' ', last_name)  as name from admin;

select COUNT(admin_id)  as users from admin;

select SUM(admin_id)  as sum_users from admin;

select * from admin

update admin set admin_password = 'anothers bad password'
where admin_id = 2

Create Table If not exists player (
	player_id serial PRIMARY KEY,
	player_name VARCHAR(50) NOT NULL Unique,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
    timestamp timestamp default current_timestamp
);

Create Table If not exists game (
	game_id serial PRIMARY KEY,
	score VARCHAR(50) NOT NULL,
	won int NOT NULL,
	lost int NOT NULL,
    timestamp timestamp default current_timestamp
);

CREATE TABLE If not exists game_player (
  player_id    int REFERENCES player (player_id) ON UPDATE CASCADE ON DELETE CASCADE
, game_id int REFERENCES game (game_id) ON UPDATE CASCADE
, CONSTRAINT game_player_pkey PRIMARY KEY (player_id, game_id) 
);

--drop table player
--drop table game_player
--drop table game



insert into player(player_name, first_name, last_name) values ('mario', 'Mario', 'Plumber');
insert into player(player_name, first_name, last_name) values ('link', 'Link', 'Zelda');

insert into game(score, won, lost) values ('5-4', 1, 0);
insert into game(score, won, lost) values ('3-2', 1, 0);
insert into game(score, won, lost) values ('3-5', 0, 1);
insert into game(score, won, lost) values ('4-2', 1, 0);

insert into game_player(player_id, game_id) values (1, 1);
insert into game_player(player_id, game_id) values (1, 2);
insert into game_player(player_id, game_id) values (2, 1);
insert into game_player(player_id, game_id) values (2, 2);
insert into game_player(player_id, game_id) values (2, 3);
insert into game_player(player_id, game_id) values (2, 4);


select p.player_name, sum (g.won) as wins,  sum (g.lost)  as loses, sum(g.won::float)/(sum(g.won::float) + sum(g.lost::float)) as percentage from player as p
inner join game_player as gp on gp.player_id = p.player_id
inner join game as g on g.game_id = gp.game_id
group by p.player_name


