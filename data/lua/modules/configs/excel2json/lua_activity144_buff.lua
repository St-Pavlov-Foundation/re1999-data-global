module("modules.configs.excel2json.lua_activity144_buff", package.seeall)

slot1 = {
	effectParam = 5,
	effectType = 4,
	buffId = 2,
	type = 3,
	effectDesc = 6,
	reduction = 7,
	activityId = 1
}
slot2 = {
	"activityId",
	"buffId"
}
slot3 = {
	effectDesc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
