-module(blog).
-compile(export_all).
-include("blog_app.hrl").

start() ->
	start(true).

start(false) ->
	compile();

start(true) ->
	mysql_start(),
	compile().

mysql_start() -> 
	erlydb:start(mysql, [{hostname, ?DB_HOSTNAME}, {username, ?DB_USERNAME}, {password, ?DB_PASSWORD}, {database, ?DB_DATABASE}]).

compile() -> 
	erlyweb:compile(?APP_PATH, [{erlydb_driver, mysql}]).


