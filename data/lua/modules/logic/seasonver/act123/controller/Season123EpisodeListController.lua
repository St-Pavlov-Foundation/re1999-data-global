module("modules.logic.seasonver.act123.controller.Season123EpisodeListController", package.seeall)

local var_0_0 = class("Season123EpisodeListController", BaseController)

function var_0_0.onOpenView(arg_1_0, arg_1_1, arg_1_2)
	Season123Controller.instance:registerCallback(Season123Event.GetActInfo, arg_1_0.handleGetActInfo, arg_1_0)
	Season123Controller.instance:registerCallback(Season123Event.GetActInfoBattleFinish, arg_1_0.handleGetActInfo, arg_1_0)
	Season123Controller.instance:registerCallback(Season123Event.ResetStageFinished, arg_1_0.handleResetStageFinished, arg_1_0)
	Season123Controller.instance:registerCallback(Season123Event.OnResetSucc, arg_1_0.fixCurSelectedUnlock, arg_1_0)
	Season123EpisodeListModel.instance:init(arg_1_1, arg_1_2)
	Season123Controller.instance:checkAndHandleEffectEquip({
		actId = arg_1_1,
		stage = arg_1_2
	})
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Season123
	})
end

function var_0_0.onCloseView(arg_2_0)
	Season123Controller.instance:unregisterCallback(Season123Event.GetActInfo, arg_2_0.handleGetActInfo, arg_2_0)
	Season123Controller.instance:unregisterCallback(Season123Event.GetActInfoBattleFinish, arg_2_0.handleGetActInfo, arg_2_0)
	Season123Controller.instance:unregisterCallback(Season123Event.ResetStageFinished, arg_2_0.handleResetStageFinished, arg_2_0)
	Season123Controller.instance:unregisterCallback(Season123Event.OnResetSucc, arg_2_0.fixCurSelectedUnlock, arg_2_0)
	Season123EpisodeListModel.instance:release()
	Season123EpisodeRewardModel.instance:release()
end

function var_0_0.processJumpParam(arg_3_0, arg_3_1)
	if arg_3_1.jumpId == Activity123Enum.JumpId.Market then
		local var_3_0 = arg_3_1.jumpParam.tarLayer

		arg_3_0:setSelectLayer(var_3_0)

		if Season123EpisodeListModel.instance.activityId == Activity123Enum.SeasonID.Season1 and arg_3_1.stage == 1 and var_3_0 and var_3_0 == 2 then
			return
		end

		arg_3_0:enterEpisode()
	elseif arg_3_1.jumpId == Activity123Enum.JumpId.MarketNoResult then
		local var_3_1 = arg_3_1.jumpParam.tarLayer

		ViewMgr.instance:openView(Season123Controller.instance:getEpisodeMarketViewName(), {
			actId = Season123EpisodeListModel.instance.activityId,
			stage = Season123EpisodeListModel.instance.stage,
			layer = var_3_1
		})
	end
end

function var_0_0.handleGetActInfo(arg_4_0, arg_4_1)
	if arg_4_1 ~= Season123EpisodeListModel.instance.activityId then
		return
	end

	Season123EpisodeListModel.instance:initEpisodeList()

	if not arg_4_0:fixCurSelectedUnlock() then
		arg_4_0:notifyView()
	end
end

function var_0_0.handlePickHeroSuccess(arg_5_0)
	local var_5_0 = Season123EpisodeListModel.instance.activityId

	Activity123Rpc.instance:sendGet123InfosRequest(var_5_0, arg_5_0.handleEnterStage, arg_5_0)
end

function var_0_0.handleEnterStage(arg_6_0)
	arg_6_0:notifyView()
end

function var_0_0.handleResetStageFinished(arg_7_0)
	local var_7_0 = Season123EpisodeListModel.instance.activityId

	Activity123Rpc.instance:sendGet123InfosRequest(var_7_0, arg_7_0.handleGet123InfosAfterRest, arg_7_0)
	Season123Controller.instance:dispatchEvent(Season123Event.ResetCloseEpisodeList)
	Season123ShowHeroModel.instance:clearPlayHeroDieAnim(Season123EpisodeListModel.instance.stage)
end

function var_0_0.handleGet123InfosAfterRest(arg_8_0)
	var_0_0.instance:setSelectLayer(1)
	arg_8_0:notifyView()
end

function var_0_0.fixCurSelectedUnlock(arg_9_0)
	local var_9_0 = Season123EpisodeListModel.instance.curSelectLayer
	local var_9_1 = Season123EpisodeListModel.instance:getCurrentChallengeLayer()

	if var_9_1 < var_9_0 then
		arg_9_0:setSelectLayer(var_9_1)

		return true
	end

	return false
end

function var_0_0.openDetails(arg_10_0)
	EnemyInfoController.instance:openSeason123EnemyInfoView(Season123EpisodeListModel.instance.activityId, Season123EpisodeListModel.instance.stage, Season123EpisodeListModel.instance:getCurrentChallengeLayer())
end

function var_0_0.enterEpisode(arg_11_0, arg_11_1)
	local var_11_0 = Season123EpisodeListModel.instance.curSelectLayer

	if not var_11_0 then
		return
	end

	local var_11_1 = Season123EpisodeListModel.instance:getById(var_11_0)

	if not var_11_1 then
		return
	end

	local var_11_2 = Season123EpisodeListModel.instance.activityId

	var_0_0.instance:setSelectLayer(var_11_0)

	local var_11_3 = Season123EpisodeListModel.instance.stage

	if Season123EpisodeListModel.instance:isEpisodeUnlock(var_11_0) then
		logNormal("open layer = " .. tostring(var_11_0))

		if arg_11_1 and (var_11_0 ~= 1 or var_11_1.isFinished or not Season123EpisodeListModel.instance:isLoadingAnimNeedPlay(var_11_3)) then
			ViewMgr.instance:openView(Season123Controller.instance:getEpisodeMarketViewName(), {
				actId = var_11_2,
				stage = var_11_3,
				layer = var_11_0
			})
		else
			Season123EpisodeListModel.instance:savePlayLoadingAnimRecord(var_11_3)
			ViewMgr.instance:openView(Season123Controller.instance:getEpisodeLoadingViewName(), {
				actId = var_11_2,
				stage = var_11_3,
				layer = var_11_0
			})
		end
	else
		logNormal(string.format("layer [%s] is lock!!!!", tostring(var_11_0)))
	end
end

function var_0_0.setSelectLayer(arg_12_0, arg_12_1)
	Season123EpisodeListModel.instance:setSelectLayer(arg_12_1)
	arg_12_0:notifyView()
end

function var_0_0.notifyView(arg_13_0)
	Season123Controller.instance:dispatchEvent(Season123Event.EpisodeViewRefresh)
end

function var_0_0.onReceiveEnterStage(arg_14_0, arg_14_1)
	Season123EpisodeListModel.instance:cleanPlayLoadingAnimRecord(arg_14_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
