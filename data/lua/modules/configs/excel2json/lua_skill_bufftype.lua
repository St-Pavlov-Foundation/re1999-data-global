module("modules.configs.excel2json.lua_skill_bufftype", package.seeall)

slot1 = {
	removeNum = 10,
	skipDelay = 11,
	dontShowFloat = 9,
	type = 2,
	includeTypes = 4,
	takeStage = 6,
	cannotRemove = 8,
	excludeTypes = 5,
	group = 3,
	takeAct = 7,
	matSort = 12,
	aniSort = 13,
	id = 1,
	playEffect = 14
}
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
