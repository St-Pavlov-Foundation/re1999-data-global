module("modules.configs.excel2json.lua_fight_skin_replace_magic_effect", package.seeall)

slot1 = {
	closeEffect = 7,
	enterTime = 4,
	skinId = 2,
	closeTime = 8,
	enterEffect = 3,
	enterAudio = 5,
	posArr = 11,
	loopEffect = 6,
	id = 1,
	closeAudio = 10,
	closeAniName = 9
}
slot2 = {
	"id",
	"skinId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
