module("modules.configs.excel2json.lua_eliminate_dialog", package.seeall)

slot1 = {
	auto = 5,
	dialogSeq = 2,
	id = 1,
	dialogId = 3,
	trigger = 4
}
slot2 = {
	"id",
	"dialogSeq"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
