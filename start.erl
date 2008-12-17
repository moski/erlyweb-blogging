-module(start).
-export([boot/0, boot/1]).


boot() ->
boot(true).
boot(false) ->
compile();
boot(true) ->
mysql_start(),
compile().

mysql_start() -> erlydb:start(mysql, [{hostname, "localhost"}, {username, "erlang"}, {password, "erlang"}, {database, "blog"}]).
compile() -> erlyweb:compile("/Users/Moski/erlang/apps/blog", [{erlydb_driver, mysql}]).


