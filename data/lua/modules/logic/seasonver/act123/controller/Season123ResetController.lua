module("modules.logic.seasonver.act123.controller.Season123ResetController", package.seeall)

slot0 = class("Season123ResetController", BaseController)

function slot0.onOpenView(slot0, slot1, slot2, slot3)
	Season123Controller.instance:registerCallback(Season123Event.GetActInfo, slot0.handleGetActInfo, slot0)
	Season123Controller.instance:registerCallback(Season123Event.StageInfoChanged, slot0.handleStageInfoChange, slot0)
	Season123ResetModel.instance:init(slot1, slot2, slot3)
	Season123Controller.instance:checkAndHandleEffectEquip({
		actId = slot1,
		stage = slot2,
		layer = slot3
	})
end

function slot0.onCloseView(slot0)
	Season123Controller.instance:unregisterCallback(Season123Event.GetActInfo, slot0.handleGetActInfo, slot0)
	Season123Controller.instance:unregisterCallback(Season123Event.StageInfoChanged, slot0.handleStageInfoChange, slot0)
	Season123ResetModel.instance:release()
end

function slot0.selectLayer(slot0, slot1)
	if slot1 == Season123ResetModel.instance.layer then
		return
	end

	if slot1 == nil then
		Season123ResetModel.instance.layer = nil
	elseif slot1 == Season123ResetModel.EmptySelect then
		Season123ResetModel.instance.layer = slot1
	elseif Season123ResetModel.instance:getById(slot1).isFinished then
		Season123ResetModel.instance.layer = slot1
	else
		return
	end

	Season123ResetModel.instance:updateHeroList()
	slot0:notifyView()

	return true
end

function slot0.tryReset(slot0)
	if Season123ResetModel.instance.layer then
		if Season123ResetModel.instance.layer ~= Season123ResetModel.EmptySelect then
			slot0:trySendResetLayer()
		end
	else
		slot0:trySendResetStage()
	end
end

function slot0.trySendResetStage(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Season123ResetConfirm, MsgBoxEnum.BoxType.Yes_No, slot0.receiveResetStage, nil, , slot0)
end

function slot0.receiveResetStage(slot0)
	Activity123Rpc.instance:sendAct123EndStageRequest(Season123ResetModel.instance.activityId, Season123ResetModel.instance.stage, slot0.receiveResetFinish, slot0)
end

function slot0.trySendResetLayer(slot0)
	if slot0:isStageNeedClean(Season123ResetModel.instance.stage) then
		GameFacade.showMessageBox(MessageBoxIdDefine.Season123WarningCleanStage, MsgBoxEnum.BoxType.Yes_No, slot0.checkCleanNextLayers, nil, , slot0, nil, )

		return
	end

	slot0:checkCleanNextLayers()
end

function slot0.checkCleanNextLayers(slot0)
	if slot0:isNextLayersNeedClean(Season123ResetModel.instance.layer) then
		GameFacade.showMessageBox(MessageBoxIdDefine.Season123WarningCleanLayer, MsgBoxEnum.BoxType.Yes_No, slot0.startSendResetLayer, nil, , slot0, nil, )

		return
	end

	slot0:startSendResetLayer()
end

function slot0.startSendResetLayer(slot0)
	slot3 = Season123ResetModel.instance.layer

	if slot0:isStageNeedClean(Season123ResetModel.instance.stage) then
		Activity123Rpc.instance:sendAct123ResetOtherStageRequest(Season123ResetModel.instance.activityId, slot2, slot0.receiveResetOtherStage, slot0)

		return
	end

	slot0:handleResetOtherStage()
end

function slot0.receiveResetOtherStage(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		slot0:handleResetOtherStage()
	end
end

function slot0.handleResetOtherStage(slot0)
	slot2 = Season123ResetModel.instance.stage
	slot3 = Season123ResetModel.instance.layer

	if not Season123Model.instance:getActInfo(Season123ResetModel.instance.activityId) then
		return
	end

	if not slot4:getStageMO(slot2) then
		return
	end

	if slot5.episodeMap[slot3] and slot5.episodeMap[slot3]:isFinished() then
		Activity123Rpc.instance:sendAct123ResetHighLayerRequest(slot1, slot2, slot3, slot0.receiveResetFinish, slot0)

		return
	end

	slot0:notifyResetFinish()
end

function slot0.receiveResetFinish(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		slot0:notifyResetFinish()
	end
end

function slot0.notifyResetFinish(slot0)
	GameFacade.showToast(ToastEnum.WeekwalkResetLayer)
	Activity123Rpc.instance:sendGet123InfosRequest(Season123ResetModel.instance.activityId)
	Season123Controller.instance:dispatchEvent(Season123Event.OnResetSucc)
end

function slot0.handleGetActInfo(slot0)
	slot0:updateModel()
end

function slot0.handleStageInfoChange(slot0)
	slot0:updateModel()
end

function slot0.updateModel(slot0)
	Season123ResetModel.instance:initEpisodeList()

	if Season123ResetModel.instance.layer and not Season123ResetModel.instance:getById(slot1).isFinished then
		Season123ResetModel.instance.layer = Season123ResetModel.instance:getCurrentChallengeLayer()
	end

	Season123ResetModel.instance:updateHeroList()
	slot0:notifyView()
end

function slot0.isStageNeedClean(slot0, slot1)
	slot3 = Season123ResetModel.instance.stage

	if not Season123Model.instance:getActInfo(Season123ResetModel.instance.activityId) then
		return false
	end

	return slot4.stage ~= 0 and slot4.stage ~= slot1
end

function slot0.isNextLayersNeedClean(slot0, slot1)
	slot3 = Season123ResetModel.instance.stage

	if not Season123Model.instance:getActInfo(Season123ResetModel.instance.activityId) then
		return false
	end

	if not slot4.stageMap[slot3] or not slot5.episodeMap then
		return false
	end

	for slot9, slot10 in pairs(slot5.episodeMap) do
		if slot1 <= slot10.layer and slot10:isFinished() then
			return true
		end
	end

	return false
end

function slot0.notifyView(slot0)
	Season123Controller.instance:dispatchEvent(Season123Event.RefreshResetView)
end

slot0.instance = slot0.New()

return slot0
