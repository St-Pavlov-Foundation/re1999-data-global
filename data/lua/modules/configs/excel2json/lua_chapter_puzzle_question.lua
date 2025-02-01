module("modules.configs.excel2json.lua_chapter_puzzle_question", package.seeall)

slot1 = {
	descEn = 5,
	answer = 9,
	question = 8,
	questionTitle = 6,
	title = 2,
	questionTitleEn = 7,
	desc = 4,
	titleEn = 3,
	id = 1
}
slot2 = {
	"id"
}
slot3 = {
	answer = 5,
	question = 4,
	questionTitle = 3,
	title = 1,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
