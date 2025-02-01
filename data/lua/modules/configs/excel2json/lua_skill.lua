module("modules.configs.excel2json.lua_skill", package.seeall)

slot1 = {
	icon = 4,
	name = 2,
	desc_art = 5,
	timeline = 3,
	preFxId = 14,
	notDoAction = 10,
	bloomParams = 12,
	activeTargetFrameEvent = 13,
	eff_desc = 6,
	heroId = 15,
	battleTag = 7,
	id = 1,
	skillEffect = 8,
	showInBattle = 11,
	skillRank = 9
}
slot2 = {
	"id"
}
slot3 = {
	desc_art = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
