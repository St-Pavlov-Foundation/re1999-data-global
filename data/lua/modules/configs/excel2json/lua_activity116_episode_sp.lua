module("modules.configs.excel2json.lua_activity116_episode_sp", package.seeall)

slot1 = {
	endShow = 5,
	id = 1,
	title = 3,
	refreshDay = 2,
	desc = 4
}
slot2 = {
	"id"
}
slot3 = {
	endShow = 3,
	title = 1,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
