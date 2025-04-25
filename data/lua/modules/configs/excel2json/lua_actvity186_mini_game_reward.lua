module("modules.configs.excel2json.lua_actvity186_mini_game_reward", package.seeall)

slot1 = {
	rewardId = 2,
	blessingdes = 6,
	type = 1,
	blessingtitle = 5,
	prob = 3,
	bonus = 4
}
slot2 = {
	"type",
	"rewardId"
}
slot3 = {
	blessingtitle = 1,
	blessingdes = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
