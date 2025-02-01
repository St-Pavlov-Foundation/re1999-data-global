module("modules.logic.seasonver.act123.controller.Season123PickAssistController", package.seeall)

slot0 = class("Season123PickAssistController", BaseController)

function slot0.onOpenView(slot0, slot1, slot2, slot3, slot4)
	Season123PickAssistListModel.instance:init(slot1, slot4)

	slot0._finishCall = slot2
	slot0._finishCallObj = slot3
end

function slot0.manualRefreshList(slot0)
	if slot0:checkCanRefresh() then
		slot0:sendRefreshList()
	else
		GameFacade.showToast(ToastEnum.Season123RefreshAssistInCD)
	end
end

function slot0.sendRefreshList(slot0)
	slot0:setHeroSelect()
	slot0:pickOver()
	DungeonRpc.instance:sendRefreshAssistRequest(DungeonEnum.AssistType.Season123, slot0.onRefreshAssist, slot0)
end

function slot0.onRefreshAssist(slot0, slot1, slot2, slot3)
	Season123Controller.instance:dispatchEvent(Season123Event.BeforeRefreshAssistList)
	slot0:recordAssistRefreshTime()
	Season123PickAssistListModel.instance:updateDatas()
end

function slot0.recordAssistRefreshTime(slot0)
	slot0._refreshUnityTime = Time.realtimeSinceStartup
end

function slot0.getRefreshCDRate(slot0)
	if slot0._refreshUnityTime then
		return 1 - math.max(0, math.min(1, (Time.realtimeSinceStartup - slot0._refreshUnityTime) / CommonConfig.instance:getConstNum(ConstEnum.AssistCharacterUpdateInterval)))
	else
		return 0
	end
end

function slot0.checkCanRefresh(slot0)
	return not slot0._refreshUnityTime or CommonConfig.instance:getConstNum(ConstEnum.AssistCharacterUpdateInterval) <= Time.realtimeSinceStartup - slot0._refreshUnityTime
end

function slot0.setCareer(slot0, slot1)
	slot2 = false

	if slot1 ~= Season123PickAssistListModel.instance:getCareer() then
		Season123PickAssistListModel.instance:setCareer(slot1)

		slot2 = true
	end

	return slot2
end

function slot0.setHeroSelect(slot0, slot1, slot2)
	Season123PickAssistListModel.instance:setHeroSelect(slot1, slot2)
	slot0:notifyView()
end

function slot0.pickOver(slot0)
	if slot0._finishCall then
		slot0._finishCall(slot0._finishCallObj, Season123PickAssistListModel.instance:getSelectedMO())
	end
end

function slot0.notifyView(slot0)
	Season123PickAssistListModel.instance:onModelUpdate()
end

function slot0.onCloseView(slot0)
	Season123PickAssistListModel.instance:release()
end

slot0.instance = slot0.New()

return slot0
