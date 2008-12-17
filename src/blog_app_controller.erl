-module(blog_app_controller).
-export([hook/1]).

hook(A) ->
	A1= normalize_appmoddata(A),
	
	
	Ewc = erlyweb:get_initial_ewc({ewc, A1}), 
	case Ewc of 
		{page,_}=Page -> 
			Page; 
		_ -> 
			{phased, Ewc, fun(_Ewc, Data,_PhasedVars) -> 
				{ewc, html_container, 
				[A,  {ewc, main_layout, [A, {data, Data}]}]
				}
			end} 
	end.
		
%%%% Took and modified from http://github.com/yariv/twoorl/tree/master/src/twoorl_app_controller.erl	
normalize_appmoddata(A) ->
  Val1 =
  	case yaws_arg:appmoddata(A) of
   		[] ->
			io:fwrite("Hello world!~n", []),
    		"/entry";
   		Val = [$/ | _] ->
    		Val;
   		Val ->
    		[$/ | Val]
  	end,
    yaws_arg:appmoddata(A, Val1).