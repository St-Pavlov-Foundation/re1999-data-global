module("modules.configs.excel2json.lua_task_activity123_fight", package.seeall)

slot1 = {
	fightId = 3,
	seasonId = 2,
	params = 5,
	id = 1,
	desc = 4
}
slot2 = {
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
