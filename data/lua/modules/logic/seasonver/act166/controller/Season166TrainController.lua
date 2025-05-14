module("modules.logic.seasonver.act166.controller.Season166TrainController", package.seeall)

local var_0_0 = class("Season166TrainController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.enterTrainFightScene(arg_3_0)
	local var_3_0 = Season166Model.instance:getCurSeasonId()
	local var_3_1 = Season166TrainModel.instance.curEpisodeId

	if var_3_1 then
		arg_3_0:startBattle(var_3_0, var_3_1)
	end
end

function var_0_0.startBattle(arg_4_0, arg_4_1, arg_4_2)
	logNormal(string.format("startBattle with actId = %s, episodeId = %s", arg_4_1, arg_4_2))

	local var_4_0 = DungeonConfig.instance:getEpisodeCO(arg_4_2)
	local var_4_1 = Season166TrainModel.instance.curTrainId
	local var_4_2 = Season166Model.getPrefsTalent()

	Season166Model.instance:setBattleContext(arg_4_1, arg_4_2, nil, var_4_2, var_4_1)
	DungeonFightController.instance:enterSeasonFight(var_4_0.chapterId, arg_4_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
