module("modules.configs.excel2json.lua_monster_skin", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	retangleIcon = 12,
	weatherParam = 14,
	spine = 6,
	name = 2,
	clickBoxUnlimit = 26,
	mainBody = 22,
	nameEng = 3,
	bossSkillSpeed = 24,
	isFly = 9,
	outlineWidth = 25,
	fight_special = 7,
	skills = 10,
	effectHangPoint = 20,
	noDeadEffect = 18,
	des = 4,
	focusOffset = 16,
	effect = 19,
	matId = 13,
	topuiOffset = 15,
	headIcon = 11,
	flipX = 8,
	canHide = 21,
	colorbg = 5,
	showTemplate = 17,
	id = 1,
	floatOffset = 23
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	des = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
