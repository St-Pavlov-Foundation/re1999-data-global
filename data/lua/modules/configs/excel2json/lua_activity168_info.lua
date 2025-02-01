module("modules.configs.excel2json.lua_activity168_info", package.seeall)

slot1 = {
	clueNumber = 6,
	name = 3,
	infoId = 1,
	icon = 4,
	episode = 2,
	desc = 5
}
slot2 = {
	"infoId"
}
slot3 = {
	desc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
