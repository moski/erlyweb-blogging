-module(sidebar_controller).
-compile(export_all).
 
%% This tells ErlyWeb to reject browser requests that try to
%% access this component directly
private() -> true.
 
index(A,Ewc) ->
	Ewc.