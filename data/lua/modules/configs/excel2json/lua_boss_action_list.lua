module("modules.configs.excel2json.lua_boss_action_list", package.seeall)

slot1 = {
	actionId = 1,
	actionId3 = 5,
	actionId7 = 9,
	actionId4 = 6,
	actionId10 = 12,
	actionId5 = 7,
	actionId6 = 8,
	circle = 2,
	actionId8 = 10,
	actionId1 = 3,
	actionId9 = 11,
	actionId2 = 4
}
slot2 = {
	"actionId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
