module("modules.logic.seasonver.act166.model.Season166BattleContext", package.seeall)

local var_0_0 = pureTable("Season166BattleContext")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	arg_1_0.actId = arg_1_1
	arg_1_0.episodeId = arg_1_2
	arg_1_0.baseId = arg_1_3
	arg_1_0.talentId = arg_1_4
	arg_1_0.trainId = arg_1_5
	arg_1_0.teachId = arg_1_6

	local var_1_0 = lua_episode.configDict[arg_1_0.episodeId]

	arg_1_0.episodeType = var_1_0 and var_1_0.type
	arg_1_0.battleId = var_1_0 and var_1_0.battleId
end

return var_0_0
