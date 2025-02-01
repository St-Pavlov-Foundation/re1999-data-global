module("modules.configs.excel2json.lua_luckybag_summon_pool_detail", package.seeall)

slot1 = {
	order = 6,
	name = 4,
	openId = 7,
	historyShowType = 5,
	id = 1,
	info = 3,
	desc = 2
}
slot2 = {
	"id"
}
slot3 = {
	info = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
