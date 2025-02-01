module("modules.configs.excel2json.lua_rouge_special_trigger", package.seeall)

slot1 = {
	eventCorrectWeight = 4,
	unlockTask = 8,
	reasonRange = 3,
	name = 2,
	eventGroupCorrectWeight = 5,
	shopGroupCorrectWeight = 6,
	inPictorial = 9,
	dropGroupCorrectWeight = 7,
	id = 1,
	isShow = 10
}
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
