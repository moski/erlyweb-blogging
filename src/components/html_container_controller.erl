-module(html_container_controller).
-export([private/0, index/2]).

private() ->
	true.

index(_A, Ewc) ->
	Ewc.