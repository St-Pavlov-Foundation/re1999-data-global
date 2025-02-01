module("modules.configs.excel2json.lua_activity163_evidence", package.seeall)

slot1 = {
	evidenceId = 1,
	showFusion = 7,
	tips = 6,
	errorTip = 5,
	conditionStr = 4,
	puzzleTxt = 3,
	dialogGroupType = 2
}
slot2 = {
	"evidenceId"
}
slot3 = {
	conditionStr = 2,
	puzzleTxt = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
