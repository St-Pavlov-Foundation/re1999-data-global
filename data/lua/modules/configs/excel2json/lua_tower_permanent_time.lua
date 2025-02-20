module("modules.configs.excel2json.lua_tower_permanent_time", package.seeall)

slot1 = {
	stageId = 1,
	name = 3,
	time = 2,
	nameEn = 4
}
slot2 = {
	"stageId"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
