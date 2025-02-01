module("modules.configs.excel2json.lua_weekwalk_bonus", package.seeall)

slot1 = {
	bonusId = 3,
	bonusGroup = 1,
	bonus = 2
}
slot2 = {
	"bonusGroup"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
