module("modules.configs.excel2json.lua_dialog_step", package.seeall)

slot1 = {
	id = 2,
	name = 5,
	avatar = 6,
	type = 3,
	groupId = 1,
	chessId = 7,
	content = 4
}
slot2 = {
	"groupId",
	"id"
}
slot3 = {
	content = 1,
	name = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
