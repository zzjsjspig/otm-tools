function [ x ] = setequals( A , B )

x = numel(A)==numel(B) && isempty(setdiff(A,B)) && isempty(setdiff(B,A));

