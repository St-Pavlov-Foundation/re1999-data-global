module("modules.logic.rouge.map.controller.RougeMapVoiceTriggerController", package.seeall)

local var_0_0 = class("RougeMapVoiceTriggerController")

function var_0_0.init(arg_1_0)
	if arg_1_0.inited then
		return
	end

	arg_1_0.inited = true
	arg_1_0.lastTriggerTime = -RougeMapEnum.TalkCD

	RougeMapController.instance:registerCallback(RougeMapEvent.onCreateMapDoneFlowDone, arg_1_0.tryTriggerRecordVoice, arg_1_0)
	RougeMapController.instance:registerCallback(RougeMapEvent.onChangeMapInfo, arg_1_0.onChangeMapInfo, arg_1_0)
	RougeMapController.instance:registerCallback(RougeMapEvent.onExitPieceChoiceEvent, arg_1_0.onExitPieceChoiceEvent, arg_1_0)
	RougeMapController.instance:registerCallback(RougeMapEvent.onAcceptEntrust, arg_1_0.onAcceptEntrust, arg_1_0)
	RougeMapController.instance:registerCallback(RougeMapEvent.onNodeEventStatusChange, arg_1_0.onNodeEventStatusChange, arg_1_0)
	RougeMapController.instance:registerCallback(RougeMapEvent.onMiddleActorBeforeMove, arg_1_0.onMiddleActorBeforeMove, arg_1_0)
	RougeMapController.instance:registerCallback(RougeMapEvent.onNormalActorBeforeMove, arg_1_0.onNormalActorBeforeMove, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_1_0.onCloseViewFinish, arg_1_0)

	if RougeMapModel.instance:getFirstEnterMapFlag() then
		arg_1_0:tryRecordEnterNormalLayerVoice()
		RougeMapModel.instance:setFirstEnterMap(nil)
	end
end

function var_0_0.clear(arg_2_0)
	arg_2_0.inited = nil
	arg_2_0.lastTriggerTime = nil

	RougeMapController.instance:unregisterCallback(RougeMapEvent.onCreateMapDoneFlowDone, arg_2_0.tryTriggerRecordVoice, arg_2_0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onChangeMapInfo, arg_2_0.onChangeMapInfo, arg_2_0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onExitPieceChoiceEvent, arg_2_0.onExitPieceChoiceEvent, arg_2_0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onAcceptEntrust, arg_2_0.onAcceptEntrust, arg_2_0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onNodeEventStatusChange, arg_2_0.onNodeEventStatusChange, arg_2_0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onMiddleActorBeforeMove, arg_2_0.onMiddleActorBeforeMove, arg_2_0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onNormalActorBeforeMove, arg_2_0.onNormalActorBeforeMove, arg_2_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_2_0.onCloseViewFinish, arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0.endTriggerShortVoice, arg_2_0)
end

function var_0_0.onChangeMapInfo(arg_3_0)
	local var_3_0 = RougeMapModel.instance:getMapType()

	if var_3_0 == RougeMapEnum.MapType.Normal then
		arg_3_0:tryRecordEnterNormalLayerVoice()
	elseif var_3_0 == RougeMapEnum.MapType.Middle then
		arg_3_0:tryRecordEnterMiddleLayerVoice()
	elseif var_3_0 == RougeMapEnum.MapType.PathSelect then
		arg_3_0:tryRecordEnterPathSelectLayerVoice()
	end
end

function var_0_0.onExitPieceChoiceEvent(arg_4_0)
	local var_4_0 = arg_4_0:getCanTriggerGroup(RougeMapEnum.ShortVoiceTriggerType.ExitPieceTalk)

	if not arg_4_0:checkCanTriggerGroup(var_4_0) then
		return
	end

	arg_4_0:recordCurTriggerVoice(var_4_0.id)
	arg_4_0:tryTriggerRecordVoice()
end

function var_0_0.onAcceptEntrust(arg_5_0)
	if not RougeMapModel.instance:getEntrustId() then
		return
	end

	local var_5_0 = arg_5_0:getCanTriggerGroup(RougeMapEnum.ShortVoiceTriggerType.AcceptEntrust)

	if not arg_5_0:checkCanTriggerGroup(var_5_0) then
		return
	end

	arg_5_0:recordCurTriggerVoice(var_5_0.id)
	arg_5_0:tryTriggerRecordVoice()
end

function var_0_0.onNodeEventStatusChange(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_2 ~= RougeMapEnum.EventState.Finish then
		return
	end

	arg_6_0:tryTriggerFinishEvent(arg_6_1)
end

function var_0_0.onMiddleActorBeforeMove(arg_7_0)
	local var_7_0 = arg_7_0:getCanTriggerGroup(RougeMapEnum.ShortVoiceTriggerType.MiddleLayerMove)

	if not arg_7_0:checkCanTriggerGroup(var_7_0) then
		return
	end

	arg_7_0:recordCurTriggerVoice(var_7_0.id)
	arg_7_0:tryTriggerRecordVoice()
end

function var_0_0.onNormalActorBeforeMove(arg_8_0)
	local var_8_0 = arg_8_0:getCanTriggerGroup(RougeMapEnum.ShortVoiceTriggerType.NormalLayerMove)

	if not arg_8_0:checkCanTriggerGroup(var_8_0) then
		return
	end

	arg_8_0:recordCurTriggerVoice(var_8_0.id)
	arg_8_0:tryTriggerRecordVoice()
end

function var_0_0.tryTriggerFinishEvent(arg_9_0, arg_9_1)
	local var_9_0 = RougeMapConfig.instance:getRougeEvent(arg_9_1)

	if not var_9_0 then
		return
	end

	local var_9_1 = arg_9_0:getCanTriggerGroup(RougeMapEnum.ShortVoiceTriggerType.FinishEvent, var_9_0.type)

	if not arg_9_0:checkCanTriggerGroup(var_9_1) then
		return
	end

	arg_9_0:recordCurTriggerVoice(var_9_1.id)
	arg_9_0:tryTriggerRecordVoice()
end

function var_0_0.tryRecordEnterNormalLayerVoice(arg_10_0)
	local var_10_0 = RougeMapModel.instance:getLayerId()
	local var_10_1 = arg_10_0:getCanTriggerGroup(RougeMapEnum.ShortVoiceTriggerType.EnterNormalLayer, var_10_0)

	if not arg_10_0:checkCanTriggerGroup(var_10_1) then
		return
	end

	arg_10_0:recordCurTriggerVoice(var_10_1.id)
end

function var_0_0.tryRecordEnterMiddleLayerVoice(arg_11_0)
	local var_11_0 = RougeMapModel.instance:getMiddleLayerId()
	local var_11_1 = arg_11_0:getCanTriggerGroup(RougeMapEnum.ShortVoiceTriggerType.EnterMiddleLayer, var_11_0)

	if not arg_11_0:checkCanTriggerGroup(var_11_1) then
		return
	end

	arg_11_0:recordCurTriggerVoice(var_11_1.id)
end

function var_0_0.tryRecordEnterPathSelectLayerVoice(arg_12_0)
	local var_12_0 = RougeMapModel.instance:getPathSelectCo()
	local var_12_1 = var_12_0 and var_12_0.id
	local var_12_2 = arg_12_0:getCanTriggerGroup(RougeMapEnum.ShortVoiceTriggerType.EnterPathSelectLayer, var_12_1)

	if not arg_12_0:checkCanTriggerGroup(var_12_2) then
		return
	end

	arg_12_0:recordCurTriggerVoice(var_12_2.id)
end

function var_0_0.onCloseViewFinish(arg_13_0, arg_13_1)
	arg_13_0:tryTriggerRecordVoice()
end

function var_0_0.tryTriggerRecordVoice(arg_14_0)
	if not arg_14_0.curTriggerGroupId then
		return
	end

	local var_14_0 = Time.time

	if var_14_0 - arg_14_0.lastTriggerTime < RougeMapEnum.TalkCD then
		return
	end

	local var_14_1 = RougeMapModel.instance:getMapState()

	if var_14_1 ~= RougeMapEnum.MapState.Normal then
		arg_14_0:log(string.format("try trigger groupId : %s, mapState : %s", arg_14_0.curTriggerGroupId, var_14_1))

		return
	end

	if not RougeMapHelper.checkMapViewOnTop(true) then
		return
	end

	local var_14_2 = RougeMapConfig.instance:getRandomVoice(arg_14_0.curTriggerGroupId)

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onTriggerShortVoice, var_14_2)
	arg_14_0:log(string.format("trigger voice id : %s, voice desc : %s", var_14_2.id, var_14_2.desc))

	arg_14_0.lastTriggerTime = var_14_0
	arg_14_0.curTriggerGroupId = nil

	TaskDispatcher.runDelay(arg_14_0.endTriggerShortVoice, arg_14_0, RougeMapEnum.TalkDuration)
end

function var_0_0.endTriggerShortVoice(arg_15_0)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onEndTriggerShortVoice)
end

function var_0_0.recordCurTriggerVoice(arg_16_0, arg_16_1)
	if Time.time - arg_16_0.lastTriggerTime < RougeMapEnum.TalkCD then
		return
	end

	if arg_16_0.curTriggerGroupId then
		arg_16_0:log(string.format("exist group id ： %s, cover new group id ： %s", arg_16_0.curTriggerGroupId, arg_16_1))
	end

	arg_16_0.curTriggerGroupId = arg_16_1
end

function var_0_0.getCanTriggerGroup(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = RougeMapConfig.instance:getVoiceGroupList()

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		if iter_17_1.triggerType == arg_17_1 then
			local var_17_1 = iter_17_1.triggerParam

			if var_17_1 == 0 then
				arg_17_0:logTriggerGroup(iter_17_1)

				return iter_17_1
			elseif var_17_1 == arg_17_2 then
				arg_17_0:logTriggerGroup(iter_17_1)

				return iter_17_1
			end
		end
	end
end

function var_0_0.logTriggerGroup(arg_18_0, arg_18_1)
	arg_18_0:log(string.format("trigger group id " .. tostring(arg_18_1.id)))
end

function var_0_0.log(arg_19_0, arg_19_1)
	logNormal("[地图语音]" .. tostring(arg_19_1))
end

function var_0_0.checkCanTriggerGroup(arg_20_0, arg_20_1)
	if not arg_20_1 then
		return false
	end

	local var_20_0 = arg_20_1.rate

	if var_20_0 >= 1000 then
		return true
	end

	return var_20_0 >= math.random(1000)
end

var_0_0.instance = var_0_0.New()

return var_0_0
