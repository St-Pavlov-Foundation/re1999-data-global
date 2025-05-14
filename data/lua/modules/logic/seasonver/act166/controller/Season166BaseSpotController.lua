module("modules.logic.seasonver.act166.controller.Season166BaseSpotController", package.seeall)

local var_0_0 = class("Season166BaseSpotController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.enterBaseSpotFightScene(arg_3_0, arg_3_1)
	local var_3_0 = Season166BaseSpotModel.instance.curEpisodeId

	if var_3_0 then
		arg_3_0:startBattle(arg_3_1.actId, var_3_0)
	end
end

function var_0_0.startBattle(arg_4_0, arg_4_1, arg_4_2)
	logNormal(string.format("startBattle with actId = %s, episodeId = %s", arg_4_1, arg_4_2))

	local var_4_0 = DungeonConfig.instance:getEpisodeCO(arg_4_2)
	local var_4_1 = Season166BaseSpotModel.instance.curBaseSpotId
	local var_4_2 = Season166BaseSpotModel.instance.talentId

	Season166Model.instance:setBattleContext(arg_4_1, arg_4_2, var_4_1, var_4_2)
	DungeonFightController.instance:enterSeasonFight(var_4_0.chapterId, arg_4_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
