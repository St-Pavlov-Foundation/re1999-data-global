module("modules.logic.seasonver.act123.controller.Season123ResetController", package.seeall)

local var_0_0 = class("Season123ResetController", BaseController)

function var_0_0.onOpenView(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	Season123Controller.instance:registerCallback(Season123Event.GetActInfo, arg_1_0.handleGetActInfo, arg_1_0)
	Season123Controller.instance:registerCallback(Season123Event.StageInfoChanged, arg_1_0.handleStageInfoChange, arg_1_0)
	Season123ResetModel.instance:init(arg_1_1, arg_1_2, arg_1_3)
	Season123Controller.instance:checkAndHandleEffectEquip({
		actId = arg_1_1,
		stage = arg_1_2,
		layer = arg_1_3
	})
end

function var_0_0.onCloseView(arg_2_0)
	Season123Controller.instance:unregisterCallback(Season123Event.GetActInfo, arg_2_0.handleGetActInfo, arg_2_0)
	Season123Controller.instance:unregisterCallback(Season123Event.StageInfoChanged, arg_2_0.handleStageInfoChange, arg_2_0)
	Season123ResetModel.instance:release()
end

function var_0_0.selectLayer(arg_3_0, arg_3_1)
	if arg_3_1 == Season123ResetModel.instance.layer then
		return
	end

	if arg_3_1 == nil then
		Season123ResetModel.instance.layer = nil
	elseif arg_3_1 == Season123ResetModel.EmptySelect then
		Season123ResetModel.instance.layer = arg_3_1
	elseif Season123ResetModel.instance:getById(arg_3_1).isFinished then
		Season123ResetModel.instance.layer = arg_3_1
	else
		return
	end

	Season123ResetModel.instance:updateHeroList()
	arg_3_0:notifyView()

	return true
end

function var_0_0.tryReset(arg_4_0)
	if Season123ResetModel.instance.layer then
		if Season123ResetModel.instance.layer ~= Season123ResetModel.EmptySelect then
			arg_4_0:trySendResetLayer()
		end
	else
		arg_4_0:trySendResetStage()
	end
end

function var_0_0.trySendResetStage(arg_5_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Season123ResetConfirm, MsgBoxEnum.BoxType.Yes_No, arg_5_0.receiveResetStage, nil, nil, arg_5_0)
end

function var_0_0.receiveResetStage(arg_6_0)
	Activity123Rpc.instance:sendAct123EndStageRequest(Season123ResetModel.instance.activityId, Season123ResetModel.instance.stage, arg_6_0.receiveResetFinish, arg_6_0)
end

function var_0_0.trySendResetLayer(arg_7_0)
	local var_7_0 = Season123ResetModel.instance.stage

	if arg_7_0:isStageNeedClean(var_7_0) then
		GameFacade.showMessageBox(MessageBoxIdDefine.Season123WarningCleanStage, MsgBoxEnum.BoxType.Yes_No, arg_7_0.checkCleanNextLayers, nil, nil, arg_7_0, nil, nil)

		return
	end

	arg_7_0:checkCleanNextLayers()
end

function var_0_0.checkCleanNextLayers(arg_8_0)
	local var_8_0 = Season123ResetModel.instance.layer

	if arg_8_0:isNextLayersNeedClean(var_8_0) then
		GameFacade.showMessageBox(MessageBoxIdDefine.Season123WarningCleanLayer, MsgBoxEnum.BoxType.Yes_No, arg_8_0.startSendResetLayer, nil, nil, arg_8_0, nil, nil)

		return
	end

	arg_8_0:startSendResetLayer()
end

function var_0_0.startSendResetLayer(arg_9_0)
	local var_9_0 = Season123ResetModel.instance.activityId
	local var_9_1 = Season123ResetModel.instance.stage
	local var_9_2 = Season123ResetModel.instance.layer

	if arg_9_0:isStageNeedClean(var_9_1) then
		Activity123Rpc.instance:sendAct123ResetOtherStageRequest(var_9_0, var_9_1, arg_9_0.receiveResetOtherStage, arg_9_0)

		return
	end

	arg_9_0:handleResetOtherStage()
end

function var_0_0.receiveResetOtherStage(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_2 == 0 then
		arg_10_0:handleResetOtherStage()
	end
end

function var_0_0.handleResetOtherStage(arg_11_0)
	local var_11_0 = Season123ResetModel.instance.activityId
	local var_11_1 = Season123ResetModel.instance.stage
	local var_11_2 = Season123ResetModel.instance.layer
	local var_11_3 = Season123Model.instance:getActInfo(var_11_0)

	if not var_11_3 then
		return
	end

	local var_11_4 = var_11_3:getStageMO(var_11_1)

	if not var_11_4 then
		return
	end

	if var_11_4.episodeMap[var_11_2] and var_11_4.episodeMap[var_11_2]:isFinished() then
		Activity123Rpc.instance:sendAct123ResetHighLayerRequest(var_11_0, var_11_1, var_11_2, arg_11_0.receiveResetFinish, arg_11_0)

		return
	end

	arg_11_0:notifyResetFinish()
end

function var_0_0.receiveResetFinish(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_2 == 0 then
		arg_12_0:notifyResetFinish()
	end
end

function var_0_0.notifyResetFinish(arg_13_0)
	GameFacade.showToast(ToastEnum.WeekwalkResetLayer)
	Activity123Rpc.instance:sendGet123InfosRequest(Season123ResetModel.instance.activityId)
	Season123Controller.instance:dispatchEvent(Season123Event.OnResetSucc)
end

function var_0_0.handleGetActInfo(arg_14_0)
	arg_14_0:updateModel()
end

function var_0_0.handleStageInfoChange(arg_15_0)
	arg_15_0:updateModel()
end

function var_0_0.updateModel(arg_16_0)
	local var_16_0 = Season123ResetModel.instance.layer

	Season123ResetModel.instance:initEpisodeList()

	if var_16_0 and not Season123ResetModel.instance:getById(var_16_0).isFinished then
		Season123ResetModel.instance.layer = Season123ResetModel.instance:getCurrentChallengeLayer()
	end

	Season123ResetModel.instance:updateHeroList()
	arg_16_0:notifyView()
end

function var_0_0.isStageNeedClean(arg_17_0, arg_17_1)
	local var_17_0 = Season123ResetModel.instance.activityId
	local var_17_1 = Season123ResetModel.instance.stage
	local var_17_2 = Season123Model.instance:getActInfo(var_17_0)

	if not var_17_2 then
		return false
	end

	return var_17_2.stage ~= 0 and var_17_2.stage ~= arg_17_1
end

function var_0_0.isNextLayersNeedClean(arg_18_0, arg_18_1)
	local var_18_0 = Season123ResetModel.instance.activityId
	local var_18_1 = Season123ResetModel.instance.stage
	local var_18_2 = Season123Model.instance:getActInfo(var_18_0)

	if not var_18_2 then
		return false
	end

	local var_18_3 = var_18_2.stageMap[var_18_1]

	if not var_18_3 or not var_18_3.episodeMap then
		return false
	end

	for iter_18_0, iter_18_1 in pairs(var_18_3.episodeMap) do
		if arg_18_1 <= iter_18_1.layer and iter_18_1:isFinished() then
			return true
		end
	end

	return false
end

function var_0_0.notifyView(arg_19_0)
	Season123Controller.instance:dispatchEvent(Season123Event.RefreshResetView)
end

var_0_0.instance = var_0_0.New()

return var_0_0
