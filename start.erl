-module(start).
-export([boot/0, boot/1]).


boot() ->
boot(true).
boot(false) ->
compile();
boot(true) ->
mysql_start(),
compile().

mysql_start() -> erlydb:start(mysql, [{hostname, DB_HOSTNAME }, {username, DB_USERNAME }, {password, "DB_PASSWORD"}, {database, DB_DATABASE}]).
compile() -> erlyweb:compile(APP_PATH, [{erlydb_driver, mysql}]).


