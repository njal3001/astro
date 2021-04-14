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
00000000333333330000000000000000000000000000000000000000000000000000000000000000000000000000088800000000000000000000000000000000
00000000333333330000000000000000000000000000000000000000000000000000000000000000000000000000088800000000000000000000000000000000
00700700333333330000000000000000000000000000000000000000000000000000000000000000000000000000088800000000000000000000000000000000
00077000333333330000000000000000000000000000000000000000000000000000000000000000000000000000088800000000000000000000000000000000
00077000333333330000000000000000000000000000000000000000000000000000000000000000000000000000088800000000000000000000000000000000
00700700333333330000000000000000000000000000000000000000000000000000000000000000888888880000088800000000000000000000000000000000
00000000333333330000000000000000000000000000000000000000000000000000000000000000888888880000088800000000000000000000000000000000
00000000333333330000000000000000000000000000000000000000000000000000000000000000888888880000088800000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000dddddddd0000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000dddddddd0000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000dddddddd0000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000dddddddd0000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000dddddddd0000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000dddddddd0000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000dddddddd0000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000dddddddd0000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000eeeeeeee0000000009999999999999999999999000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000eeeeeeee0000000099999999999999999999999900000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000eeeeeeee0000000099999999999999999999999900000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000eeeeeeee0000000099999999999999999999999900000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000eeeeeeee0000000099999999999999999999999900000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000eeeeeeeeeeeeeeee99999999999999999999999900000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000eeeeeeeeeeeeeeee99999999999999999999999900000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000eeeeeeeeeeeeeeee09999999999999999999999000000000
44444444000000000000000000000000000000000000000000000000000000000000000000000000555555555555555555555555cccccccc0000000000000000
44444444000000000000000000000000000000000000000000000000000000000000000000000000555555555555555555555555cccccccc0000000000000000
44444444000000000000000000000000000000000000000000000000000000000000000000000000555555555555555555555555cccccccc0000000000000000
44444444000000000000000000000000000000000000000000000000000000000000000000000000555555555555555555555555cccccccc0000000000000000
44444444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000cccccccc0000000000000000
44444444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000cccccccc0000000000000000
44444444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000cccccccc0000000000000000
44444444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000cccccccc0000000000000000
__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
00000000000000000000000000000030303030303030000000000000000000000000000b300b00003030303030000000000000000b3030303030303030303030303030303030303030303030303030000000000000000030303030303030300000000030303030303030000000000000303030000000000000000b3030303030
00000000000000000000000000000030303030303030000000000000000000000000000b300b00003030303030000000000000000b303030303030303030303030303030303030303030303030303000000000000000003030303030303030000000000000000a0a0a0a000000000000000000000000000000000b3030303030
00000000000000000000000000000000000000000000000000000000000000000000000b300b00003030303030000000000000000b303030303030300a0a0a0a0a303030303030303030303030303000000000000000000000000b303030300000000000000000000000000000000000000000000000000000000b3030303030
00000000000000000000000000000000000000000000000000000000000000000000000b300b000030303030301a1a1a1a0000000b303030303030300000000000303030303030303030303030303000000000000000000000000b303030300000000000000000000000000000000000000000000000000000000b3030303030
00000000000000000000000000000000000000000000000000000000000000000000000b300b0000000000000000000000000000000a0a0a0a0a0a0a00000000000a0a0a0a3030303030303030303000000000000000000000000b303030300000000000000000000000000000000000000000000000000000000b3030303030
00000000000000000000000000000000000000000000000000000000000000000000000b300b000000000000000000000000000000000000000000000000000000000000003030303030303030303000000000000000000000000b303030300000000000000000000000000000000000000000000000000000000b3030303030
00000000000000000000000000000000000000000000000000000000000000000000000b300b000000000000000000000000000000000000000000000000000000000000003030303030303030303000000000000000000000000b303030300000000000000000000000000000000000000000000000000000000b3030303030
00000000000000000000000000000000000000000000000000000000000000000000000b300b00000000000000000000000000000000000000000a000000000000000000003030303030303030303000000000000000000000000b303030300000000000000000000000000000000000000000000000000000000b3030303030
00000000000000000000000000000000000000000000000000000000000000000000000b300b000000000000000000000000000000000000000b300b0000000000000000000000000000000000000000000000000000000000000b303030300000000000000000000000000000000000000000000000000000000b3030303030
00000000000000000000000000000000000000000000000000000000000000000000000b300b000000000000000000000000000000000000000b300b0000000000000000000000000000000000000000000000000000000000000b30303030000000000000002c00002e000000000000000000000000000000000b3030303030
00000000000000000000000000000000000000000000000000000000000000000000000b300b000000000000000000000000000000000000000b300b0000000000000000000000000000000000000000000000000000000000000b303030300000000000000030303030303000000000000000000000000000000b3030303030
00000000000000000000000000000000000000000000000000003030303030000000000b300b00000000000000000000000000001a0000001a000a00001a000a00000000000000000000000000000000000000000000000000000b303030300000000000000030303030303000000000000000000000000000000b3030303030
0001000000000000000000000000000000000000000000000000303030303000000000000a000000000000000000000000000000000000000000000000000b300b000000000000000000000000000000000000000000000000000b303030300000000000000030303030303000000000000000000000000000000b3030303030
30303030000000303030300000000030303000000000000000003030303030000000000000000000000000000000000000000000000000000000000000000b300b00000000000000000000000000000000000000000000000000000a0a0a0a00000000000000303030303030000000001a0000001a1a0000001a000a0a0a0a0a
30303030000000303030300000000030303000000000000000003030303030000000000000000000000000000000000000000000000000000000000000000b300b00003d002c2e0000002c0000002e00000000000000002c002e0000000000000000002c002e303030303030000000002c00000000000000002e000000000000
30303030000000303030300000000030303000000000000000003030303030000000000000000000000000000000000000000000000000000000000000000b300b003030303030000000303030303030303000000030303030303030303030303000003030303030303030300000000030303030303030303030303030303030
3030303000000030303030000000003030300000000000000000303030303000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
