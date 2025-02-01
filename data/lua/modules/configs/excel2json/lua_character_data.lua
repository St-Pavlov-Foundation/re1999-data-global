module("modules.configs.excel2json.lua_character_data", package.seeall)

slot1 = {
	skinId = 3,
	lockText = 11,
	unlockConditine = 12,
	type = 4,
	isCustom = 14,
	title = 6,
	unlockRewards = 13,
	number = 5,
	text = 8,
	heroId = 1,
	titleEn = 7,
	id = 2,
	icon = 9,
	estimate = 10
}
slot2 = {
	"heroId",
	"id"
}
slot3 = {
	text = 2,
	title = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
