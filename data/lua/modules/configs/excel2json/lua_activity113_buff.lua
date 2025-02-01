module("modules.configs.excel2json.lua_activity113_buff", package.seeall)

slot1 = {
	cost = 7,
	name = 3,
	buffId = 2,
	taskId = 8,
	bigIcon = 10,
	desc = 4,
	preBuffId = 6,
	skillId = 5,
	id = 1,
	icon = 9
}
slot2 = {
	"id",
	"buffId"
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
