module("modules.configs.excel2json.lua_monster_skin", package.seeall)

slot1 = {
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
slot2 = {
	"id"
}
slot3 = {
	des = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
