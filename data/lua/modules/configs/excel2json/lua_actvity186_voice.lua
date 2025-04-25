module("modules.configs.excel2json.lua_actvity186_voice", package.seeall)

slot1 = {
	jpmouth = 36,
	name = 4,
	frmotion = 24,
	type = 8,
	motion = 18,
	unlockCondition = 5,
	thaiface = 33,
	jpcontent = 13,
	thaicontent = 17,
	komotion = 22,
	enface = 29,
	displayTime = 42,
	twface = 27,
	decontent = 15,
	twmouth = 35,
	show = 7,
	twcontent = 12,
	face = 26,
	frcontent = 16,
	koface = 30,
	enmouth = 37,
	demouth = 39,
	encontent = 11,
	thaimouth = 41,
	param = 9,
	kocontent = 14,
	twmotion = 19,
	id = 1,
	jpface = 28,
	komouth = 38,
	frmouth = 40,
	frface = 32,
	demotion = 23,
	content = 10,
	thaimotion = 25,
	mouth = 34,
	jpmotion = 20,
	sortId = 3,
	deface = 31,
	time = 6,
	audio = 2,
	enmotion = 21,
	viewEffect = 43
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
