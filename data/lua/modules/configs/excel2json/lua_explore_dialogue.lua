module("modules.configs.excel2json.lua_explore_dialogue", package.seeall)

slot1 = {
	refuseButton = 8,
	bonusButton = 9,
	selectButton = 10,
	audio = 5,
	picture = 11,
	interrupt = 3,
	desc = 6,
	speaker = 4,
	id = 1,
	acceptButton = 7,
	stepid = 2
}
slot2 = {
	"id",
	"stepid"
}
slot3 = {
	refuseButton = 4,
	speaker = 1,
	bonusButton = 5,
	selectButton = 6,
	acceptButton = 3,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
