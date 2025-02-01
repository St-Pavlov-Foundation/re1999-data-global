module("modules.configs.excel2json.lua_skill_role_mapping", package.seeall)

slot1 = {
	heroId = 2,
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
