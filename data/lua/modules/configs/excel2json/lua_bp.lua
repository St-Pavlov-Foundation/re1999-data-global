module("modules.configs.excel2json.lua_bp", package.seeall)

slot1 = {
	isSp = 16,
	name = 7,
	chargeId2 = 3,
	bpSkinDesc = 10,
	bpSkinNametxt = 11,
	bpSkinEnNametxt = 12,
	expLevelUp = 9,
	payStatus1Bonus = 5,
	bpviewicon = 13,
	bpId = 1,
	chargeId1 = 2,
	bpviewpos = 14,
	chargeId1to2 = 4,
	payStatus2Bonus = 6,
	payStatus2AddLevel = 8,
	showBonus = 15
}
slot2 = {
	"bpId"
}
slot3 = {
	bpSkinNametxt = 3,
	name = 1,
	bpSkinDesc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
