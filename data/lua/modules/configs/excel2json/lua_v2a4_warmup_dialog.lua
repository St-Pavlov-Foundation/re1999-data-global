module("modules.configs.excel2json.lua_v2a4_warmup_dialog", package.seeall)

slot1 = {
	fmt1 = 5,
	fmt3 = 7,
	fmt2 = 6,
	nextId = 4,
	group = 2,
	desc = 3,
	id = 1,
	fmt5 = 9,
	fmt4 = 8
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
