module("modules.configs.excel2json.lua_rouge_unlock_skills", package.seeall)

slot1 = {
	unlockEmblem = 5,
	style = 2,
	type = 4,
	skillId = 1,
	version = 3
}
slot2 = {
	"skillId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
