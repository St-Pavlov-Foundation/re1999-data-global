module("modules.configs.excel2json.lua_bp", package.seeall)

slot1 = {
	isSp = 16,
	name = 7,
	chargeId2 = 3,
	bpSkinEnNametxt = 12,
	bpviewicon = 13,
	payStatus1Bonus = 5,
	bpId = 1,
	chargeId1 = 2,
	chargeId1to2 = 4,
	bpviewpos = 14,
	showBonus = 15,
	weekLimitTimes = 17,
	bpSkinDesc = 10,
	bpSkinNametxt = 11,
	expLevelUp = 9,
	payStatus2Bonus = 6,
	payStatus2AddLevel = 8,
	expUpShow = 18
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
