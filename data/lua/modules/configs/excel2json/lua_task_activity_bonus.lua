module("modules.configs.excel2json.lua_task_activity_bonus", package.seeall)

slot1 = {
	hideInVerifing = 6,
	bonus = 5,
	desc = 3,
	type = 1,
	id = 2,
	needActivity = 4
}
slot2 = {
	"type",
	"id"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
