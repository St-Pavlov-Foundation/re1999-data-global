module("modules.configs.excel2json.lua_bgm_switch", package.seeall)

slot1 = {
	itemId = 5,
	audioIntroduce = 9,
	audioNameEn = 8,
	audio = 2,
	audioName = 7,
	unlockCondition = 4,
	audioicon = 11,
	sort = 12,
	audioType = 13,
	isNonLoop = 16,
	isReport = 3,
	audioBg = 10,
	id = 1,
	audioEvaluates = 15,
	audioLength = 14,
	defaultUnlock = 6
}
slot2 = {
	"id"
}
slot3 = {
	audioIntroduce = 2,
	audioEvaluates = 3,
	audioName = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
