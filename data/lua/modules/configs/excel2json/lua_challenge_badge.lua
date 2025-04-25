module("modules.configs.excel2json.lua_challenge_badge", package.seeall)

slot1 = {
	rule = 3,
	unlockSupport = 5,
	num = 2,
	activityId = 1,
	decs = 4
}
slot2 = {
	"activityId",
	"num"
}
slot3 = {
	decs = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
