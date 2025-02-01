module("modules.configs.excel2json.lua_dialog_group", package.seeall)

slot1 = {
	dialogue_id = 1,
	id = 2
}
slot2 = {
	"dialogue_id",
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
