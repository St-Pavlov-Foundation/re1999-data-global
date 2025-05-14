module("modules.logic.seasonver.act123.controller.Season123EpisodeDetailController", package.seeall)

local var_0_0 = class("Season123EpisodeDetailController", BaseController)

function var_0_0.onOpenView(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	Season123Controller.instance:registerCallback(Season123Event.StartEnterBattle, arg_1_0.handleStartEnterBattle, arg_1_0)
	Season123Controller.instance:registerCallback(Season123Event.StageInfoChanged, arg_1_0.handleDataChanged, arg_1_0)
	Season123Controller.instance:registerCallback(Season123Event.GetActInfo, arg_1_0.handleDataChanged, arg_1_0)
	Season123Controller.instance:registerCallback(Season123Event.OnResetSucc, arg_1_0.handleDataChanged, arg_1_0)
	Season123EpisodeDetailModel.instance:init(arg_1_1, arg_1_2, arg_1_3)
	Season123Controller.instance:checkAndHandleEffectEquip({
		actId = arg_1_1,
		stage = arg_1_2,
		layer = arg_1_3
	})
end

function var_0_0.onCloseView(arg_2_0)
	Season123Controller.instance:unregisterCallback(Season123Event.StartEnterBattle, arg_2_0.handleStartEnterBattle, arg_2_0)
	Season123Controller.instance:unregisterCallback(Season123Event.StageInfoChanged, arg_2_0.handleDataChanged, arg_2_0)
	Season123Controller.instance:unregisterCallback(Season123Event.GetActInfo, arg_2_0.handleDataChanged, arg_2_0)
	Season123Controller.instance:unregisterCallback(Season123Event.OnResetSucc, arg_2_0.handleDataChanged, arg_2_0)
	Season123EpisodeDetailModel.instance:release()
end

function var_0_0.canSwitchLayer(arg_3_0, arg_3_1)
	local var_3_0 = Season123EpisodeDetailModel.instance.layer

	if arg_3_1 then
		local var_3_1 = var_3_0 + 1

		if not Season123EpisodeDetailModel.instance:isEpisodeUnlock(var_3_1) then
			return false
		end
	elseif var_3_0 < 2 then
		return false
	end

	return true
end

function var_0_0.switchLayer(arg_4_0, arg_4_1)
	local var_4_0 = Season123EpisodeDetailModel.instance.layer
	local var_4_1 = arg_4_1 and var_4_0 + 1 or var_4_0 - 1

	Season123EpisodeDetailModel.instance.layer = var_4_1

	Season123Controller.instance:dispatchEvent(Season123Event.DetailSwitchLayer, {
		isNext = arg_4_1
	})
end

function var_0_0.checkEnterFightScene(arg_5_0)
	if arg_5_0:isStageNeedClean() then
		GameFacade.showMessageBox(MessageBoxIdDefine.Season123WarningCleanStage, MsgBoxEnum.BoxType.Yes_No, arg_5_0.checkCleanNextLayers, nil, nil, arg_5_0, nil, nil)

		return
	end

	arg_5_0:checkCleanNextLayers()
end

function var_0_0.checkCleanNextLayers(arg_6_0)
	if arg_6_0:isNextLayersNeedClean() then
		GameFacade.showMessageBox(MessageBoxIdDefine.Season123WarningCleanLayer, MsgBoxEnum.BoxType.Yes_No, arg_6_0.enterFightScene, nil, nil, arg_6_0, nil, nil)

		return
	end

	arg_6_0:enterFightScene()
end

function var_0_0.isStageNeedClean(arg_7_0)
	local var_7_0 = Season123EpisodeDetailModel.instance.activityId
	local var_7_1 = Season123EpisodeDetailModel.instance.stage
	local var_7_2 = Season123Model.instance:getActInfo(var_7_0)

	if not var_7_2 then
		return false
	end

	return var_7_2.stage ~= 0 and var_7_2.stage ~= var_7_1
end

function var_0_0.isNextLayersNeedClean(arg_8_0)
	local var_8_0 = Season123EpisodeDetailModel.instance.activityId
	local var_8_1 = Season123EpisodeDetailModel.instance.stage
	local var_8_2 = Season123EpisodeDetailModel.instance.layer
	local var_8_3 = Season123Model.instance:getActInfo(var_8_0)

	if not var_8_3 then
		return false
	end

	local var_8_4 = var_8_3.stageMap[var_8_1]

	if not var_8_4 or not var_8_4.episodeMap then
		return false
	end

	for iter_8_0, iter_8_1 in pairs(var_8_4.episodeMap) do
		if var_8_2 <= iter_8_1.layer and iter_8_1:isFinished() then
			return true
		end
	end

	return false
end

function var_0_0.enterFightScene(arg_9_0)
	local var_9_0 = Season123EpisodeDetailModel.instance.activityId
	local var_9_1 = Season123EpisodeDetailModel.instance.stage
	local var_9_2 = Season123EpisodeDetailModel.instance.layer

	if arg_9_0:isStageNeedClean() then
		Activity123Rpc.instance:sendAct123ResetOtherStageRequest(var_9_0, var_9_1, arg_9_0.handleResetOtherStage, arg_9_0)

		return
	end

	arg_9_0:handleResetOtherStage()
end

function var_0_0.handleResetOtherStage(arg_10_0)
	local var_10_0 = Season123EpisodeDetailModel.instance.activityId
	local var_10_1 = Season123EpisodeDetailModel.instance.stage
	local var_10_2 = Season123EpisodeDetailModel.instance.layer
	local var_10_3 = Season123Model.instance:getActInfo(var_10_0)

	if not var_10_3 then
		return
	end

	local var_10_4 = var_10_3:getStageMO(var_10_1)

	if not var_10_4 then
		return
	end

	if var_10_4.episodeMap[var_10_2 + 1] and var_10_4.episodeMap[var_10_2 + 1]:isFinished() then
		Activity123Rpc.instance:sendAct123ResetHighLayerRequest(var_10_0, var_10_1, var_10_2, arg_10_0.enterBattle, arg_10_0)

		return
	end

	arg_10_0:enterBattle()
end

function var_0_0.enterBattle(arg_11_0)
	local var_11_0 = Season123EpisodeDetailModel.instance.activityId
	local var_11_1 = Season123EpisodeDetailModel.instance.stage
	local var_11_2 = Season123EpisodeDetailModel.instance.layer
	local var_11_3 = Season123Config.instance:getSeasonEpisodeCo(var_11_0, var_11_1, var_11_2)

	if var_11_3 then
		Season123EpisodeDetailModel.instance.lastSendEpisodeCfg = var_11_3

		local var_11_4 = Season123EpisodeDetailModel.instance:getByIndex(var_11_2).cfg.episodeId

		arg_11_0:startBattle(var_11_0, var_11_1, var_11_2, var_11_3.episodeId)
	end
end

function var_0_0.startBattle(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	logNormal(string.format("startBattle with actId = %s, stage = %s, layer = %s, episodeId = %s", arg_12_1, arg_12_2, arg_12_3, arg_12_4))

	local var_12_0 = DungeonConfig.instance:getEpisodeCO(arg_12_4)

	Season123Model.instance:setBattleContext(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	DungeonFightController.instance:enterSeasonFight(var_12_0.chapterId, arg_12_4)
end

function var_0_0.handleStartEnterBattle(arg_13_0, arg_13_1)
	if not Season123EpisodeDetailModel.instance.lastSendEpisodeCfg then
		return
	end

	local var_13_0 = Season123EpisodeDetailModel.instance.lastSendEpisodeCfg
	local var_13_1 = arg_13_1.actId
	local var_13_2 = arg_13_1.layer

	if var_13_0 and var_13_1 == Season123EpisodeDetailModel.instance.activityId and var_13_2 == var_13_0.layer then
		local var_13_3 = DungeonConfig.instance:getEpisodeCO(var_13_0.episodeId)

		if var_13_3 then
			DungeonFightController.instance:enterSeasonFight(var_13_3.chapterId, var_13_3.id)
		else
			logError(string.format("episode cfg not found ! id = [%s]", var_13_0.episodeId))
		end
	end
end

function var_0_0.handleDataChanged(arg_14_0)
	local var_14_0 = Season123EpisodeDetailModel.instance.layer

	Season123EpisodeDetailModel.instance:initEpisodeList()

	if not Season123EpisodeDetailModel.instance:isEpisodeUnlock(var_14_0) then
		for iter_14_0 = var_14_0, 1, -1 do
			if Season123EpisodeDetailModel.instance:isEpisodeUnlock(iter_14_0) then
				Season123EpisodeDetailModel.instance.layer = iter_14_0

				break
			end
		end
	end

	arg_14_0:notifyView()
end

function var_0_0.notifyView(arg_15_0)
	Season123Controller.instance:dispatchEvent(Season123Event.RefreshDetailView)
end

var_0_0.instance = var_0_0.New()

return var_0_0
