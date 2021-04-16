pico-8 cartridge // http://www.pico-8.com
version 32
__lua__

#include object.lua
#include input.lua
#include gamestate.lua
#include player.lua
#include objects.lua
#include main.lua

__gfx__
00000000000000000077777000000000000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000
000000000077777007711cc700000000000000000000000000000000000000000000000000000000000000000000032200000000000000000000000000000000
0070070007711cc70771ccc700000000000000000000000000000000000000000000000000000000000000000000003200000000000000000000000000000000
000770000771ccc707711cc700000000000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000
0007700007711cc70077777000000000000000000000000000000000000000000000000000000000000000000000032200000000000000000000000000000000
00700700007777700055555000000000000000000000000000000000000000000000000000000000030030300000000200000000000000000000000000000000
00000000005555500600000600000000000000000000000000000000000000000000000000000000320323200000032200000000000000000000000000000000
00000000006000600000000000000000000000000000000000000000000000000000000000000000222222220000003200000000000000000000000000000000
0666666666666666666666600666666006666666666666666666666000000000000000000000000005ddddd00000000000000000000000000000000000000000
65555555555555555555555665555556655655555566555555555556000000000000000000000000dd5d55dd0000000000000000000000000000000000000000
65555555555555565555555665665556655555655555556655555656000000000000000000000000d55dd5dd0000000000000000000000000000000000000000
65556555555555555556555665665556655665555555656656655556000000000000000000000000d55d5dd50000000000000000000000000000000000000000
65566565556655555556555665555656655665555555655556656656000000000000000000000000dd5d55d50000000000000000000000000000000000000000
655555665566555556555556655555566555555656555555555566560000000000000000000000005ddddd5d0000000000000000000000000000000000000000
65555566555556555555655665665556655665555555655555555556000000000000000000000000d5ddd5dd0000000000000000000000000000000000000000
656555555555555555555556655555560666666666666666666666600000000000000000000000000dd55dd00000000000000000000000000000000000000000
65555555555555555555555665565556000000000000000000000000000000000000000000000000eeeeeeee00000000c0c0c0c0c0c0c0c0c0c0c00c00000000
65555565555555555655565665555556000000000000000000000000000000000000000000000000eeeeeeee000000000cccccccccccccccccccccc000000000
65665555556555655555555665555656000000000000000000000000000000000000000000000000eeeeeeee000000000cc771111117711111177cc000000000
65665555555555555556555665555556000000000000000000000000000000000000000000000000eeeeeeee00000000cc77771111777711117777cc00000000
65665555555555555555555665555556000000000000000000000000000000000000000000000000eeeeeeee00000000cc77771111777711117777cc00000000
65555556565555655665555665665556000000000000000000000000000000000000000000000000eeeeeeeeeeeeeeee0cc771111117711111177cc000000000
65555555555565555665555665665556000000000000000000000000000000000000000000000000eeeeeeeeeeeeeeee0cccccccccccccccccccccc000000000
65556555555555555555556665555556000000000000000000000000000000000000000000000000eeeeeeeeeeeeeeeec0c0c0c0c0c0c0c0c0c0c00c00000000
65555555555555555555555665565556066666600000000000000000000000000000000000000000555555555555555555555555000000000000080800000000
6555555555555565555555566555555665555556000000000000000000000000000000000000000055555555555555555555555500000000009090e000000000
6565566555655565555655566565565665655556000000000000000000000000000000000000000055555555555555555555555500900030000a083800000000
65555665556555655555556665555556655566560000000000000000000000000000000000000000555555555555555555555555000303080093930000000000
65555555555565556555555665555666655566560000000000000000000000000000000000000000000000000000000000000000000303003003030800000000
65565555556665555555555665555666655555560000000000000000000000000000000000000000000000000000000000000000000300303303003000000000
66555555555555555665555665655556655565560000000000000000000000000000000000000000000000000000000000000000003003000303303000000000
06666666666666666666666006666660066666600000000000000000000000000000000000000000000000000000000000000000000300303333333300000000
__label__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000065555555
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000007000000000000000000000000000000065555565
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000065665555
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000065665555
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000070000000000000000000000000000000065665555
00000000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000065555556
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000065555555
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000065556555
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000065555555
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000065555555
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000065655665
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000065555665
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000065555555
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000065565555
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000066555555
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006666666
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000070000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000070000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000777000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000070000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000700000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000070000000000
00000000000000000000000000000000000000000000000000000000000000000000000000070000000000000000000000000000000000000000777000000000
00000000000000000000000000000000000000000000000000000000000000000000000000777000000000000000000000000000000000000000070000000000
00000000000000000000000000000000000000000000000000000000000000000000000000070000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000070000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000007000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000007711cc70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000771ccc70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000007711cc70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000005555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000006000600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06666666666666666666666666666660000000000000000000000000066666666666666666666666666666600000000000000000000000000000000006666666
65555555555555555555555555555556000000000000000000000000655555555555555555555555555555560000000000000000000000000000000065555555
65555555555555565555555655555556000000000000000000000000655555555555555655555556555555560000000000000000000000000000000065555555
65556555555555555555555555565556000000000000000000000000655565555555555555555555555655560000000000000000000000000000000065556555
65566565556655555566555555565556000000000000000000000000655665655566555555665555555655560000000000000000000000000000000065566565
65555566556655555566555556555556000000000000000000000000655555665566555555665555565555560000000000000000000000000000000065555566
65555566555556555555565555556556000000000000000000000000655555665555565555555655555565560000000000000000000000000000000065555566
65655555555555555555555555555556000000000000000000000000656555555555555555555555555555560000000000000000000000000000000065655555
65555555555555555555555555555556000000000000000000000000655555555555555555555555555555560000000000000000000000000000000065555555
65555565555555555555555556555656000000000000000000000000655555655555555555555555565556560000000000000000000000000000000065555565
65665555556555655565556555555556000000000000000000000000656655555565556555655565555555560000000000000000000000000000000065665555
65665555555555555555555555565556000000000000000000000000656655555555555555555555555655560000000000000000000000000000000065665555
65665555555555555555555555555556000000000000000000000000656655555555555555555555555555560000000000000000000000000000070065665555
65555556565555655655556556655556000000000000000000000000655555565655556556555565566555560000000000000000000000000000000065555556
65555555555565555555655556655556000000000007000000000000655555555555655555556555566555560000000000000000000000000000000065555555
65556555555555555555555555555566000000000077700000000000655565555555555555555555555555660000000000000000000000000000000065556555
65555555555555555555555555555556000000000007000000000000655555555555555555555555555555560000000000000000000000000000000065555555
65555565555555555555555556555656000000000000000000000000655555555555556555555565555555560000000000000000000000000000000065555565
65665555556555655565556555555556000000000000000000000000656556655565556555655565555655560000000000000000000000000000000065665555
65665555555555555555555555565556070000000000000000000000655556655565556555655565555555660000000000000000000000000000000065665555
65665555555555555555555555555556000000000000000000000000655555555555655555556555655555560000000000000000000000000000000065665555
65555556565555655655556556655556000000000000000000000000655655555566655555666555555555560000000000000000000000000000000065555556
65555555555565555555655556655556000000000000000000000000665555555555555555555555566555560000000000000000000000000000000065555555
65556555555555555555555555555566000000000000000000000000066666666666666666666666666666600000000000000000000000000000000065556555

__gff__
0000000000000000000000000000000003030303030303000000000000000000030303030300000000000000000000000303030303000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
00000000000000000000000000000020212121212122000000000000000000000000000b130b00001011111112000000000000000b1011120c00101210111111121011111111111111111111111112000000000000000020212121212121220000000014151515151516000000000000141516000000000000000b2021212121
00000000000000000000000000000030313131313132000000000000000000000000000b230b00002021212122000000000000000b2021220c0020223031313132302121212121212121212121212200000000000000002021212121212122000000000000000a0a0a0a000000000000000000000000000000000b2021212121
00000000000000000000000000000000000000000000000000000000000000000000000b230b00002021212122000000000000000b2021220c0020220a0a0a0a0a2021212121212121212121212122000000000000000020212121212121220000000000000000000000000000000000000000000000000000000b2021212121
00000000000000000000000000000000000000000000000000000000000000000000000b230b000030313131321a1a1a1a0000000b3031320000202200000000003031313131313131313131313132000000000000000030313131313131320000000000000000000000000000000000000000000000000000000b2021212121
00000000000000000000000000000000000000000000000000000000000000000000000b230b0000000000000000000000000000000a0a0a0000202200000000000a0a0a0a1011111111111111111200000000000000000000000b101111120000000000000000000000000000000000000000000000000000000b2021212121
00000000000000000000000000000000000000000000000000000000000000000000000b230b000000000000000000000000000000000000000020220000000000000000002021212121212121212200000000000000000000000b202121220000000000000000000000000000000000000000000000000000000b2021212121
00000000000000000000000000000000000000000000000000000000000000000000000b230b000000000000000000000000000000000000000020220000000000000000002021212121212121212200000000000000000000000b202121220000000000000000000000000000000000000000000000000000000b2021212121
00000000000000000000000000000000000000000000000000000000000000000000000b230b000000000000000000000000000000000000000020220000000000000000003031313131313131313200000000000000000000000b202121220000000000000000000000000000000000000000000000000000000b2021212121
00000000000000000000000000000000000000000000000000000000000000000000000b230b000000000000000000000000000000000000000020220000000000000000000000000000000000000000000000000000000000000b20212122000000000000002c00002e000000000000000000000000000000000b2021212121
00000000000000000000000000000000000000000000000000000000000000000000000b230b000000000000000000000000000000000000000020220000000000000000000000000000000000000000000000000000000000000b202121220000000000000010111111111200000000000000000000000000000b2021212121
00000000000000000000000000000000000000000000000000000000000000000000000b230b000000000000000000000000000000000000000030320000000000000000000000000000000000000000000000000000000000000b202121220000000000000020212121212200000000000000000000000000000b2021212121
00000000000000000000000000000000000000000000000000001011111112000000000b330b00000000000000000000000000001a0000001a000a0a001a000a00000000000000000000000000000000000000000000000000000b202121220000000000000020212121212200000000000000000000000000000b2021212121
0001000000000000000000000000000000000000000000000000202121212200000000000a000000000000000000000000000000000000000000000000000b130b000000000000000000000000000000000000000000000000000b303131320000000000000020212121212200000000000000000000000000000b3031313131
10111112000000101111120000000010111200000000000000002021212122000000000000000000000000000000000000000000000000000000000000000b230b00000000000000000000000000000000000000000000000000000a0a0a0a00000000000000202121212122000000001a00001a00001a00001a000a0a0a0a0a
20212122000000202121220000000020212200000000000000002021212122000000000000000000000000000000000000000000000000000000000000000b230b00003d002c2e0000002c0000002e00000000000000002c00002e00000000000000002c002e202121212122000000002c0000000000000000002e0000000000
20212122000000303131320000000020212200000000000000002021212122000000000000000000000000000000000000000000000000000000000000000b330b001415151516000000141515151515151600000014151515151515151515151600001415162021212121220000000014151515151515151515151515151515
1011111200000000000000000000000000000000000000000000303131313200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2021212200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2021212200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3031313200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1011111200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2021212200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2021212200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3031313200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000200000b0600d0600f06011050120501305014000150001600017000180001e000180001a0001b0001f00021000230002400000000000000000000000000000000000000000000000000000000000000000000
000200001d04017040120400c05012550175601d56007000000072200723007250072600728007280072900700407004070040700407004070040700406004060040600406004060040600406004060040600406
000200001f123126351e133106251d1330d6251c1330a6251b103076051a103056051910302605230000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010200001f0601f560240602455026056265562930229042295422903229532232022320225202261022720227202272020420204202042020420204202042020020200202002020020200202002020020200202
000100001a360193601836017360163501535014350133501234011340103401b3401a330193301833017330163201532014320133101231011310103001b1002e10009000080000000000000000000000000000
01100000145541404517554170451b5541b0421b5421b0311655216042165521604112554120421254212031145541404517554170451b5541b0421b5421b0311655216042165521604112554120421254212031
0108000019045255521b045275521b0451e5522a0422a5422a0322a53214000140001400012505125021250200500005000050000500005000050000500005000050000500005000050000500005000050000500
011000001475214542207311255212742125421e7321e7310d7520d542197310f5520f7420f5421b7321b7310d7520d542197310f5520f7420f5421b7321b7310d7520d542197310f5520f7420f5421b7321b731
011000001803318033180031803318033180030062318003180331803318003180331803318003006231800318033180331800318033180331800300623180031803318033180031803318033180030062318003
311000001d5521d5411f5521f5411d5521d541215522154221532215311f5521f5411c5521c5411f5521f5421f5321f531215522154221532215311f5021f5011c5021c501215022150221502215022150221502
011000001115211152111421114211132111321515215142151321513115132151311315213151131421314113132131311515215152151421514115132151311f5021f5011c5021c50121502215022150221502
011000001800300000000001800300000000001800300000180030000000000180031800300000000001800318003000000000018003000001800300000000001800300000000001800300000000001800300000
011000000015200142001420013202100021000415204142041420413207152071420714207132051000510000152001420014200132021020210204152041420414204132051520515205142051420513205132
011000000c043000000c0433f20524615000003f2053f2050c043000000c00300000246150c0033f2053f2050c043000000c0430000024615000003f2053f2050c04300000000000000024615000003f2053f205
011000001c5521c5421c5321c5321d5521d5421f5521f5421f5321f5321a5521a5421a5421a5321a5321a5321c5521c5421c5321c5321d5521d5421f5521f5421f5321f532215522154221542215322153221532
0110000018755185451c5021c7551c5451d7021875518545187051f7551f5421f732215512174521535185021a7551a5451c7051c7551c5451d7021a7551a545187052175521542217322455124745245350c502
__music__
01 14155644
00 14154344
00 14151744
00 14151757
00 14151656
00 14151656
00 14151757
02 14151757

