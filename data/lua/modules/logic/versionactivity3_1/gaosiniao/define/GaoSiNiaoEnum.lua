module("modules.logic.versionactivity3_1.gaosiniao.define.GaoSiNiaoEnum", package.seeall)

local var_0_0 = _M
local var_0_1 = Bitwise

var_0_0.Version = {
	V1_0_0 = "1_0_0"
}

local var_0_2 = "ui/viewres/versionactivity_3_1/v3a1_gaosiniao/"

var_0_0.ResPath = {
	v3a1_gaosiniao_levelviewstageitem = var_0_2 .. "v3a1_gaosiniao_levelviewstageitem.prefab"
}
var_0_0.EpisodeType = {
	SP = 1,
	Normal = 0
}
var_0_0.dX = {
	0,
	1,
	0,
	-1
}
var_0_0.dY = {
	-1,
	0,
	1,
	0
}

local var_0_3 = {
	None = 0,
	North = var_0_1["<<"](1, 0),
	East = var_0_1["<<"](1, 1),
	South = var_0_1["<<"](1, 2),
	West = var_0_1["<<"](1, 3)
}

var_0_3.NE = var_0_1["|"](var_0_3.North, var_0_3.East)
var_0_3.NW = var_0_1["|"](var_0_3.North, var_0_3.West)
var_0_3.SE = var_0_1["|"](var_0_3.South, var_0_3.East)
var_0_3.SW = var_0_1["|"](var_0_3.South, var_0_3.West)
var_0_3.NS = var_0_1["|"](var_0_3.North, var_0_3.South)
var_0_3.EW = var_0_1["|"](var_0_3.East, var_0_3.West)
var_0_3.NEW = var_0_1["|"](var_0_3.NE, var_0_3.West)
var_0_3.NSW = var_0_1["|"](var_0_3.NS, var_0_3.West)
var_0_3.SEW = var_0_1["|"](var_0_3.SE, var_0_3.West)
var_0_3.NSE = var_0_1["|"](var_0_3.NS, var_0_3.East)
var_0_3.All = var_0_1["|"](var_0_3.NS, var_0_3.EW)
var_0_0.ZoneMask = var_0_3

function var_0_0.dirToStr(arg_1_0)
	for iter_1_0, iter_1_1 in pairs(var_0_3) do
		if arg_1_0 == iter_1_1 then
			return iter_1_0
		end
	end

	return "Unknown"
end

local var_0_4 = 15

function var_0_0.flipDir(arg_2_0)
	local var_2_0 = var_0_1["&"](arg_2_0, var_0_3.North)
	local var_2_1 = var_0_1["&"](arg_2_0, var_0_3.East)
	local var_2_2 = var_0_1["&"](arg_2_0, var_0_3.South)
	local var_2_3 = var_0_1["&"](arg_2_0, var_0_3.West)
	local var_2_4 = var_0_1["|"](var_0_1["<<"](var_2_0, 2), var_0_1[">>"](var_2_2, 2))
	local var_2_5 = var_0_1["|"](var_0_1["<<"](var_2_1, 2), var_0_1[">>"](var_2_3, 2))
	local var_2_6 = var_0_1["|"](var_2_4, var_2_5)
	local var_2_7 = var_0_1["&"](arg_2_0, var_0_1["~"](var_0_3.All))
	local var_2_8 = var_0_1["|"](var_2_7, var_2_6)

	return var_0_1["&"](var_2_8, var_0_4)
end

function var_0_0.bitPos2Dir(arg_3_0)
	assert(arg_3_0 >= 0 and arg_3_0 <= 3)

	return var_0_1["<<"](1, arg_3_0)
end

var_0_0.GridType = {
	Path = 5,
	End = 3,
	__End = 6,
	Wall = 1,
	Portal = 2,
	Start = 4,
	Empty = 0
}

local var_0_5 = {
	Exit2_Straight = 2,
	Exit3 = 3,
	Exit4 = 4,
	Exit2_Angle = 1,
	__End = 5,
	None = 0
}

var_0_0.PathSpriteId = var_0_5

local var_0_6 = {
	RTB = 8,
	LT = 1,
	TB = 5,
	LR = 6,
	RT = 3,
	RB = 4,
	LRB = 9,
	LB = 2,
	LRT = 10,
	LRTB = 11,
	__End = 12,
	LTB = 7,
	None = 0
}

var_0_0.PathType = var_0_6

local var_0_7 = {
	[var_0_6.None] = {
		zRot = 0,
		outZM = var_0_3.None,
		spriteId = var_0_5.None
	},
	[var_0_6.LT] = {
		zRot = -90,
		outZM = var_0_3.NW,
		spriteId = var_0_5.Exit2_Angle
	},
	[var_0_6.RT] = {
		zRot = 180,
		outZM = var_0_3.NE,
		spriteId = var_0_5.Exit2_Angle
	},
	[var_0_6.LB] = {
		zRot = 0,
		outZM = var_0_3.SW,
		spriteId = var_0_5.Exit2_Angle
	},
	[var_0_6.RB] = {
		zRot = 90,
		outZM = var_0_3.SE,
		spriteId = var_0_5.Exit2_Angle
	},
	[var_0_6.TB] = {
		zRot = 0,
		outZM = var_0_3.NS,
		spriteId = var_0_5.Exit2_Straight
	},
	[var_0_6.LR] = {
		zRot = 90,
		outZM = var_0_3.EW,
		spriteId = var_0_5.Exit2_Straight
	},
	[var_0_6.LTB] = {
		zRot = -90,
		outZM = var_0_3.NSW,
		spriteId = var_0_5.Exit3
	},
	[var_0_6.RTB] = {
		zRot = 90,
		outZM = var_0_3.NSE,
		spriteId = var_0_5.Exit3
	},
	[var_0_6.LRB] = {
		zRot = 0,
		outZM = var_0_3.SEW,
		spriteId = var_0_5.Exit3
	},
	[var_0_6.LRT] = {
		zRot = 180,
		outZM = var_0_3.NEW,
		spriteId = var_0_5.Exit3
	},
	[var_0_6.LRTB] = {
		zRot = 0,
		outZM = var_0_3.All,
		spriteId = var_0_5.Exit4
	}
}

for iter_0_0, iter_0_1 in pairs(var_0_7) do
	iter_0_1.inZM = var_0_0.flipDir(iter_0_1.outZM)
end

var_0_0.PathInfo = var_0_7
var_0_0.operation_type = {
	finish = "finish",
	Unknown = "",
	reset = "reset",
	exit = "exit"
}

function var_0_0.unitTest()
	local var_4_0 = var_0_0.flipDir

	assert(var_4_0(var_0_3.None) == var_0_3.None)
	assert(var_4_0(var_0_3.North) == var_0_3.South)
	assert(var_4_0(var_0_3.NE) == var_0_3.SW)
	assert(var_4_0(var_0_3.EW) == var_0_3.EW)
	assert(var_4_0(var_0_1["|"](var_0_3.NE, var_0_3.South)) == var_0_1["|"](var_0_3.SW, var_0_3.North))
end

return var_0_0
