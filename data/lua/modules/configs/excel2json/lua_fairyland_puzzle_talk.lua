module("modules.configs.excel2json.lua_fairyland_puzzle_talk", package.seeall)

slot1 = {
	param = 4,
	audioId = 5,
	speaker = 6,
	type = 3,
	id = 1,
	elementId = 8,
	content = 7,
	step = 2
}
slot2 = {
	"id",
	"step"
}
slot3 = {
	speaker = 1,
	content = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
