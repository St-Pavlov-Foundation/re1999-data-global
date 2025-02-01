module("modules.configs.excel2json.lua_log_room_character", package.seeall)

slot1 = {
	id = 1,
	upTime = 3,
	tag = 4,
	logkind = 2,
	content = 5
}
slot2 = {
	"id"
}
slot3 = {
	content = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
