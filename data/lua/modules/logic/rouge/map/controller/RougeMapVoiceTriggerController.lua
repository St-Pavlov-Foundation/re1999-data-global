module("modules.logic.rouge.map.controller.RougeMapVoiceTriggerController", package.seeall)

slot0 = class("RougeMapVoiceTriggerController")

function slot0.init(slot0)
	if slot0.inited then
		return
	end

	slot0.inited = true
	slot0.lastTriggerTime = -RougeMapEnum.TalkCD

	RougeMapController.instance:registerCallback(RougeMapEvent.onCreateMapDoneFlowDone, slot0.tryTriggerRecordVoice, slot0)
	RougeMapController.instance:registerCallback(RougeMapEvent.onChangeMapInfo, slot0.onChangeMapInfo, slot0)
	RougeMapController.instance:registerCallback(RougeMapEvent.onExitPieceChoiceEvent, slot0.onExitPieceChoiceEvent, slot0)
	RougeMapController.instance:registerCallback(RougeMapEvent.onAcceptEntrust, slot0.onAcceptEntrust, slot0)
	RougeMapController.instance:registerCallback(RougeMapEvent.onNodeEventStatusChange, slot0.onNodeEventStatusChange, slot0)
	RougeMapController.instance:registerCallback(RougeMapEvent.onMiddleActorBeforeMove, slot0.onMiddleActorBeforeMove, slot0)
	RougeMapController.instance:registerCallback(RougeMapEvent.onNormalActorBeforeMove, slot0.onNormalActorBeforeMove, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0)

	if RougeMapModel.instance:getFirstEnterMapFlag() then
		slot0:tryRecordEnterNormalLayerVoice()
		RougeMapModel.instance:setFirstEnterMap(nil)
	end
end

function slot0.clear(slot0)
	slot0.inited = nil
	slot0.lastTriggerTime = nil

	RougeMapController.instance:unregisterCallback(RougeMapEvent.onCreateMapDoneFlowDone, slot0.tryTriggerRecordVoice, slot0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onChangeMapInfo, slot0.onChangeMapInfo, slot0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onExitPieceChoiceEvent, slot0.onExitPieceChoiceEvent, slot0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onAcceptEntrust, slot0.onAcceptEntrust, slot0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onNodeEventStatusChange, slot0.onNodeEventStatusChange, slot0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onMiddleActorBeforeMove, slot0.onMiddleActorBeforeMove, slot0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onNormalActorBeforeMove, slot0.onNormalActorBeforeMove, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0)
	TaskDispatcher.cancelTask(slot0.endTriggerShortVoice, slot0)
end

function slot0.onChangeMapInfo(slot0)
	if RougeMapModel.instance:getMapType() == RougeMapEnum.MapType.Normal then
		slot0:tryRecordEnterNormalLayerVoice()
	elseif slot1 == RougeMapEnum.MapType.Middle then
		slot0:tryRecordEnterMiddleLayerVoice()
	elseif slot1 == RougeMapEnum.MapType.PathSelect then
		slot0:tryRecordEnterPathSelectLayerVoice()
	end
end

function slot0.onExitPieceChoiceEvent(slot0)
	if not slot0:checkCanTriggerGroup(slot0:getCanTriggerGroup(RougeMapEnum.ShortVoiceTriggerType.ExitPieceTalk)) then
		return
	end

	slot0:recordCurTriggerVoice(slot1.id)
	slot0:tryTriggerRecordVoice()
end

function slot0.onAcceptEntrust(slot0)
	if not RougeMapModel.instance:getEntrustId() then
		return
	end

	if not slot0:checkCanTriggerGroup(slot0:getCanTriggerGroup(RougeMapEnum.ShortVoiceTriggerType.AcceptEntrust)) then
		return
	end

	slot0:recordCurTriggerVoice(slot2.id)
	slot0:tryTriggerRecordVoice()
end

function slot0.onNodeEventStatusChange(slot0, slot1, slot2)
	if slot2 ~= RougeMapEnum.EventState.Finish then
		return
	end

	slot0:tryTriggerFinishEvent(slot1)
end

function slot0.onMiddleActorBeforeMove(slot0)
	if not slot0:checkCanTriggerGroup(slot0:getCanTriggerGroup(RougeMapEnum.ShortVoiceTriggerType.MiddleLayerMove)) then
		return
	end

	slot0:recordCurTriggerVoice(slot1.id)
	slot0:tryTriggerRecordVoice()
end

function slot0.onNormalActorBeforeMove(slot0)
	if not slot0:checkCanTriggerGroup(slot0:getCanTriggerGroup(RougeMapEnum.ShortVoiceTriggerType.NormalLayerMove)) then
		return
	end

	slot0:recordCurTriggerVoice(slot1.id)
	slot0:tryTriggerRecordVoice()
end

function slot0.tryTriggerFinishEvent(slot0, slot1)
	if not RougeMapConfig.instance:getRougeEvent(slot1) then
		return
	end

	if not slot0:checkCanTriggerGroup(slot0:getCanTriggerGroup(RougeMapEnum.ShortVoiceTriggerType.FinishEvent, slot2.type)) then
		return
	end

	slot0:recordCurTriggerVoice(slot3.id)
	slot0:tryTriggerRecordVoice()
end

function slot0.tryRecordEnterNormalLayerVoice(slot0)
	if not slot0:checkCanTriggerGroup(slot0:getCanTriggerGroup(RougeMapEnum.ShortVoiceTriggerType.EnterNormalLayer, RougeMapModel.instance:getLayerId())) then
		return
	end

	slot0:recordCurTriggerVoice(slot2.id)
end

function slot0.tryRecordEnterMiddleLayerVoice(slot0)
	if not slot0:checkCanTriggerGroup(slot0:getCanTriggerGroup(RougeMapEnum.ShortVoiceTriggerType.EnterMiddleLayer, RougeMapModel.instance:getMiddleLayerId())) then
		return
	end

	slot0:recordCurTriggerVoice(slot2.id)
end

function slot0.tryRecordEnterPathSelectLayerVoice(slot0)
	if not slot0:checkCanTriggerGroup(slot0:getCanTriggerGroup(RougeMapEnum.ShortVoiceTriggerType.EnterPathSelectLayer, RougeMapModel.instance:getPathSelectCo() and slot1.id)) then
		return
	end

	slot0:recordCurTriggerVoice(slot3.id)
end

function slot0.onCloseViewFinish(slot0, slot1)
	slot0:tryTriggerRecordVoice()
end

function slot0.tryTriggerRecordVoice(slot0)
	if not slot0.curTriggerGroupId then
		return
	end

	if Time.time - slot0.lastTriggerTime < RougeMapEnum.TalkCD then
		return
	end

	if RougeMapModel.instance:getMapState() ~= RougeMapEnum.MapState.Normal then
		slot0:log(string.format("try trigger groupId : %s, mapState : %s", slot0.curTriggerGroupId, slot2))

		return
	end

	if not RougeMapHelper.checkMapViewOnTop(true) then
		return
	end

	slot3 = RougeMapConfig.instance:getRandomVoice(slot0.curTriggerGroupId)

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onTriggerShortVoice, slot3)
	slot0:log(string.format("trigger voice id : %s, voice desc : %s", slot3.id, slot3.desc))

	slot0.lastTriggerTime = slot1
	slot0.curTriggerGroupId = nil

	TaskDispatcher.runDelay(slot0.endTriggerShortVoice, slot0, RougeMapEnum.TalkDuration)
end

function slot0.endTriggerShortVoice(slot0)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onEndTriggerShortVoice)
end

function slot0.recordCurTriggerVoice(slot0, slot1)
	if Time.time - slot0.lastTriggerTime < RougeMapEnum.TalkCD then
		return
	end

	if slot0.curTriggerGroupId then
		slot0:log(string.format("exist group id ： %s, cover new group id ： %s", slot0.curTriggerGroupId, slot1))
	end

	slot0.curTriggerGroupId = slot1
end

function slot0.getCanTriggerGroup(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(RougeMapConfig.instance:getVoiceGroupList()) do
		if slot8.triggerType == slot1 then
			if slot8.triggerParam == 0 then
				slot0:logTriggerGroup(slot8)

				return slot8
			elseif slot10 == slot2 then
				slot0:logTriggerGroup(slot8)

				return slot8
			end
		end
	end
end

function slot0.logTriggerGroup(slot0, slot1)
	slot0:log(string.format("trigger group id " .. tostring(slot1.id)))
end

function slot0.log(slot0, slot1)
	logNormal("[地图语音]" .. tostring(slot1))
end

function slot0.checkCanTriggerGroup(slot0, slot1)
	if not slot1 then
		return false
	end

	if slot1.rate >= 1000 then
		return true
	end

	return math.random(1000) <= slot2
end

slot0.instance = slot0.New()

return slot0
