module("modules.configs.excel2json.lua_fairyland_text", package.seeall)

slot1 = {
	id = 1,
	node = 4,
	question = 2,
	answer = 3
}
slot2 = {
	"id"
}
slot3 = {
	question = 1,
	answer = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
