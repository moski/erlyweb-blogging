-module(blog_app_controller).
-export([hook/1]).

hook(A) ->
	{phased, {ewc, A},
		fun(_Ewc, Data, _PhasedVars) ->
			{ewc, html_container, 
			[A,  {ewc, main_layout, [A, {data, Data}]}]
			}
		end}.