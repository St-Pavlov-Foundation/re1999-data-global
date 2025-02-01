module("modules.configs.excel2json.lua_instruction_level", package.seeall)

slot1 = {
	picRes = 7,
	desc = 6,
	topicId = 2,
	instructionDesc = 4,
	id = 1,
	desc_en = 5,
	preEpisode = 8,
	episodeId = 3
}
slot2 = {
	"id"
}
slot3 = {
	desc = 2,
	instructionDesc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
