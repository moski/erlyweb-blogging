-module(main_layout_controller).
-export([index/2]).


index(A, Ewc) ->
  [Ewc, {ewc, sidebar, [A,Ewc]}].