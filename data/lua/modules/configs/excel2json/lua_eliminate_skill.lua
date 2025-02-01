module("modules.configs.excel2json.lua_eliminate_skill", package.seeall)

slot1 = {
	skillDes = 3,
	skillName = 2,
	skillId = 1
}
slot2 = {
	"skillId"
}
slot3 = {
	skillDes = 2,
	skillName = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
