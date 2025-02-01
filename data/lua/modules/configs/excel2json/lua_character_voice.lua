module("modules.configs.excel2json.lua_character_voice", package.seeall)

slot1 = {
	jpmouth = 40,
	name = 4,
	thaicontent = 21,
	type = 10,
	heroId = 1,
	unlockCondition = 6,
	thaiface = 37,
	jpcontent = 17,
	krmotion = 26,
	frcontent = 20,
	param = 11,
	displayTime = 46,
	twface = 31,
	skins = 5,
	addaudio = 13,
	show = 9,
	twcontent = 16,
	face = 30,
	frmotion = 28,
	enface = 33,
	content = 14,
	twmouth = 39,
	encontent = 15,
	param2 = 12,
	enmouth = 41,
	kocontent = 18,
	twmotion = 23,
	demouth = 43,
	thaimouth = 45,
	jpface = 32,
	motion = 22,
	frmouth = 44,
	frface = 36,
	demotion = 27,
	decontent = 19,
	krmouth = 42,
	thaimotion = 29,
	mouth = 38,
	jpmotion = 24,
	sortId = 3,
	deface = 35,
	time = 8,
	audio = 2,
	enmotion = 25,
	stateCondition = 7,
	krface = 34
}
slot2 = {
	"heroId",
	"audio"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
