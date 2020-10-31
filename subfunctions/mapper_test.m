%%% Test for mapper.m

%% QPSK test     -    constellation = (A, B, C, D)
constellation = ["A","B","C","D"];
% bits  = 0 0  0 1  1 0  1 1 
% dezi  =   0    1    2    3
% index =   1    2    3    4
% y     =   A    B    C    D


bits = [0,0,0,1,1,0,1,1];
y = mapper(bits, constellation);
test_y = ["A","B","C","D"];
if y == test_y
    fprintf("\nQPSK - Test 1 : passed\n");
else
    fprintf("\nQPSK - Test 1 : failed\n");
end

% bits  = 0 0  0 0  1 1  0 1  1 1  0 0  1 0
% dezi  =   0    0    3    1    3    0    2
% index =   1    1    4    2    4    1    3
% y     =   A    A    D    B    D    A    C

bits = [0,0,0,0,1,1,0,1,1,1,0,0,1,0];
y = mapper(bits, constellation);
test_y = ["A","A","D","B","D","A","C"];
if y == test_y
    fprintf("\nQPSK - Test 2 : passed\n");
else
    fprintf("\nQPSK - Test 2 : failed\n");
end

%% 8-PSK test    constellation = (A,B,C,D,E,F;G,H)
constellation = ["A","B","C","D","E","F","G","H"];
% bits  = 0 0 0  0 0 1  0 1 0  0 1 1  1 0 0  1 0 1  1 1 0  1 1 1  
% dezi  =     0      1      2      3      4      5      6      7
% index =     1      2      3      4      5      6      7      8
% y     =     A      B      C      D      E      F      G      H

bits = [0,0,0 0,0,1, 0,1,0, 0,1,1, 1,0,0, 1,0,1, 1,1,0, 1,1,1];
y = mapper(bits, constellation);
test_y = ["A","B","C","D","E","F","G","H"];
if y == test_y
    fprintf("\n8-PSK - Test 1 : passed\n");
else
    fprintf("\n8-PSK - Test 1 : failed\n");
end

