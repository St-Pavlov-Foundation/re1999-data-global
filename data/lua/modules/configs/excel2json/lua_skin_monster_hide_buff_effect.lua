module("modules.configs.excel2json.lua_skin_monster_hide_buff_effect", package.seeall)

slot1 = {
	effectName = 2,
	exceptEffect = 3,
	skillId = 1
}
slot2 = {
	"skillId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
