module("modules.configs.excel2json.lua_block_package", package.seeall)

slot1 = {
	blockBuildDegree = 12,
	name = 2,
	useDesc = 3,
	free = 11,
	sources = 10,
	showOnly = 13,
	rare = 7,
	desc = 4,
	sourcesType = 9,
	id = 1,
	icon = 5,
	rewardIcon = 6,
	nameEn = 8
}
slot2 = {
	"id"
}
slot3 = {
	name = 1,
	useDesc = 2,
	desc = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
