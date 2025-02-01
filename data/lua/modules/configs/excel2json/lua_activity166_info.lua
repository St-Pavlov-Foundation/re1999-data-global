module("modules.configs.excel2json.lua_activity166_info", package.seeall)

slot1 = {
	initContent = 10,
	name = 6,
	reportRes = 8,
	unlockParam = 4,
	infoId = 2,
	reportPic = 9,
	unlockType = 3,
	unlockDes = 5,
	activityId = 1,
	nameEn = 7
}
slot2 = {
	"activityId",
	"infoId"
}
slot3 = {
	initContent = 3,
	name = 2,
	unlockDes = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
